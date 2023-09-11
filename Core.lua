--[[
    Created by Slothpala 
--]]
MouseoverActionBars = LibStub("AceAddon-3.0"):NewAddon("MouseoverActionBars", "AceConsole-3.0", "AceTimer-3.0", "AceEvent-3.0")
MouseoverActionBars:SetDefaultModuleLibraries("AceEvent-3.0")
MouseoverActionBars:SetDefaultModuleState(false)
local AC   = LibStub("AceConfig-3.0")
local ACD  = LibStub("AceConfigDialog-3.0")
local LDS  = LibStub("LibDualSpec-1.0")

function MouseoverActionBars:OnInitialize()
    self:LoadDataBase()
end

function MouseoverActionBars:OnEnable()
    --load own options table
    local options = self:GetOptionsTable()
    --create option table based on database structure and add them to options
    options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db) 
    --register options as option table to create a gui based on it
    AC:RegisterOptionsTable("MouseoverActionBars_options", options) 
    ACD:SetDefaultSize("MouseoverActionBars_options",700,500)
    --add them to blizzards settings panel for addons
    self.optionsFrame = ACD:AddToBlizOptions("MouseoverActionBars_options", "MouseoverActionBars")
    --add dual specc support 
    LDS:EnhanceDatabase(self.db, "MouseoverActionBars") 
    LDS:EnhanceOptions(options.args.profile, self.db) 
    self:RegisterChatCommand("mbars", "SlashCommand")
    self:LoadConfig()
end

function MouseoverActionBars:SlashCommand()
    ACD:Open("MouseoverActionBars_options")
end

local enableAlways = {}
enableAlways["HideStanceBar"] = true

function MouseoverActionBars:LoadConfig()  
    for _, module in self:IterateModules() do
        if self.db.profile.Module[module:GetName()] or enableAlways[module:GetName()] then
            module:Enable()
        end
    end
    self:ApplyLinks()
    self:Combat(InCombatLockdown())
end

local updateQueued = false
function MouseoverActionBars:ReloadConfig()
    if not updateQueued then
        updateQueued = true
        C_Timer.After(0.25, function()
            MouseoverActionBars:CancelAllTimers()
            for _, module in MouseoverActionBars:IterateModules() do
                module:Disable()
            end
            MouseoverActionBars:ClearCache()
            MouseoverActionBars:LoadConfig()
            updateQueued = false
        end)
    end
end
--getter/setter functions that will save and call settings into/from the db
--status
function MouseoverActionBars:GetStatus(info)
    return self.db.profile[info[#info-2]][info[#info-1]][info[#info]]
end
function MouseoverActionBars:SetStatus(info,value)
    self.db.profile[info[#info-2]][info[#info-1]][info[#info]] = value
    --will reload the config each time the settings have been adjusted
    self:ReloadConfig()
end
--for modules having this seperated makes it easier to iterate modules 
function MouseoverActionBars:GetModuleStatus(info)
    return self.db.profile.Module[info[#info]]
end
function MouseoverActionBars:SetModuleStatus(info,value)
    self.db.profile.Module[info[#info]] = value
    --will reload the config each time the settings have been adjusted
    self:ReloadConfig()
end
--local functions
--tables containing the information about active hooks
local hooked = {}
local hookstate = {}
local function donothing()end
--fade out timers for the respective action bars
local ABTimer1
--creating meta mousover unit
local MouseoverUnit = {}
MouseoverUnit.Name = "meta"
MouseoverUnit.Timer = ABTimer1
MouseoverUnit.Components = {} --all regions that need to be hooked for mouse events e.g the action buttons on an action bar
MouseoverUnit.Parent = nil --the parent frame to be hidden e.g. the action bar itself
MouseoverUnit.Combat = nil
MouseoverUnit.Links = {} --links to other MouseoverUnit units
MouseoverUnit.LinksPresent = false
MouseoverUnit.maxalpha = 1
MouseoverUnit.minalpha = 0
MouseoverUnit.fadeouttimer = 2

function MouseoverUnit:RestoreHide()
    if not self.Parent.MOUSEOVERACTIONBARS_ANIMATION_GROUP then
        self.Parent.MOUSEOVERACTIONBARS_ANIMATION_GROUP = self.Parent:CreateAnimationGroup()
        self.Parent.MOUSEOVERACTIONBARS_ANIMATION_GROUP:SetToFinalAlpha(true)
        self.Parent.MOUSEOVERACTIONBARS_ALPHA_ANIMATION = self.Parent.MOUSEOVERACTIONBARS_ANIMATION_GROUP:CreateAnimation("Alpha")
        self.Parent.MOUSEOVERACTIONBARS_ALPHA_ANIMATION:SetDuration(0.2)
    end
    self.Parent.MOUSEOVERACTIONBARS_ALPHA_ANIMATION:SetFromAlpha(self.maxalpha)
    self.Parent.MOUSEOVERACTIONBARS_ALPHA_ANIMATION:SetToAlpha(self.minalpha)
    self.Parent.MOUSEOVERACTIONBARS_ANIMATION_GROUP:Play()
end
MouseoverUnit.Hide = MouseoverUnit.RestoreHide
function MouseoverUnit:RestoreShow()
    self.Parent.MOUSEOVERACTIONBARS_ANIMATION_GROUP:Stop()
    self.Parent:SetAlpha(self.maxalpha)
end
MouseoverUnit.Show = MouseoverUnit.RestoreShow
MouseoverUnit.metatable = {__index = MouseoverUnit}
--constructor
function MouseoverActionBars:NewMouseoverUnit(newUnit)
    setmetatable(newUnit, MouseoverUnit.metatable)
    return newUnit
end

--register / unregister MouseoverUnits for events
--on enter -> show
function MouseoverActionBars:RegisterOnEnter(mouseoverunit)
    if not hooked[mouseoverunit.Name] then hooked[mouseoverunit.Name] = {};hookstate[mouseoverunit.Name] = {} end
    if not hooked[mouseoverunit.Name].OnEnter then
        for i = 1, #mouseoverunit.Components do
            mouseoverunit.Components[i]:HookScript("OnEnter", function() 
                self:CancelTimer(mouseoverunit.Timer)
                mouseoverunit:Show() 
                if mouseoverunit.LinksPresent then
                    for i=1, #mouseoverunit.Links do
                        self:CancelTimer(mouseoverunit.Links[i].Timer)
                        mouseoverunit.Links[i]:Show()
                    end
                end
            end)
        end
        hooked[mouseoverunit.Name].OnEnter = true
        hookstate[mouseoverunit.Name].OnEnter = true
    else
        mouseoverunit.Show = mouseoverunit.RestoreShow
        hookstate[mouseoverunit.Name].OnEnter = true
    end
end

function MouseoverActionBars:UnregisterOnEnter(mouseoverunit)
    mouseoverunit.Show = donothing
    if hookstate[mouseoverunit.Name] then
        hookstate[mouseoverunit.Name].OnEnter = false
    end
end
--on leave -> hide
function MouseoverActionBars:RegisterOnLeave(mouseoverunit)
    if not hooked[mouseoverunit.Name] then hooked[mouseoverunit.Name] = {};hookstate[mouseoverunit.Name] = {} end
    if not hooked[mouseoverunit.Name].OnLeave then
        for i = 1, #mouseoverunit.Components do
            mouseoverunit.Components[i]:HookScript("OnLeave", function() 
                mouseoverunit.Timer = self:ScheduleTimer(function() mouseoverunit:Hide() end,mouseoverunit.fadeouttimer) 
                if mouseoverunit.LinksPresent then
                    for i=1, #mouseoverunit.Links do
                        mouseoverunit.Links[i].Timer = self:ScheduleTimer(function() mouseoverunit.Links[i]:Hide() end,mouseoverunit.fadeouttimer)  
                    end
                end
            end)
        end
        hooked[mouseoverunit.Name].OnLeave = true
        hookstate[mouseoverunit.Name].OnLeave = true
    else
        mouseoverunit.Hide = mouseoverunit.RestoreHide
        hookstate[mouseoverunit.Name].OnLeave = true
    end
end

function MouseoverActionBars:UnregisterOnLeave(mouseoverunit)
    mouseoverunit.Hide = donothing
    if hookstate[mouseoverunit.Name] then
        hookstate[mouseoverunit.Name].OnLeave = false
    end
end
--register actually loaded units
local registered_units = {}
local registered_modules = {}
function MouseoverActionBars:Register(mouseoverunit, modulename)
    registered_units[modulename] = mouseoverunit
    registered_modules[#registered_modules+1] = modulename
end
--apply links
--link MouseoverUnits
function MouseoverActionBars:Link(mouseoverunit,link_with_mouseoverunit)
    mouseoverunit.LinksPresent = true
    mouseoverunit.Links[#mouseoverunit.Links + 1] = link_with_mouseoverunit
end
--
local numlinkgrouops = 12
function MouseoverActionBars:ApplyLinks()
    for i=1, #registered_modules do
        for n=1,numlinkgrouops do 
            local Link = self.db.profile.LinkedGroups["LinkedGroup"..string.match(registered_modules[i],"%d+")]["ActionBar"..n]
            if Link and registered_units["ActionBar"..n] then 
                MouseoverActionBars:Link(registered_units[registered_modules[i]] ,registered_units["ActionBar"..n])
            end
        end
    end
end

--exceptions
--combat
local CombatEventsRegistered = nil
local registered_combat_units = {}
function MouseoverActionBars:RegisterInCombat(mouseoverunit)
    if not  CombatEventsRegistered then 
        MouseoverActionBars:RegisterEvent("PLAYER_REGEN_DISABLED","Combat",true)
        MouseoverActionBars:RegisterEvent("PLAYER_REGEN_ENABLED","Combat",false)
        CombatEventsRegistered = true
    end
    mouseoverunit.Combat = true
    registered_combat_units[#registered_combat_units+1] = mouseoverunit
end

function MouseoverActionBars:Combat(InCombat)
    if InCombat then    
        for i=1, #registered_combat_units do
            registered_combat_units[i]:RestoreShow()
            self:UnregisterOnEnter(registered_combat_units[i])
            self:UnregisterOnLeave(registered_combat_units[i])
        end
    else
        for i=1, #registered_combat_units do
            registered_combat_units[i]:RestoreHide()
            self:RegisterOnEnter(registered_combat_units[i])
            self:RegisterOnLeave(registered_combat_units[i])
        end
    end
end
--general purpose functiion
function MouseoverActionBars:ShowGrid()
    for _,mouseoverunit in pairs (registered_units) do
        MouseoverActionBars:UnregisterOnEnter(mouseoverunit)
        MouseoverActionBars:UnregisterOnLeave(mouseoverunit)
        mouseoverunit:RestoreShow() 
    end
end
function MouseoverActionBars:HideGrid()
    for _,mouseoverunit in pairs (registered_units) do
        MouseoverActionBars:RegisterOnEnter(mouseoverunit)
        MouseoverActionBars:RegisterOnLeave(mouseoverunit)
        mouseoverunit:RestoreHide() 
    end
end
--define conditions to show the actionbars anayways 
MouseoverActionBars:RegisterEvent("ACTIONBAR_SHOWGRID", "ShowGrid")
MouseoverActionBars:RegisterEvent("ACTIONBAR_HIDEGRID", "HideGrid")
QuickKeybindFrame:HookScript("OnShow", function() MouseoverActionBars:ShowGrid() end)
QuickKeybindFrame:HookScript("OnHide", function() MouseoverActionBars:HideGrid() end)

function MouseoverActionBars:ClearCache()
    registered_units = {}
    registered_modules = {}
    registered_combat_units = {}
    MouseoverActionBars:UnregisterEvent("PLAYER_REGEN_DISABLED")
    MouseoverActionBars:UnregisterEvent("PLAYER_REGEN_ENABLED")
    CombatEventsRegistered = nil
end

--[[
    Hide
--]]
local HideUnit = {}
HideUnit.Name = "meta"
HideUnit.Components = {}
function HideUnit:RestoreHide(i)
    if self.Components[i]:IsProtected() then return end
    self.Components[i]:Hide()
end
HideUnit.Hide = HideUnit.RestoreHide
HideUnit.metatable = {__index = HideUnit}
--constructor
function MouseoverActionBars:NewHideUnit(newUnit)
    setmetatable(newUnit, HideUnit.metatable)
    return newUnit
end

function MouseoverActionBars:Hide(hideunit)
    if not hooked[hideunit.Name] then
        for i=1, #hideunit.Components do 
            hideunit.Components[i]:HookScript("OnShow", function() hideunit:Hide(i) end)
            hideunit.Components[i]:Hide()
        end
        hooked[hideunit.Name] = true
        hookstate[hideunit.Name] = true
    else
        hideunit.Hide = hideunit.RestoreHide
        for i=1, #hideunit.Components do 
            hideunit.Components[i]:Hide()
        end
        hookstate[hideunit.Name] = true
    end
end

function MouseoverActionBars:Show(hideunit)
    hideunit.Hide = donothing
    for i=1, #hideunit.Components do 
        hideunit.Components[i]:Show()
    end
    if hookstate[hideunit.Name] then
        hookstate[hideunit.Name] = false
    end
end

--[[
    Spellfylout
--]]
local actionbars = {
    ["MainMenuBar"]         =  "ActionBar1",
    ["MultiBarBottomLeft"]  =  "ActionBar2",
    ["MultiBarBottomRight"] =  "ActionBar3",
    ["MultiBarRight"]       =  "ActionBar4",
    ["MultiBarLeft"]        =  "ActionBar5",
    ["MultiBar5"]           =  "ActionBar6",
    ["MultiBar6"]           =  "ActionBar7",
    ["MultiBar7"]           =  "ActionBar8",
}

local spellfyloutParent
local registeredParent 
local shouldHandleFlyoutHide = false

SpellFlyout:HookScript("OnShow",function(self) 
    spellfyloutParent = self:GetParent():GetParent():GetParent():GetDebugName()
    registeredParent  = registered_units[actionbars[spellfyloutParent]]
    if registeredParent then
        registeredParent:RestoreShow()
        MouseoverActionBars:UnregisterOnEnter(registeredParent)
        MouseoverActionBars:UnregisterOnLeave(registeredParent)
        shouldHandleFlyoutHide = true
    end
end)

SpellFlyout:HookScript("OnHide",function(self) 
    if shouldHandleFlyoutHide then
        registeredParent:RestoreHide()
        MouseoverActionBars:RegisterOnEnter(registeredParent)
        MouseoverActionBars:RegisterOnLeave(registeredParent)
        shouldHandleFlyoutHide = false
    end
end)

