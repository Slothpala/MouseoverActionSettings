--[[
    Created by Slothpala 
--]]
local HideBagsBar = MouseoverActionBars:NewModule("HideBagsBar")
local BagsBar = {}

function HideBagsBar:OnEnable()
    BagsBar = MouseoverActionBars:NewHideUnit(BagsBar)
    BagsBar.Name = "HideBagsBar"
    BagsBar.Components = {
        MainMenuBarBackpackButton,
        CharacterBag0Slot,
        CharacterBag1Slot,
        CharacterBag2Slot,
        CharacterBag3Slot,
        CharacterReagentBag0Slot,
        BagBarExpandToggle, 
    }
    MouseoverActionBars:Hide(BagsBar)
end

function HideBagsBar:OnDisable()
    MouseoverActionBars:Show(BagsBar)
end