--[[
    Created by Slothpala 
--]]
local ActionBar6 = MouseoverActionBars:NewModule("ActionBar6")
local AB6 = {}
local timer

function ActionBar6:OnEnable()
    AB6 = MouseoverActionBars:NewMouseoverUnit(AB6)
    AB6.Components = {}
    for i=1,12 do
        AB6.Components[i] = _G["MultiBar5Button" ..i]
    end
    AB6.Parent = MultiBar5
    AB6.Links = {} 
    AB6.Name = "AB6"
    AB6.Timer = timer
    AB6.maxalpha     = MouseoverActionBars.db.profile.ActionBars.AB6.maxalpha
    AB6.minalpha     = MouseoverActionBars.db.profile.ActionBars.AB6.minalpha
    AB6.fadeouttimer = MouseoverActionBars.db.profile.ActionBars.AB6.fadeouttimer
    MouseoverActionBars:RegisterOnEnter(AB6)
    MouseoverActionBars:RegisterOnLeave(AB6)
    MouseoverActionBars:Register(AB6,"ActionBar6")
    AB6:Hide()
    if MouseoverActionBars.db.profile.Config.Combat.Combat6 then
        MouseoverActionBars:RegisterInCombat(AB6)
    end
end

function ActionBar6:OnDisable()
    MouseoverActionBars:UnregisterOnEnter(AB6)
    MouseoverActionBars:UnregisterOnLeave(AB6)
    AB6.maxalpha = 1
    AB6.minalpha = 1
    AB6.LinksPresent = false
    AB6.Links = {} 
    AB6:RestoreShow() 
end