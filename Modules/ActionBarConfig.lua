local _, addonTable = ...
local addon = addonTable.addon

local module = addon:NewModule("ActionBarConfig")
Mixin(module, addonTable.hooks)

local actionBars = {
    "Action", --MainMenuBar Buttons are not named after parent
    "MultiBarBottomLeft",
    "MultiBarBottomRight",
    "MultiBarRight",
    "MultiBarLeft",
    "MultiBar5",
    "MultiBar6",
    "MultiBar7",
}

function module:OnEnable()
    local dbObj = addon.db.profile.ActionBarConfig
    for _, actionBar in pairs (actionBars) do 
        if dbObj[actionBar] then
            self:UpdateButtonTextVisibility(actionBar, dbObj.hideHotkey, dbObj.hideCount, dbObj.hideName)
        end
    end
end

function module:OnDisable()
    self:DisableHooks()
    for _, actionBar in pairs (actionBars) do 
        self:UpdateButtonTextVisibility(actionBar, false, false, false)
    end
end

function module:UpdateButtonTextVisibility(actionBar, hideHotkey, hideCount, hideName)
    for actionButton = 1, 12 do 
        local hotKeyTxt = _G[actionBar .. "Button" .. actionButton .. "HotKey"]
        if hideHotkey then
            hotKeyTxt:SetAlpha(0)
            self:HookScript(hotKeyTxt, "OnShow", function()
                hotKeyTxt:SetAlpha(0)
            end)
        else
            hotKeyTxt:SetAlpha(1)
        end
        local countTxt = _G[actionBar .. "Button" .. actionButton .. "Count"]
        if hideCount then
            countTxt:SetAlpha(0)
            self:HookScript(countTxt, "OnShow", function()
                countTxt:SetAlpha(0)
            end)
        else
            countTxt:SetAlpha(1)
        end
        local nameTxt = _G[actionBar .. "Button" .. actionButton .. "Name"]
        if hideName then
            nameTxt:SetAlpha(0)
            self:HookScript(nameTxt, "OnShow", function()
                nameTxt:SetAlpha(0)
            end)
        else
            nameTxt:SetAlpha(1)
        end
    end
end