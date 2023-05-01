--[[
    Created by Slothpala 
--]]
local ActionBar2 = MouseoverActionBars:NewModule("ActionBar2")
local AB2 = {}
local timer

function ActionBar2:OnEnable()
    AB2 = MouseoverActionBars:NewMouseoverUnit(AB2)
    AB2.Components = {}
    AB2.Links = {} 
    for i=1,12 do
        AB2.Components[i] = _G["MultiBarBottomLeftButton" ..i]
    end
    AB2.Name = "AB2"
    AB2.Timer = timer
    AB2.maxalpha     = MouseoverActionBars.db.profile.ActionBars.AB2.maxalpha
    AB2.minalpha     = MouseoverActionBars.db.profile.ActionBars.AB2.minalpha
    AB2.fadeouttimer = MouseoverActionBars.db.profile.ActionBars.AB2.fadeouttimer
    MouseoverActionBars:RegisterOnEnter(AB2)
    MouseoverActionBars:RegisterOnLeave(AB2)
    MouseoverActionBars:Register(AB2,"ActionBar2")
    AB2:Hide()
    if MouseoverActionBars.db.profile.Config.Combat.Combat2 then
        MouseoverActionBars:RegisterInCombat(AB2)
    end
end

function ActionBar2:OnDisable()
    MouseoverActionBars:UnregisterOnEnter(AB2)
    MouseoverActionBars:UnregisterOnLeave(AB2)
    AB2.maxalpha = 1
    AB2.minalpha = 1
    AB2.LinksPresent = false
    AB2.Links = {} 
    AB2:RestoreShow() 
end