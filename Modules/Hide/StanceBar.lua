--[[
    Created by Slothpala 
--]]
local HideStanceBar = MouseoverActionBars:NewModule("HideStanceBar")
local HiddenParent = nil
local message = ""

function HideStanceBar:OnEnable()
    if MouseoverActionBars.db.profile.Module.HideStanceBar then 
        if InCombatLockdown() then self:Combat("hide") return end  
        if not HiddenParent then HiddenParent = CreateFrame("Frame") end
        HiddenParent:Hide()
        StanceBar:SetParent(HiddenParent)
    else
        if InCombatLockdown() then self:Combat("show") return end  
        if HiddenParent then 
            HiddenParent:Show()
        end
    end
end

function HideStanceBar:OnDisable()

end

function HideStanceBar:Combat(state)
    if not message:match(state) then
        MouseoverActionBars:Print("The Stance Bar will "..state.." when you leave combat")
        message = state
    end
    self:RegisterEvent("PLAYER_REGEN_ENABLED", function() HideStanceBar:AfterCombat(state) end)
end

function HideStanceBar:AfterCombat(state)
    self:OnEnable()
    message = ""
    self:UnregisterEvent("PLAYER_REGEN_ENABLED")
end