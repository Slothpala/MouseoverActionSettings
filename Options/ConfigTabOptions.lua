local addonName, addonTable = ...
local addon = addonTable.addon
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local options = {
    name = "Config",
    handler = addon,
    type = "group",
    args = {
        GlobalSettings = {
            order = 1,
            name = L["global_settings_header"],
            type = "group",
            inline = true,
            args = {
                delay = {
                    order = 1,
                    name = L["delay_name"],
                    desc = L["delay_desc"],
                    type = "range",
                    get = "GetStatus",
                    set = "SetStatus",
                    min = 0,
                    softMax = 10,   
                    step = 1,   
                    width = 1.6,                    
                },
                animationSpeed_In = {
                    order = 2,
                    name = L["animation_speed_in_name"] ,
                    desc = L["animation_speed_in_desc"],
                    type = "range",
                    get = "GetStatus",
                    set = "SetStatus",
                    min = 0,
                    max = 10,   
                    step = 0.01, 
                    width = 1.6,   
                },
                animationSpeed_Out = {
                    order = 3,
                    name = L["animation_speed_out_name"] ,
                    desc = L["animation_speed_out_desc"],
                    type = "range",
                    get = "GetStatus",
                    set = "SetStatus",
                    min = 0,
                    max = 10,   
                    step = 0.01, 
                    width = 1.6,   
                },
                healthThreshold = {
                    order = 4,
                    name = L["health_threshold_name"],
                    desc = L["health_threshold_desc"],
                    type = "range",
                    get = "GetStatus",
                    set = "SetStatus",
                    min = 0,
                    max = 1,
                    isPercent = true,
                    step = 0.01, 
                    width = 1.6,                    
                },
                newline = {
                    order = 10,
                    type = "description",
                    name = "",
                },
                event_delay_timer_button = {
                    order = 10.1,
                    name = L["event_delay_timer_button_name"],
                    type  = "execute",
                    width = 1.7,
                    func = function()
                        addon:ShowEventDelayTimerFrame()
                    end,
                },
            },
        },
        ActionBarConfig = {
            order = 2,
            name = L["action_bar_settings"],
            type = "group",
            inline = true,
            args = {
                ActionBarConfig = {
                    order = 1,
                    name = L["action_bar_config_name"],
                    type = "group",
                    inline = true,
                    args = {
                        Action = { --MainMenuBar: Buttons for that bar aren't named after parent frame
                            order = 1,
                            name = L["MainMenuBar"],
                            desc = "",
                            type = "toggle",
                            get = "GetStatus",
                            set = "SetStatus",
                        },
                        MultiBarBottomLeft = {
                            order = 2,
                            name = L["MultiBarBottomLeft"],
                            desc = "",
                            type = "toggle",
                            get = "GetStatus",
                            set = "SetStatus",
                        },
                        MultiBarBottomRight = {
                            order = 3,
                            name = L["MultiBarBottomRight"],
                            desc = "",
                            type = "toggle",
                            get = "GetStatus",
                            set = "SetStatus",
                        },
                        MultiBarRight = {
                            order = 4,
                            name = L["MultiBarRight"],
                            desc = "",
                            type = "toggle",
                            get = "GetStatus",
                            set = "SetStatus",
                        },
                        MultiBarLeft = {
                            order = 5,
                            name = L["MultiBarLeft"],
                            desc = "",
                            type = "toggle",
                            get = "GetStatus",
                            set = "SetStatus",
                        },
                        MultiBar5 = {
                            order = 6,
                            name = L["MultiBar5"],
                            desc = "",
                            type = "toggle",
                            get = "GetStatus",
                            set = "SetStatus",
                        },
                        MultiBar6 = {
                            order = 7,
                            name = L["MultiBar6"],
                            desc = "",
                            type = "toggle",
                            get = "GetStatus",
                            set = "SetStatus",
                        },
                        MultiBar7 = {
                            order = 8,
                            name = L["MultiBar7"],
                            desc = "",
                            type = "toggle",
                            get = "GetStatus",
                            set = "SetStatus",
                        },
                    },
                },
                hideHotkey = {
                    order = 2,
                    name = L["hideHotkey"],
                    desc = "",
                    type = "toggle",
                    get = "GetStatus",
                    set = "SetStatus",
                },
                hideCount = {
                    order = 3,
                    name = L["hideCount"],
                    desc = "",
                    type = "toggle",
                    get = "GetStatus",
                    set = "SetStatus",
                },
                hideName = {
                    order = 4,
                    name = L["hideName"],
                    desc = "",
                    type = "toggle",
                    get = "GetStatus",
                    set = "SetStatus",
                },
            },
        },
        Hide = {
            order = 3,
            name = L["Hide"],
            type = "group",
            inline = true,
            args = {
                HideBagsBar = {
                    order = 1,
                    name = L["hide_bags_bar_name"],
                    desc = L["hide_bags_bar_desc"],
                    type = "toggle",
                    get = "GetModuleStatus",
                    set = "SetModuleStatus",
                },
                HideTrackingBars = {
                    order = 2,
                    name = L["hide_tracking_bars_name"],
                    desc = L["hide_tracking_bars_desc"],
                    type = "toggle",
                    get = "GetModuleStatus",
                    set = "SetModuleStatus",
                },
                HideMicroMenu = {
                    order = 3,
                    name = L["hide_micro_menu_name"],
                    desc = L["hide_micro_menu_desc"],
                    type = "toggle",
                    get = "GetModuleStatus",
                    set = "SetModuleStatus",
                },
            },
        },
        Miscellaneous = {
            order = 4,
            name = L["Miscellaneous"],
            type = "group",
            inline = true,
            args = {
                MiniMapButton = {
                    order = 1,
                    name = L["minimap_button_name"],
                    desc = L["minimap_button_desc"],
                    type = "toggle",
                    get = "GetModuleStatus",
                    set = "SetModuleStatus",
                },
                TinkerZone = {
                    order = 2,
                    name = L["tinker_zone_name"],
                    desc = L["tinker_zone_desc"],
                    type = "toggle",
                    confirm = function(info, value)
                        if value == true then
                            return true
                        end
                        return false
                    end,
                    get = function()
                        return addon.db.global.TinkerZone
                    end,
                    set = function(info, value)
                        addon.db.global.TinkerZone = value
                        ReloadUI()
                    end,
                },
            },
        },
    },
}

function addon:GetConfigOptions()
    return options
end

