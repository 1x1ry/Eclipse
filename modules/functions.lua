
local Services, Utility = {}, {
    Directory = "Eclipse",
    Repository = "Eclipse",
    
    Connections = {},
    Instances = {},
    Drawings = {},

    Players = {
        Closest = {
            Player,
            Part,
            Magnitude,
            Distance,
            Health
        },
        All = {}, 
        Alive = {}
    }
    
}; setmetatable(Services, {
    __index = function(self, key)
        return cloneref and cloneref(game:GetService(key)) or game:GetService(key)
    end
})


local userInputService = Services.UserInputService
local runService = Services.RunService
local tweenService = Services.TweenService
local Players = Services.Players

local localPlayer = Players.LocalPlayer
local Mouse = userInputService:GetMouseLocation()
local Camera = workspace.CurrentCamera 

do --## Main ## 
    function Utility:newInstance(Config : table) 
        local Instance = Instance.new(Config.Instance or Config.Type or "Frame")
        local Index = Config.Index or #self.Instances
        local Properties = Config.Properties or Config.Config or {}

        for _, v in next, Properties do
            Instance[_] = v
        end 

        self.Instances[Index] = Instance

        return Instance
    end

    function Utility:newDrawing(Config : table)
        local Drawing = Drawing.new(Config.Instance or Config.Type or "Circle")
        local Index = Config.Index or #self.Drawings
        local Properties = Config.Properties or Config.Config or {}

        for _, v in next, Properties do
            Drawing[_] = v
        end 

        self.Drawings[Index] = Drawing

        return Drawing
    end

    function Utility:newSignal(Config : table)
        local Signal = Config.Signal or Services.RunService.RenderStepped 
        local Index = Config.Index or #self.Connections
        local Function = Config.Function or Config.Func or Config.Callback or function() end 

        local Connection = Signal:Connect(Function)

        self.Connections[Index] = Connection

        return Connection
    end
end

do --## Core ##
    function Utility:isAlive(Player : Player)
        if Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
            if Player.Character:FindFirstChildOfClass("Humanoid").Health > 0 then 
                return true
            end
        end
        
        return false
    end
    
    function Utility:isFriendly(Player : Player)
        return (Player.Team == localPlayer.Team)
    end

    function Utility:hasForcefield(Player : Player)
        return false
    end 

    function Utility:getClosestPlayer(Function)
        local extraCheck = Function or function() return true end
        local closestPlayer = nil
        local shortestDistance = math.huge

        for _, Player in ipairs(self.Players.Alive) do
            if Player ~= localPlayer  then
                local Position = Player.Character.HumanoidRootPart.Position
                local pos, OnScreen = Camera:WorldToViewportPoint(Position)
                local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude

                if extraCheck(Player, magnitude) and magnitude < shortestDistance and OnScreen then
                    closestPlayer = Player
                    shortestDistance = magnitude
                end
            end
        end

        return closestPlayer
    end

    function Utility:getClosestPart(Player: Instance, List: Table)
        local shortestDistance = math.huge
        local closestPart
        if self:isAlive(Player) then
            for _, Value in pairs(Player.Character:GetChildren()) do
                if Value:IsA("BasePart") then 
                    local pos = self:worldToViewportPoint(Value.Position)
                    local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y + 36)).magnitude
                        if magnitude < shortestDistance and table.find(List, Value) then
                            closestPart = Value
                            shortestDistance = magnitude
                        end
                    end
                end 
            return closestPart
        end
    end 

    function Utility:getBodyParts(Character, RootPart, Indexes, Hitboxes)
        local Parts = {}
        local Hitboxes = Hitboxes or {"Head", "Torso", "Arms", "Legs"}

        for Index, Part in ipairs(Character:GetChildren()) do
            if Part:IsA("BasePart") and Part ~= RootPart then
                if table.find(Hitboxes, "Head") and Part.Name:lower():find("head") then
                    Parts[Indexes and Part.Name or #Parts + 1] = Part
                elseif table.find(Hitboxes, "Torso") and Part.Name:lower():find("torso") then
                    Parts[Indexes and Part.Name or #Parts + 1] = Part
                elseif table.find(Hitboxes, "Arms") and Part.Name:lower():find("arm") then
                    Parts[Indexes and Part.Name or #Parts + 1] = Part
                elseif table.find(Hitboxes, "Legs") and Part.Name:lower():find("leg") then
                    Parts[Indexes and Part.Name or #Parts + 1] = Part
                elseif (table.find(Hitboxes, "Arms") and Part.Name:lower():find("hand")) or (table.find(Hitboxes, "Legs") and Part.Name:lower():find("foot")) then
                    Parts[Indexes and Part.Name or #Parts + 1] = Part
                end
            end
        end

        return Parts
    end

    function Utility:getOrgin(Origin)
        if Origin == "Head" then
            local Object, Humanoid, RootPart = self:is_alive(LocalPlayer)
            local Head = Object:FindFirstChild("Head")
            --
            if Head and Head:IsA("RootPart") then
                return Head.CFrame.Position
            end
        elseif Origin == "Torso" then
            local Object, Humanoid, RootPart = self:is_alive(LocalPlayer)
            --
            if RootPart then
                return RootPart.CFrame.Position
            end
        end
        --
        return Workspace.CurrentCamera.CFrame.Position
    end

    function Utility:getPlayerHealth(Player)
        if Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
            return Player.Character:FindFirstChildOfClass("Humanoid").Health
        end
        return 0
    end

    function Utility:getDistance(Player1, Player2)
        if Player1.Character and Player2.Character then
            local pos1 = Player1.Character:FindFirstChild("HumanoidRootPart").Position
            local pos2 = Player2.Character:FindFirstChild("HumanoidRootPart").Position
            return (pos1 - pos2).Magnitude
        end

        return math.huge
    end

    function Utility:bindKeyEvent(Config : table)
    end
end 

do --## Miscallaenous ## 
    function Utility:worldToViewportPoint(Object)
        return workspace.CurrentCamera:WorldToViewportPoint(Object)
    end

    function Utility:worldToScreenPoint(Object)
        return workspace.CurrentCamera:WorldToScreenPoint(Object)
    end

    function Utility:getMouseLocation()
        return localPlayer:GetMouseLocation()
    end 

    function Utility:getPlayers()
        return Players:GetPlayers()
    end

    function Utility:getAlivePlayers()
        local Cache = {}

        for _, v in next, Utility:getPlayers() do
            if self:isAlive(v) then
                table.insert(Cache, v)
            end
        end

        return Cache 
    end

    function Utility:getPlayersByHealthRange(minHealth, maxHealth)
        local playersInRange = {}
        for _, player in pairs(Players:GetPlayers()) do
            local health = self:getPlayerHealth(player)
            if health >= minHealth and health <= maxHealth then
                table.insert(playersInRange, player)
            end
        end
        return playersInRange
    end

    function Utility:getPlayersByDistanceRange(minDistance, maxDistance)
        local playersInRange = {}
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= localPlayer and self:isAlive(player) then
                local distance = self:getDistance(localPlayer, player)
                if distance >= minDistance and distance <= maxDistance then
                    table.insert(playersInRange, player)
                end
            end
        end
        return playersInRange
    end
end


return Services, Utility