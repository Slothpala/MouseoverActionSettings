--[[
    Created by Slothpala 
--]]
local defaults = {
    profile = {
        Module = {
            ["*"] = false,
        },
        ActionBars = { 
            ["**"] = { 
                fadeouttimer = 2,
                minalpha = 0,
                maxalpha = 1,
            },
        },
        Config = {
            ["*"] = {
                ["*"] = false,
            }
        },
        LinkedGroups = {
            ["*"] = {
                ["*"] = false,
            }
        },
    }
}

function MouseoverActionBars:LoadDataBase()
    self.db = LibStub("AceDB-3.0"):New("MouseoverActionBarsDB", defaults, true) 
    --db callbacks
    self.db.RegisterCallback(self, "OnProfileChanged", "ReloadConfig")
    self.db.RegisterCallback(self, "OnProfileCopied", "ReloadConfig")
    self.db.RegisterCallback(self, "OnProfileReset", "ReloadConfig")
end