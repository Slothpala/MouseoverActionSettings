--[[
    Created by Slothpala 
--]]
local ActionBar1 = MouseoverActionBars:NewModule("ActionBar1")
local AB1 = {}
local timer

function ActionBar1:OnEnable()
    AB1 = MouseoverActionBars:NewMouseoverUnit(AB1)
    AB1.Components = {}
    for i=1,12 do
        AB1.Components[i] = _G["ActionButton" ..i]
    end
    for _,v in pairs ({
        MainMenuBar.EndCaps.LeftEndCap,
        MainMenuBar.EndCaps.RightEndCap,
        MainMenuBar.BorderArt,
        MainMenuBar.Background,
        MainMenuBar.ActionBarPageNumber
    })
    do
        AB1.Components[#AB1.Components+1] = v
    end
    AB1.Links = {} 
    AB1.Name = "AB1"
    AB1.Timer = timer
    AB1.maxalpha     = MouseoverActionBars.db.profile.ActionBars.AB1.maxalpha
    AB1.minalpha     = MouseoverActionBars.db.profile.ActionBars.AB1.minalpha
    AB1.fadeouttimer = MouseoverActionBars.db.profile.ActionBars.AB1.fadeouttimer
    MouseoverActionBars:RegisterOnEnter(AB1)
    MouseoverActionBars:RegisterOnLeave(AB1)
    MouseoverActionBars:Register(AB1,"ActionBar1")
    AB1:Hide()
    if MouseoverActionBars.db.profile.Config.Exceptions.Dragonriding then
        self:RegisterEvent("PLAYER_MOUNT_DISPLAY_CHANGED","Dragonriding")
        self:RegisterEvent("PLAYER_ENTERING_WORLD",function(self,arg1) 
            if arg1 then
                --arg1 == inital login we have to wait for data
                C_Timer.After(2,function() ActionBar1:Dragonriding() end)
            else
                ActionBar1:Dragonriding()
            end
        end)
        self:Dragonriding()
    end
    if MouseoverActionBars.db.profile.Config.Combat.Combat1 then
        MouseoverActionBars:RegisterInCombat(AB1)
    end
end

function ActionBar1:OnDisable()
    MouseoverActionBars:UnregisterOnEnter(AB1)
    MouseoverActionBars:UnregisterOnLeave(AB1)
    AB1.maxalpha = 1
    AB1.minalpha = 1
    AB1.LinksPresent = false
    AB1.Links = {} 
    AB1:RestoreShow() 
    self:UnregisterEvent("PLAYER_MOUNT_DISPLAY_CHANGED")
end

--dragonriding 
function ActionBar1:Dragonriding()
    local isDragonriding = false
    local dragons = C_MountJournal.GetCollectedDragonridingMounts()
    if IsMounted() then
        for _, dragon in ipairs(dragons) do
            local spellId = select(2, C_MountJournal.GetMountInfoByID(dragon))
            if C_UnitAuras.GetPlayerAuraBySpellID(spellId) then
                isDragonriding = true
            end
        end
    end
    if isDragonriding then
        AB1:RestoreShow()
        MouseoverActionBars:UnregisterOnEnter(AB1)
        MouseoverActionBars:UnregisterOnLeave(AB1)
    else
        if AB1.Combat and InCombatLockdown() then return end
        AB1:RestoreHide()
        MouseoverActionBars:RegisterOnEnter(AB1)
        MouseoverActionBars:RegisterOnLeave(AB1)
    end
end