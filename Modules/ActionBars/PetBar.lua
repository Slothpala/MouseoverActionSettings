--[[
    Created by Slothpala 
--]]
local ActionBar9 = MouseoverActionBars:NewModule("ActionBar9")
local AB9 = {}
local timer

function ActionBar9:OnEnable()
    AB9 = MouseoverActionBars:NewMouseoverUnit(AB9)
    AB9.Components = {}
    AB9.Links = {} 
    for i=1,10 do
        AB9.Components[i] = _G["PetActionButton" ..i]
    end
    AB9.Name = "AB9"
    AB9.Timer = timer
    AB9.maxalpha     = MouseoverActionBars.db.profile.ActionBars.AB9.maxalpha
    AB9.minalpha     = MouseoverActionBars.db.profile.ActionBars.AB9.minalpha
    AB9.fadeouttimer = MouseoverActionBars.db.profile.ActionBars.AB9.fadeouttimer
    MouseoverActionBars:RegisterOnEnter(AB9)
    MouseoverActionBars:RegisterOnLeave(AB9)
    MouseoverActionBars:Register(AB9,"ActionBar9")
    AB9:Hide()
    if MouseoverActionBars.db.profile.Config.Combat.Combat9 then
        MouseoverActionBars:RegisterInCombat(AB9)
    end
end

function ActionBar9:OnDisable()
    MouseoverActionBars:UnregisterOnEnter(AB9)
    MouseoverActionBars:UnregisterOnLeave(AB9)
    AB9.maxalpha = 1
    AB9.minalpha = 1
    AB9.LinksPresent = false
    AB9.Links = {} 
    AB9:RestoreShow() 
end