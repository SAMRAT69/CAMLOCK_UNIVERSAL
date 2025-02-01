local player = game.Players.LocalPlayer
local aimbotEnabled = false
local uiVisible = true

-- Create UI
local ScreenGui = Instance.new("ScreenGui")
local AimbotButton = Instance.new("TextButton")
local CreditsLabel = Instance.new("TextLabel")
local DiscordButton = Instance.new("TextButton")
local ToggleButton = Instance.new("ImageButton")

ScreenGui.Parent = player:WaitForChild("PlayerGui")

AimbotButton.Size = UDim2.new(0, 100, 0, 50)
AimbotButton.Position = UDim2.new(0.05, 0, 0.05, 0)
AimbotButton.Text = "Aimbot: OFF"
AimbotButton.Parent = ScreenGui
AimbotButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

CreditsLabel.Size = UDim2.new(0, 200, 0, 30)
CreditsLabel.Position = UDim2.new(0.05, 0, 0.12, 0)
CreditsLabel.Text = "Made by Samrat"
CreditsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CreditsLabel.BackgroundTransparency = 1
CreditsLabel.Parent = ScreenGui

DiscordButton.Size = UDim2.new(0, 200, 0, 30)
DiscordButton.Position = UDim2.new(0.05, 0, 0.18, 0)
DiscordButton.Text = "Copy Discord Link"
DiscordButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
DiscordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscordButton.Parent = ScreenGui

ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0.05, 0, 0.05, 0)
ToggleButton.Image = "https://cdn.discordapp.com/icons/1329769693816557598/edccee61802f7bbee6426203ea524551.png?size=2048" -- Replace with actual image ID
ToggleButton.Parent = ScreenGui
ToggleButton.Visible = false

function getClosestEnemy()
    local closestEnemy = nil
    local minDistance = math.huge
    for _, enemy in ipairs(game.Players:GetPlayers()) do
        if enemy ~= player and enemy.Team ~= player.Team and enemy.Character and enemy.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - enemy.Character.HumanoidRootPart.Position).magnitude
            if distance < minDistance then
                closestEnemy = enemy
                minDistance = distance
            end
        end
    end
    return closestEnemy
end

-- Instant Aimbot function targeting the body
spawn(function()
    while true do
        if aimbotEnabled then
            local targetEnemy = getClosestEnemy()
            if targetEnemy and targetEnemy.Character and targetEnemy.Character:FindFirstChild("HumanoidRootPart") then
                local targetPosition = targetEnemy.Character.HumanoidRootPart.Position + Vector3.new(0, -1, 0) -- Aim at the body
                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, targetPosition)
            end
        end
        wait() -- Instant updates for the fastest movement
    end
end)

-- Toggle button functionality
AimbotButton.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    if aimbotEnabled then
        AimbotButton.Text = "Aimbot: ON"
        AimbotButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    else
        AimbotButton.Text = "Aimbot: OFF"
        AimbotButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    end
end)

-- Copy Discord link functionality
DiscordButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/u8fDraATDW")
end)

-- UI Toggle functionality
ToggleButton.MouseButton1Click:Connect(function()
    uiVisible = not uiVisible
    AimbotButton.Visible = uiVisible
    CreditsLabel.Visible = uiVisible
    DiscordButton.Visible = uiVisible
    ToggleButton.Visible = not uiVisible -- Show the toggle button when UI is hidden
end)
