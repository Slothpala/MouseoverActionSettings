--[[
    Created by Slothpala 
--]]
local ActionBar7 = MouseoverActionBars:NewModule("ActionBar7")
local AB7 = {}
local timer

function ActionBar7:OnEnable()
    AB7 = MouseoverActionBars:NewMouseoverUnit(AB7)
    AB7.Components = {}
    AB7.Links = {} 
    for i=1,12 do
        AB7.Components[i] = _G["MultiBar6Button" ..i]
    end
    AB7.Name = "AB7"
    AB7.Timer = timer
    AB7.maxalpha     = MouseoverActionBars.db.profile.ActionBars.AB7.maxalpha
    AB7.minalpha     = MouseoverActionBars.db.profile.ActionBars.AB7.minalpha
    AB7.fadeouttimer = MouseoverActionBars.db.profile.ActionBars.AB7.fadeouttimer
    MouseoverActionBars:RegisterOnEnter(AB7)
    MouseoverActionBars:RegisterOnLeave(AB7)
    MouseoverActionBars:Register(AB7,"ActionBar7")
    AB7:Hide()
    if MouseoverActionBars.db.profile.Config.Combat.Combat7 then
        MouseoverActionBars:RegisterInCombat(AB7)
    end
end

function ActionBar7:OnDisable()
    MouseoverActionBars:UnregisterOnEnter(AB7)
    MouseoverActionBars:UnregisterOnLeave(AB7)
    AB7.maxalpha = 1
    AB7.minalpha = 1
    AB7.LinksPresent = false
    AB7.Links = {} 
    AB7:RestoreShow() 
end