--[[
    Created by Slothpala 
--]]
local ActionBar8 = MouseoverActionBars:NewModule("ActionBar8")
local AB8 = {}
local timer

function ActionBar8:OnEnable()
    AB8 = MouseoverActionBars:NewMouseoverUnit(AB8)
    AB8.Components = {}
    for i=1,12 do
        AB8.Components[i] = _G["MultiBar7Button" ..i]
    end
    AB8.Parent = MultiBar7
    AB8.Links = {} 
    AB8.Name = "AB8"
    AB8.Timer = timer
    AB8.maxalpha     = MouseoverActionBars.db.profile.ActionBars.AB8.maxalpha
    AB8.minalpha     = MouseoverActionBars.db.profile.ActionBars.AB8.minalpha
    AB8.fadeouttimer = MouseoverActionBars.db.profile.ActionBars.AB8.fadeouttimer
    MouseoverActionBars:RegisterOnEnter(AB8)
    MouseoverActionBars:RegisterOnLeave(AB8)
    MouseoverActionBars:Register(AB8,"ActionBar8")
    AB8:Hide()
    if MouseoverActionBars.db.profile.Config.Combat.Combat8 then
        MouseoverActionBars:RegisterInCombat(AB8)
    end
end

function ActionBar8:OnDisable()
    MouseoverActionBars:UnregisterOnEnter(AB8)
    MouseoverActionBars:UnregisterOnLeave(AB8)
    AB8.maxalpha = 1
    AB8.minalpha = 1
    AB8.LinksPresent = false
    AB8.Links = {} 
    AB8:RestoreShow() 
end