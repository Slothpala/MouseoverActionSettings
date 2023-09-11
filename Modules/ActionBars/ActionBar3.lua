--[[
    Created by Slothpala 
--]]
local ActionBar3 = MouseoverActionBars:NewModule("ActionBar3")
local AB3 = {}
local timer

function ActionBar3:OnEnable()
    AB3 = MouseoverActionBars:NewMouseoverUnit(AB3)
    AB3.Components = {}
    for i=1,12 do
        AB3.Components[i] = _G["MultiBarBottomRightButton" ..i]
    end
    AB3.Parent = MultiBarBottomRight
    AB3.Links = {} 
    AB3.Name = "AB3"
    AB3.Timer = timer
    AB3.maxalpha     = MouseoverActionBars.db.profile.ActionBars.AB3.maxalpha
    AB3.minalpha     = MouseoverActionBars.db.profile.ActionBars.AB3.minalpha
    AB3.fadeouttimer = MouseoverActionBars.db.profile.ActionBars.AB3.fadeouttimer
    MouseoverActionBars:RegisterOnEnter(AB3)
    MouseoverActionBars:RegisterOnLeave(AB3)
    MouseoverActionBars:Register(AB3,"ActionBar3")
    AB3:Hide()
    if MouseoverActionBars.db.profile.Config.Combat.Combat3 then
        MouseoverActionBars:RegisterInCombat(AB3)
    end
end

function ActionBar3:OnDisable()
    MouseoverActionBars:UnregisterOnEnter(AB3)
    MouseoverActionBars:UnregisterOnLeave(AB3)
    AB3.maxalpha = 1
    AB3.minalpha = 1
    AB3.LinksPresent = false
    AB3.Links = {} 
    AB3:RestoreShow() 
end