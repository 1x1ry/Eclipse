local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage.Remotes.skillCheck
local LocalPlayer = game.Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local HUD = PlayerGui:FindFirstChild("HUD")

local function applyConnection(Object)
    local Connection
    Connection = Object.ChildAdded:Connect(function(Child)
        if string.find(Child.Name, LocalPlayer.Name) then
            Remote:FireServer("Hit", Child.Name)
            print("CLIENT: Sending HIT event")
        end
    end)

    Object.AncestryChanged:Connect(function()
        if not Object:IsDescendantOf(game) then
            Connection:Disconnect()
        end
    end)
end

PlayerGui.ChildAdded:Connect(function(Child)
    if Child.Name == "HUD" then
        applyConnection(Child)
    end
end)

if HUD then
    applyConnection(HUD)
end