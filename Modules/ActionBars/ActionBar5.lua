--[[
    Created by Slothpala 
--]]
local ActionBar5 = MouseoverActionBars:NewModule("ActionBar5")
local AB5 = {}
local timer

function ActionBar5:OnEnable()
    AB5 = MouseoverActionBars:NewMouseoverUnit(AB5)
    AB5.Components = {}
    AB5.Links = {} 
    for i=1,12 do
        AB5.Components[i] = _G["MultiBarLeftButton" ..i]
    end
    AB5.Name = "AB5"
    AB5.Timer = timer
    AB5.maxalpha     = MouseoverActionBars.db.profile.ActionBars.AB5.maxalpha
    AB5.minalpha     = MouseoverActionBars.db.profile.ActionBars.AB5.minalpha
    AB5.fadeouttimer = MouseoverActionBars.db.profile.ActionBars.AB5.fadeouttimer
    MouseoverActionBars:RegisterOnEnter(AB5)
    MouseoverActionBars:RegisterOnLeave(AB5)
    MouseoverActionBars:Register(AB5,"ActionBar5")
    AB5:Hide()
    if MouseoverActionBars.db.profile.Config.Combat.Combat5 then
        MouseoverActionBars:RegisterInCombat(AB5)
    end
end

function ActionBar5:OnDisable()
    MouseoverActionBars:UnregisterOnEnter(AB5)
    MouseoverActionBars:UnregisterOnLeave(AB5)
    AB5.maxalpha = 1
    AB5.minalpha = 1
    AB5.LinksPresent = false
    AB5.Links = {} 
    AB5:RestoreShow() 
end