local addonName, addonTable = ...
local addon = addonTable.addon
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local mouseover_unit_options = addon:GetMouseoverUnitOptions()
local options = {
    name = "HUD",
    handler = addon,
    type = "group",
    args = {
        modules = {
            order = 0,
            name = L["enabled_units"] ,
            type = "group",
            inline = true,
            args = {
                BagsBar = {
                    order = 1,
                    name = L["BagsBar"],
                    desc = "",
                    type = "toggle",
                    get = "GetModuleStatus",
                    set = "SetModuleStatus",
                },
                MicroMenu = {
                    order = 2,
                    name = L["MicroMenu"],
                    desc = "",
                    type = "toggle",
                    get = "GetModuleStatus",
                    set = "SetModuleStatus",
                },
                PlayerFrame = {
                    order = 3,
                    name = L["PlayerFrame"],
                    desc = "",
                    type = "toggle",
                    get = "GetModuleStatus",
                    set = "SetModuleStatus",
                },
                TargetFrame = {
                    order = 3.1,
                    name = L["TargetFrame"],
                    desc = "",
                    type = "toggle",
                    get = "GetModuleStatus",
                    set = "SetModuleStatus",
                },
                FocusFrame = {
                    order = 3.2,
                    name = L["FocusFrame"],
                    desc = "",
                    type = "toggle",
                    get = "GetModuleStatus",
                    set = "SetModuleStatus",
                },
                Minimap = {
                    order = 4,
                    name = L["Minimap"],
                    desc = "",
                    type = "toggle",
                    get = "GetModuleStatus",
                    set = "SetModuleStatus",
                },
                ObjectiveTracker = {
                    order = 5,
                    name = L["ObjectiveTracker"],
                    desc = "",
                    type = "toggle",
                    get = "GetModuleStatus",
                    set = "SetModuleStatus",
                },
                BuffFrame = {
                    order = 6,
                    name = L["BuffFrame"],
                    desc = "",
                    type = "toggle",
                    get = "GetModuleStatus",
                    set = "SetModuleStatus",
                },
                DebuffFrame = {
                    order = 7,
                    name = L["DebuffFrame"],
                    desc = "",
                    type = "toggle",
                    get = "GetModuleStatus",
                    set = "SetModuleStatus",
                },
                TrackingBarContainer = {
                    order = 8,
                    name = L["TrackingBarContainer"],
                    desc = "",
                    type = "toggle",
                    get = "GetModuleStatus",
                    set = "SetModuleStatus",
                },
                ChatFrame = {
                    order = 9,
                    name = L["ChatFrame"],
                    desc = "",
                    type = "toggle",
                    get = "GetModuleStatus",
                    set = "SetModuleStatus",
                },
            },
        },
        BagsBar = {
            hidden = function()
                return not addon:IsModuleEnabled("BagsBar")
            end,
            order = 1,
            name = L["BagsBar"],
            type = "group",
            inline = true,
            args = mouseover_unit_options,
        },
        MicroMenu = {
            hidden = function()
                return not addon:IsModuleEnabled("MicroMenu")
            end,
            order = 2,
            name = L["MicroMenu"],
            type = "group",
            inline = true,
            args = mouseover_unit_options,
        },
        PlayerFrame = {
            hidden = function()
                return not addon:IsModuleEnabled("PlayerFrame")
            end,
            order = 3,
            name = L["PlayerFrame"],
            type = "group",
            inline = true,
            args = mouseover_unit_options,
        },
        TargetFrame = {
            hidden = function()
                return not addon:IsModuleEnabled("TargetFrame")
            end,
            order = 3.1,
            name = L["TargetFrame"],
            type = "group",
            inline = true,
            args = mouseover_unit_options,
        },
        FocusFrame = {
            hidden = function()
                return not addon:IsModuleEnabled("FocusFrame")
            end,
            order = 3.2,
            name = L["FocusFrame"],
            type = "group",
            inline = true,
            args = mouseover_unit_options,
        },
        Minimap = {
            hidden = function()
                return not addon:IsModuleEnabled("Minimap")
            end,
            order = 4,
            name = L["Minimap"],
            type = "group",
            inline = true,
            args = mouseover_unit_options,
        },
        ObjectiveTracker = {
            hidden = function()
                return not addon:IsModuleEnabled("ObjectiveTracker")
            end,
            order = 5,
            name = L["ObjectiveTracker"],
            type = "group",
            inline = true,
            args = mouseover_unit_options,
        },
        BuffFrame = {
            hidden = function()
                return not addon:IsModuleEnabled("BuffFrame")
            end,
            order = 6,
            name = L["BuffFrame"],
            type = "group",
            inline = true,
            args = mouseover_unit_options,
        },
        DebuffFrame = {
            hidden = function()
                return not addon:IsModuleEnabled("DebuffFrame")
            end,
            order = 7,
            name = L["DebuffFrame"],
            type = "group",
            inline = true,
            args = mouseover_unit_options,
        },
        TrackingBarContainer = {
            hidden = function()
                return not addon:IsModuleEnabled("TrackingBarContainer")
            end,
            order = 8,
            name = L["TrackingBarContainer"],
            type = "group",
            inline = true,
            args = mouseover_unit_options,
        },
        ChatFrame = {
            hidden = function()
                return not addon:IsModuleEnabled("ChatFrame")
            end,
            order = 8,
            name = L["ChatFrame"],
            type = "group",
            inline = true,
            args = mouseover_unit_options,
        },
    },
}

function addon:GetHUDTabOptions()
    return options
end