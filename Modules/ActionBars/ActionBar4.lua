--[[
    Created by Slothpala 
--]]
local ActionBar4 = MouseoverActionBars:NewModule("ActionBar4")
local AB4 = {}
local timer

function ActionBar4:OnEnable()
    AB4 = MouseoverActionBars:NewMouseoverUnit(AB4)
    AB4.Components = {}
    for i=1,12 do
        AB4.Components[i] = _G["MultiBarRightButton" ..i]
    end
    AB4.Parent = MultiBarRight
    AB4.Links = {} 
    AB4.Name = "AB4"
    AB4.Timer = timer
    AB4.maxalpha     = MouseoverActionBars.db.profile.ActionBars.AB4.maxalpha
    AB4.minalpha     = MouseoverActionBars.db.profile.ActionBars.AB4.minalpha
    AB4.fadeouttimer = MouseoverActionBars.db.profile.ActionBars.AB4.fadeouttimer
    MouseoverActionBars:RegisterOnEnter(AB4)
    MouseoverActionBars:RegisterOnLeave(AB4)
    MouseoverActionBars:Register(AB4,"ActionBar4")
    AB4:Hide()
    if MouseoverActionBars.db.profile.Config.Combat.Combat4 then
        MouseoverActionBars:RegisterInCombat(AB4)
    end
end

function ActionBar4:OnDisable()
    MouseoverActionBars:UnregisterOnEnter(AB4)
    MouseoverActionBars:UnregisterOnLeave(AB4)
    AB4.maxalpha = 1
    AB4.minalpha = 1
    AB4.LinksPresent = false
    AB4.Links = {} 
    AB4:RestoreShow() 
end