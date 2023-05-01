--[[
    Created by Slothpala 
--]]
local ActionBar11 = MouseoverActionBars:NewModule("ActionBar11")
local AB11 = {}
local timer

function ActionBar11:OnEnable()
    AB11 = MouseoverActionBars:NewMouseoverUnit(AB11)
    AB11.Components = {
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
    AB11.Name = "AB11"
    AB11.Timer = timer
    AB11.maxalpha     = MouseoverActionBars.db.profile.ActionBars.AB11.maxalpha
    AB11.minalpha     = MouseoverActionBars.db.profile.ActionBars.AB11.minalpha
    AB11.fadeouttimer = MouseoverActionBars.db.profile.ActionBars.AB11.fadeouttimer
    MouseoverActionBars:RegisterOnEnter(AB11)
    MouseoverActionBars:RegisterOnLeave(AB11)
    MouseoverActionBars:Register(AB11,"ActionBar11")
    AB11:Hide()
end

function ActionBar11:OnDisable()
    MouseoverActionBars:UnregisterOnEnter(AB11)
    MouseoverActionBars:UnregisterOnLeave(AB11)
    AB11.maxalpha = 1
    AB11.minalpha = 1
    AB11.LinksPresent = false
    AB11.Links = {} 
    AB11:RestoreShow() 
end