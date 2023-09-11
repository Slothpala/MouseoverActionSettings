--[[
    Created by Slothpala 
--]]
local ActionBar12 = MouseoverActionBars:NewModule("ActionBar12")
local AB12 = {}
local timer

function ActionBar12:OnEnable()
    AB12 = MouseoverActionBars:NewMouseoverUnit(AB12)
    AB12.Components = {
        MainMenuBarBackpackButton,
        BagBarExpandToggle,
        CharacterBag0Slot,
        CharacterBag1Slot,
        CharacterBag2Slot,
        CharacterBag3Slot,
        CharacterReagentBag0Slot,
    }
    AB12.Links = {} 
    AB12.Name = "AB12"
    AB12.Timer = timer
    AB12.maxalpha     = MouseoverActionBars.db.profile.ActionBars.AB12.maxalpha
    AB12.minalpha     = MouseoverActionBars.db.profile.ActionBars.AB12.minalpha
    AB12.fadeouttimer = MouseoverActionBars.db.profile.ActionBars.AB12.fadeouttimer
    function AB12:RestoreShow()
        for i=1, #self.Components do
            self.Components[i].MOUSEOVERACTIONBARS_ANIMATION_GROUP:Stop()
            self.Components[i].MOUSEOVERACTIONBARS_ALPHA_ANIMATION:SetToAlpha(self.maxalpha)
            self.Components[i].MOUSEOVERACTIONBARS_ANIMATION_GROUP:Play()
        end
    end
    AB12.Show = AB12.RestoreShow
    MouseoverActionBars:RegisterOnEnter(AB12)
    MouseoverActionBars:RegisterOnLeave(AB12)
    MouseoverActionBars:Register(AB12,"ActionBar12")
    AB12:Hide()
end

function ActionBar12:OnDisable()
    MouseoverActionBars:UnregisterOnEnter(AB12)
    MouseoverActionBars:UnregisterOnLeave(AB12)
    AB12.maxalpha = 1
    AB12.minalpha = 1
    AB12.LinksPresent = false
    AB12.Links = {} 
    AB12:RestoreShow() 
end