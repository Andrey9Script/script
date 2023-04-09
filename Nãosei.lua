-- NeRDv3.5 New

local Commands = require("Modules.Commands")
local Log = require("Modules.Log")
local Teleports = require("Modules.Teleports")
local AntiCheat = require("Modules.AntiCheat")
local Destroy = require("Modules.Destroy")
local Loot = require("Modules.Loot")
local Tp = require("Modules.Tp")

local lp = game:service"Players".LocalPlayer
local ws = workspace
local rs = game:service"ReplicatedStorage"

-- Initializing

Teleports:Start()
Log.SaveLog("[INFO] Teleports module loaded.")

Loot:Start()
Log.SaveLog("[INFO] Loot module loaded.")

Destroy:Start()
Log.SaveLog("[INFO] Destroy module loaded.")

Tp:Start()
Log.SaveLog("[INFO] Tp module loaded.")

AntiCheat:Start()
Log.SaveLog("[INFO] AntiCheat module loaded.")

-- Commands

Commands:AddCommand("log", function()
    Log.SaveLog("[INFO] Current Position: "..tostring(lp.Character.HumanoidRootPart.Position))
    return "Logged current position."
end)

Commands:AddCommand("tp", function(args)
    Tp:TpTo(args[1])
    return "Teleported to "..tostring(args[1])
end)

Commands:AddCommand("teleport", function(args)
    Tp:TpTo(args[1])
    return "Teleported to "..tostring(args[1])
end)

Commands:AddCommand("loot", function(args)
    Loot:Loot(args[1])
    return "Looted "..tostring(args[1])
end)

Commands:AddCommand("destroy", function(args)
    Destroy:Destroy(args[1])
    return "Destroyed "..tostring(args[1])
end)

Commands:AddCommand("nuke", function(args)
    Destroy:Nuke()
    return "Nuked the server."
end)

-- Exploit Functions

getgenv().TP = function(position)
    Tp:TpTo(position)
end

getgenv().Loot = function(name)
    Loot:Loot(name)
end

getgenv().Destroy = function(name)
    Destroy:Destroy(name)
end

getgenv().Nuke = function()
    Destroy:Nuke()
end

getgenv().Log = function(data)
    Log.SaveLog(data)
end

getgenv().Teleport = function(position)
    Tp:TpTo(position)
end

-- UI

loadstring(game:HttpGet("https://raw.githubusercontent.com/MrNeRD0/Doors-Hack/main/UI.lua"))()
