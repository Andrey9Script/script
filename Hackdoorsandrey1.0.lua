-- NeRD Script
-- Discord: @NeRD#7777

local HttpService = game:GetService('HttpService')
local TweenService = game:GetService('TweenService')
local RunService = game:GetService('RunService')
local Players = game:GetService('Players')
local UserInputService = game:GetService('UserInputService')
local CoreGui = game:GetService('CoreGui')
local StarterGui = game:GetService('StarterGui')
local GuiService = game:GetService('GuiService')
local Lighting = game:GetService('Lighting')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Workspace = game:GetService('Workspace')
local ServerStorage = game:GetService('ServerStorage')
local Debris = game:GetService('Debris')
local HttpRbxApiService = game:GetService('HttpRbxApiService')
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local modules = {
    loot = loadstring(game:HttpGet('https://raw.githubusercontent.com/MrNeRD0/Doors-Hack/main/Modules/Loot.lua'))(),
    tp = loadstring(game:HttpGet('https://raw.githubusercontent.com/MrNeRD0/Doors-Hack/main/Modules/Tp.lua'))(),
    destroy = loadstring(game:HttpGet('https://raw.githubusercontent.com/MrNeRD0/Doors-Hack/main/Modules/Destroy.lua'))(),
    anticheat = loadstring(game:HttpGet('https://raw.githubusercontent.com/MrNeRD0/Doors-Hack/main/Modules/AntiCheat.lua'))(),
}

local doors = {
    ['Temple'] = {
        ['Door 1'] = {instance = nil, open = false, position = Vector3.new(3814.59, 365.14, -7324.77)},
        ['Door 2'] = {instance = nil, open = false, position = Vector3.new(3811.55, 365.16, -7324.77)},
        ['Door 3'] = {instance = nil, open = false, position = Vector3.new(3764.85, 363.63, -7335.48)},
        ['Door 4'] = {instance = nil, open = false, position = Vector3.new(3763.64, 363.63, -7361.12)},
    },
    ['Volcano'] = {
        ['Door 1'] = {instance = nil, open = false, position = Vector3.new(-2828.11, 457.91, -2287.92)},
        ['Door 2'] = {instance = nil, open = false, position = Vector3.new(-2828.11, 457.92, -2283.73)},
        ['Door 3'] = {instance = nil, open = false, position = Vector3.new(-2836.77, 459.13, -2329.41)},
        ['Door 4'] = {instance = nil, open = false, position = Vector3.new(-2862.15, 459.13, -2330.89)},
    },
    ['Frost'] = {
        ['Door 1'] = {instance = nil, open = false, position = Vector3.new(-840.55, 324.54, 4312.56)},
        ['Door 2'] = {instance = nil, open = false, position = Vector3.new(-840.47, 324.53, 4316.75)},
        ['Door 3'] = {instance = nil, open         = nil, open = false, position = Vector3.new(-868.22, 323.15, 4372.67)},
        ['Door 4'] = {instance = nil, open = false, position = Vector3.new(-842.58, 323.15, 4373.1)},
    },
}

local function findDoor(name)
    for _, v in pairs(doors) do
        for _, d in pairs(v) do
            if string.find(d.instance.Name, name) then
                return d
            end
        end
    end
end

local function toggleDoor(door)
    local target = door.open and door.position - Vector3.new(0, 6, 0) or door.position + Vector3.new(0, 6, 0)
    door.open = not door.open
    TweenService:Create(door.instance, TweenInfo.new(.25), {CFrame = CFrame.new(target)}):Play()
end

local function teleportPlayer(position)
    LocalPlayer.Character:MoveTo(position)
end

local function isPlayerInSafeZone()
    local position = LocalPlayer.Character and LocalPlayer.Character.PrimaryPart and LocalPlayer.Character.PrimaryPart.Position
    if not position then return false end
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA('MeshPart') and v.Name == 'SafeZone' and v.Size.X < 1000 then
            local distance = (position - v.Position).Magnitude
            if distance < v.Size.X / 2 then
                return true
            end
        end
    end
    return false
end

local function enableHitbox()
    if LocalPlayer.Character then
        local root = LocalPlayer.Character:FindFirstChild('HumanoidRootPart')
        if root then
            local hitbox = Instance.new('Part', root)
            hitbox.Name = 'Hitbox'
            hitbox.Size = Vector3.new(2, 2, 2)
            hitbox.Anchored = true
            hitbox.CanCollide = false
            hitbox.Transparency = 1
            hitbox.Position = root.Position
        end
    end
end

local function disableHitbox()
    if LocalPlayer.Character then
        local hitbox = LocalPlayer.Character:FindFirstChild('Hitbox')
        if hitbox then
            hitbox:Destroy()
        end
    end
end

local function addButtonsToUI(ui)
    local tab = ui:FindFirstChild('Players') or ui:FindFirstChild('Characters')
    local playersContainer = tab and tab:FindFirstChild('Container')
    if not playersContainer then return end

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local button = playersContainer:FindFirstChild(player.Name)
            if not button then
                button = Instance.new('TextButton', playersContainer)
                button.Name = player.Name
                button.Text = player.Name
                button.TextColor3 = Color3.fromRGB(255, 255, 255)
                button.BackgroundTransparency = 0.7
                button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                button.BorderSizePixel = 0
                button.Size = UDim2.new(1, 0, 0, 30)
                button.AutoButtonColor = false
                button.Font = Enum.Font.SourceSans
                button.TextSize = 18

                button.MouseButton1Click:Connect(function()
                    teleportPlayer(player.Character.PrimaryPart.Position)
                end)
            end
        end
   end
end

local function onPlayerAdded(player)
    player.CharacterAdded:Connect(function()
        if player == LocalPlayer then
            enableHitbox()
        else
            addButtonsToUI(TerminalUI:GetCoreGui('RobloxGui').TopBar.Container)
        end
    end)
end

for _, player in pairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

Players.PlayerAdded:Connect(onPlayerAdded)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.RightBracket then
            local door = findDoor('Door')
            if door then
                toggleDoor(door)
            end
        elseif input.KeyCode == Enum.KeyCode.LeftBracket then
            local door = findDoor('Door 4')
            if door then
                toggleDoor(door)
            end
        elseif input.KeyCode == Enum.KeyCode.T and isPlayerInSafeZone() then
            local teleportPlayers = {}
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    table.insert(teleportPlayers, {
                        Text = player.Name,
                        Callback = function()
                            teleportPlayer(player.Character.PrimaryPart.Position)
                        end,
                    })
                end
            end
            if #teleportPlayers > 0 then
                Notification.new({
                    Text = 'Teleport to player',
                    Duration = 10,
                    Buttons = teleportPlayers,
                }):Display()
            end
        end
    end
end)

Notification.new({
    Text = 'Doors hack loaded!',
    Duration = 3,
}):Display()



