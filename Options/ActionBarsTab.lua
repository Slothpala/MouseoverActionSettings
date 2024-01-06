local addonName, addonTable = ...
local addon = addonTable.addon
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local mouseover_unit_options = addon:GetMouseoverUnitOptions()
local options = {
    name = "Action Bars",
    handler = addon,
    type = "group",
    inline = true,
    args = {
        modules = {
            order = 0,
            name = L["enabled_units"],
            type = "group",
            inline = true,
            args = {
                MainMenuBar = {
                    order = 1,
                    name = L["MainMenuBar"],
                    desc = "",
                    type = "toggle",
                    get = "GetModuleStatus",
                    set = "SetModuleStatus",
                },
                MultiBarBottomLeft = {
                    order = 2,
                    name = L["MultiBarBottomLeft"],
                    desc = "",
                    type = "toggle",
                    get = "GetModuleStatus",
                    set = "SetModuleStatus",
                },
                MultiBarBottomRight = {
                    order = 3,
                    name = L["MultiBarBottomRight"],
                    desc = "",
                    type = "toggle",
                    get = "GetModuleStatus",
                    set = "SetModuleStatus",
                },
                MultiBarRight = {
                    order = 4,
                    name = L["MultiBarRight"],
                    desc = "",
                    type = "toggle",
                    get = "GetModuleStatus",
                    set = "SetModuleStatus",
                },
                MultiBarLeft = {
                    order = 5,
                    name = L["MultiBarLeft"],
                    desc = "",
                    type = "toggle",
                    get = "GetModuleStatus",
                    set = "SetModuleStatus",
                },
                MultiBar5 = {
                    order = 6,
                    name = L["MultiBar5"],
                    desc = "",
                    type = "toggle",
                    get = "GetModuleStatus",
                    set = "SetModuleStatus",
                },
                MultiBar6 = {
                    order = 7,
                    name = L["MultiBar6"],
                    desc = "",
                    type = "toggle",
                    get = "GetModuleStatus",
                    set = "SetModuleStatus",
                },
                MultiBar7 = {
                    order = 8,
                    name = L["MultiBar7"],
                    desc = "",
                    type = "toggle",
                    get = "GetModuleStatus",
                    set = "SetModuleStatus",
                },
                StanceBar = {
                    order = 9,
                    name = L["StanceBar"],
                    desc = "",
                    type = "toggle",
                    get = "GetModuleStatus",
                    set = "SetModuleStatus",
                },
                PetActionBar = {
                    order = 10,
                    name = L["PetActionBar"],
                    desc = "",
                    type = "toggle",
                    get = "GetModuleStatus",
                    set = "SetModuleStatus",
                },
            },
        },
        MainMenuBar = {
            hidden = function()
                return not addon:IsModuleEnabled("MainMenuBar")
            end,
            order = 1,
            name = L["MainMenuBar"],
            type = "group",
            inline = true,
            args = mouseover_unit_options,
        },
        MultiBarBottomLeft = {
            hidden = function()
                return not addon:IsModuleEnabled("MultiBarBottomLeft")
            end,
            order = 2,
            name = L["MultiBarBottomLeft"],
            type = "group",
            inline = true,
            args = mouseover_unit_options,
        },
        MultiBarBottomRight = {
            hidden = function()
                return not addon:IsModuleEnabled("MultiBarBottomRight")
            end,
            order = 3,
            name = L["MultiBarBottomRight"],
            type = "group",
            inline = true,
            args = mouseover_unit_options,
        },
        MultiBarRight = {
            hidden = function()
                return not addon:IsModuleEnabled("MultiBarRight")
            end,
            order = 4,
            name = L["MultiBarRight"],
            type = "group",
            inline = true,
            args = mouseover_unit_options,
        },
        MultiBarLeft = {
            hidden = function()
                return not addon:IsModuleEnabled("MultiBarLeft")
            end,
            order = 5,
            name = L["MultiBarLeft"],
            type = "group",
            inline = true,
            args = mouseover_unit_options,
        },
        MultiBar5 = {
            hidden = function()
                return not addon:IsModuleEnabled("MultiBar5")
            end,
            order = 6,
            name = L["MultiBar5"],
            type = "group",
            inline = true,
            args = mouseover_unit_options,
        },
        MultiBar6 = {
            hidden = function()
                return not addon:IsModuleEnabled("MultiBar6")
            end,
            order = 7,
            name = L["MultiBar6"],
            type = "group",
            inline = true,
            args = mouseover_unit_options,
        },
        MultiBar7 = {
            hidden = function()
                return not addon:IsModuleEnabled("MultiBar7")
            end,
            order = 8,
            name = L["MultiBar7"],
            type = "group",
            inline = true,
            args = mouseover_unit_options,
        },
        StanceBar = {
            hidden = function()
                return not addon:IsModuleEnabled("StanceBar")
            end,
            order = 9,
            name = L["StanceBar"],
            type = "group",
            inline = true,
            args = mouseover_unit_options,
        },
        PetActionBar = {
            hidden = function()
                return not addon:IsModuleEnabled("PetActionBar")
            end,
            order = 10,
            name = L["PetActionBar"],
            type = "group",
            inline = true,
            args = mouseover_unit_options,
        },
    },
}

function addon:GetActionBarTabSettings()
    return options
end