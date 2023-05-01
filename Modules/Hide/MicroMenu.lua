--[[
    Created by Slothpala 
--]]
local HideMicroMenu = MouseoverActionBars:NewModule("HideMicroMenu")
local MicroMenu = {}

function HideMicroMenu:OnEnable()
    MicroMenu = MouseoverActionBars:NewHideUnit(MicroMenu)
    MicroMenu.Name = "HideMicroMenu"
    MicroMenu.Components = {
        CharacterMicroButton,
        SpellbookMicroButton,
        TalentMicroButton,
        AchievementMicroButton,
        QuestLogMicroButton,
        GuildMicroButton,
        LFDMicroButton,
        CollectionsMicroButton,
        EJMicroButton,
        StoreMicroButton,
        MainMenuMicroButton 
    }
    MouseoverActionBars:Hide(MicroMenu)
end

function HideMicroMenu:OnDisable()
    MouseoverActionBars:Show(MicroMenu)
end