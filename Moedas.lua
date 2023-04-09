local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Players = game:GetService('Players')
local CollectionService = game:GetService('CollectionService')
local Workspace = game:GetService('Workspace')
local RunService = game:GetService('RunService')
local HttpService = game:GetService('HttpService')

local RemoteFunctions = ReplicatedStorage:WaitForChild('RF')
local Items = ReplicatedStorage.Items
local Coins = Items.Coins

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild('PlayerGui')
local TerminalUI = require(PlayerGui.TerminalUI)

local CollectionName = HttpService:GenerateGUID(false)
local CollectedCoins = {}
local CollectedItems = {}

local function findClosestObject(objects)
    local closestObject
    local closestDistance = math.huge

    for _, object in pairs(objects) do
        if object:IsA('BasePart') then
            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - object.Position).Magnitude
            if distance < closestDistance then
                closestDistance = distance
                closestObject = object
            end
        end
    end

    return closestObject, closestDistance
end

local function findClosestCoin()
    local coins = CollectionService:GetTagged('Coin')
    return findClosestObject(coins)
end

local function findClosestItem()
    local items = CollectionService:GetTagged('Item')
    return findClosestObject(items)
end

local function onItemCollected(item)
    CollectionService:RemoveTag(item, 'Item')
    CollectedItems[item] = true
    RemoteFunctions.ItemCollected:InvokeServer(item)
end

local function onCoinCollected(coin)
    CollectionService:RemoveTag(coin, 'Coin')
    CollectedCoins[coin] = true
    RemoteFunctions.CoinCollected:InvokeServer(coin)
end

local function isItemCollected(item)
    return CollectedItems[item] == true
end

local function isCoinCollected(coin)
    return CollectedCoins[coin] == true
end

local function addItem(name, position)
    local item = Items:FindFirstChild(name):Clone()
    item.Position = position
    item.Parent = Workspace

    CollectionService:AddTag(item, 'Item')
end

local function addCoin(position)
    local coin = Coins:Clone()
    coin.Position = position
    coin.Parent = Workspace

    CollectionService:AddTag(coin, 'Coin')
end

local function spawnRandomItem()
    local position = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(math.random(-50, 50), 5, math.random(-50, 50))
    local itemNames = {'Dagger', 'Hammer', 'Shield'}
    addItem(itemNames[math.random(1, #itemNames)], position)
end

local function spawnRandomCoin()
    local position = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(math.random(-50, 50), 5, math.random(-50, 50))
    addCoin(position)
end

local function detectItems()
    while true do
        wait(0.1)

        if not LocalPlayer.Character then
            continue
        end

        local closestItem, distance = findClosestItem()
        if closestItem and distance < 3 and not isItemCollected(closestItem) then
            onItemCollected(closestItem)
        end
    end
end

local function detectCoins()
    while true do
        wait(0.1)

        if not LocalPlayer.Character then
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Players = game:GetService('Players')
local CollectionService = game:GetService('CollectionService')
local Workspace = game:GetService('Workspace')
local RunService = game:GetService('RunService')
local HttpService = game:GetService('HttpService')

local RemoteFunctions = ReplicatedStorage:WaitForChild('RF')
local Items = ReplicatedStorage.Items
local Coins = Items.Coins

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild('PlayerGui')
local TerminalUI = require(PlayerGui.TerminalUI)

local CollectionName = HttpService:GenerateGUID(false)
local CollectedCoins = {}
local CollectedItems = {}

local function findClosestObject(objects)
    local closestObject
    local closestDistance = math.huge

    for _, object in pairs(objects) do
        if object:IsA('BasePart') then
            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - object.Position).Magnitude
            if distance < closestDistance then
                closestDistance = distance
                closestObject = object
            end
        end
    end

    return closestObject, closestDistance
end

local function findClosestCoin()
    local coins = CollectionService:GetTagged('Coin')
    return findClosestObject(coins)
end

local function findClosestItem()
    local items = CollectionService:GetTagged('Item')
    return findClosestObject(items)
end

local function onItemCollected(item)
    CollectionService:RemoveTag(item, 'Item')
    CollectedItems[item] = true
    RemoteFunctions.ItemCollected:InvokeServer(item)
end

local function onCoinCollected(coin)
    CollectionService:RemoveTag(coin, 'Coin')
    CollectedCoins[coin] = true
    RemoteFunctions.CoinCollected:InvokeServer(coin)
end

local function isItemCollected(item)
    return CollectedItems[item] == true
end

local function isCoinCollected(coin)
    return CollectedCoins[coin] == true
end

local function addItem(name, position)
    local item = Items:FindFirstChild(name):Clone()
    item.Position = position
    item.Parent = Workspace

    CollectionService:AddTag(item, 'Item')
end

local function addCoin(position)
    local coin = Coins:Clone()
    coin.Position = position
    coin.Parent = Workspace

    CollectionService:AddTag(coin, 'Coin')
end

local function spawnRandomItem()
    local position = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(math.random(-50, 50), 5, math.random(-50, 50))
    local itemNames = {'Dagger', 'Hammer', 'Shield'}
    addItem(itemNames[math.random(1, #itemNames)], position)
end

local function spawnRandomCoin()
    local position = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(math.random(-50, 50), 5, math.random(-50, 50))
    addCoin(position)
end

local function detectItems()
    while true do
        wait(0.1)

        if not LocalPlayer.Character then
            continue
        end

        local closestItem, distance = findClosestItem()
        if closestItem and distance < 3 and not isItemCollected(closestItem) then
            onItemCollected(closestItem)
        end
    end
end

local function detectCoins()
    while true do
        wait(0.1)
        local Item = Room:getObjects(E_ITEM)
        for i, v in pairs(Item) do
            if v:getSprite() and v:getSprite().name == "Objects/Parts/Part_2" then
                v:destroy()
                Alert:New(50, 50, 15, 15, 2000, "Part 2 acquired", "fonts/ArialBlack.ttf", 16, 255, 255, 255):Show()
                self.collectedParts = self.collectedParts + 1
            end
            if v:getSprite() and v:getSprite().name == "Objects/Parts/Part_3" then
                v:destroy()
                Alert:New(50, 50, 15, 15, 2000, "Part 3 acquired", "fonts/ArialBlack.ttf", 16, 255, 255, 255):Show()
                self.collectedParts = self.collectedParts + 1
            end
            if v:getSprite() and v:getSprite().name == "Objects/Parts/Part_4" then
                v:destroy()
                Alert:New(50, 50, 15, 15, 2000, "Part 4 acquired", "fonts/ArialBlack.ttf", 16, 255, 255, 255):Show()
                self.collectedParts = self.collectedParts + 1
            end
            if v:getSprite() and v:getSprite().name == "Objects/Parts/Part_5" then
                v:destroy()
                Alert:New(50, 50, 15, 15, 2000, "Part 5 acquired", "fonts/ArialBlack.ttf", 16, 255, 255, 255):Show()
                self.collectedParts = self.collectedParts + 1
            end
        end
