--[[
    Created by Slothpala 
--]]
local ActionBar10 = MouseoverActionBars:NewModule("ActionBar10")
local AB10 = {}
local timer

function ActionBar10:OnEnable()
    AB10 = MouseoverActionBars:NewMouseoverUnit(AB10)
    AB10.Components = {}
    for i=1,10 do
        AB10.Components[i] = _G["StanceButton" ..i]
    end
    AB10.Parent = StanceBar
    AB10.Links = {} 
    AB10.Name = "AB10"
    AB10.Timer = timer
    AB10.maxalpha     = MouseoverActionBars.db.profile.ActionBars.AB10.maxalpha
    AB10.minalpha     = MouseoverActionBars.db.profile.ActionBars.AB10.minalpha
    AB10.fadeouttimer = MouseoverActionBars.db.profile.ActionBars.AB10.fadeouttimer
    MouseoverActionBars:RegisterOnEnter(AB10)
    MouseoverActionBars:RegisterOnLeave(AB10)
    MouseoverActionBars:Register(AB10,"ActionBar10")
    AB10:Hide()
    if MouseoverActionBars.db.profile.Config.Combat.Combat10 then
        MouseoverActionBars:RegisterInCombat(AB10)
    end
end

function ActionBar10:OnDisable()
    MouseoverActionBars:UnregisterOnEnter(AB10)
    MouseoverActionBars:UnregisterOnLeave(AB10)
    AB10.maxalpha = 1
    AB10.minalpha = 1
    AB10.LinksPresent = false
    AB10.Links = {} 
    AB10:RestoreShow() 
end