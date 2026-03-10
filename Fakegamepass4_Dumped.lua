function MessageOutput(messageText, messageType)
    if messageType == 1 then
        spawn(function()
            local messageObject = Instance.new("Message")
            messageObject.Parent = game.CoreGui
            messageObject.Text = messageText
            task.wait(3)
            messageObject:Destroy()
        end)
    elseif messageType == 2 then
        spawn(function()
            local hintObject = Instance.new("Hint")
            hintObject.Parent = game.CoreGui
            hintObject.Text = messageText
            task.wait(3)
            hintObject:Destroy()
        end)
    end
end

local playersService = game:GetService("Players")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local starterGui = game:GetService("StarterGui")

local player = playersService.LocalPlayer
local mouse = player:GetMouse()

local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local speedMusic = Instance.new("Sound")
speedMusic.Parent = game.Chat
speedMusic.Volume = 7
speedMusic.SoundId = "rbxassetid://99173388"
speedMusic.Looped = false

local teleportMusic = Instance.new("Sound")
teleportMusic.Parent = game.Chat
teleportMusic.Volume = 7
teleportMusic.SoundId = "rbxassetid://11945266"
teleportMusic.Looped = false

local webMusic = Instance.new("Sound")
webMusic.Parent = game.Chat
webMusic.Volume = 7
webMusic.SoundId = "rbxassetid://4334728939"
webMusic.Looped = false

local speedTool = Instance.new("Tool")
speedTool.RequiresHandle = false
speedTool.Name = "SpeedCoil"
speedTool.TextureId = "rbxassetid://99170415"

speedTool.Activated:Connect(function()
    speedMusic:Play()
    humanoid.WalkSpeed = 70
    wait(2)
    humanoid.WalkSpeed = 16
end)

speedTool.Parent = player.Backpack

speedTool.Unequipped:Connect(function()
    humanoid.WalkSpeed = 16
end)

local jumpTool = Instance.new("Tool")
jumpTool.RequiresHandle = false
jumpTool.Name = "JumpCoil"
jumpTool.TextureId = "rbxassetid://16619617"

jumpTool.Equipped:Connect(function()
    humanoid.JumpPower = 130
end)

jumpTool.Parent = player.Backpack

jumpTool.Unequipped:Connect(function()
    humanoid.JumpPower = 50
end)

local gravityTool = Instance.new("Tool")
gravityTool.RequiresHandle = false
gravityTool.Name = "gravityCoil"
gravityTool.TextureId = "http://www.roblox.com/asset?id=150063217"

gravityTool.Equipped:Connect(function()
    workspace.Gravity = 20
end)

gravityTool.Parent = player.Backpack

gravityTool.Unequipped:Connect(function()
    workspace.Gravity = 196.2
end)

local sitTool = Instance.new("Tool")
sitTool.RequiresHandle = false
sitTool.Name = "useless"
sitTool.TextureId = "http://www.roblox.com/asset/?id=9914799139"

sitTool.Equipped:Connect(function()
    if humanoid.Sit == true then
        humanoid.Sit = false
    else
        humanoid.Sit = true
    end
end)

sitTool.Parent = player.Backpack

sitTool.Unequipped:Connect(function()
    humanoid.Sit = false
end)

local danceGui = Instance.new("ScreenGui")
danceGui.Name = "RobloxGUI"
danceGui.Parent = game.CoreGui

local dance1Button = Instance.new("TextButton")
dance1Button.Parent = danceGui
dance1Button.Size = UDim2.new(0,200,0,60)
dance1Button.Position = UDim2.new(0,0,0,70)
dance1Button.BackgroundColor3 = Color3.new(1,1,1)
dance1Button.BorderColor3 = Color3.new(0,0,0)
dance1Button.BorderSizePixel = 1
dance1Button.Text = "Dance 1"
dance1Button.Visible = false

local dance2Button = Instance.new("TextButton")
dance2Button.Parent = danceGui
dance2Button.Size = UDim2.new(0,200,0,60)
dance2Button.Position = UDim2.new(0,0,0,140)
dance2Button.BackgroundColor3 = Color3.new(1,1,1)
dance2Button.BorderColor3 = Color3.new(0,0,0)
dance2Button.BorderSizePixel = 1
dance2Button.Text = "Dance 2"
dance2Button.Visible = false

local dance3Button = Instance.new("TextButton")
dance3Button.Parent = danceGui
dance3Button.Size = UDim2.new(0,200,0,60)
dance3Button.Position = UDim2.new(0,0,0,210)
dance3Button.BackgroundColor3 = Color3.new(1,1,1)
dance3Button.BorderColor3 = Color3.new(0,0,0)
dance3Button.BorderSizePixel = 1
dance3Button.Text = "Dance 3"
dance3Button.Visible = false

local danceTool = Instance.new("Tool")
danceTool.RequiresHandle = false
danceTool.Name = "dance"
danceTool.TextureId = "http://www.roblox.com/asset/?id=1480056651"

danceTool.Equipped:Connect(function()
    dance1Button.Visible = true
    dance2Button.Visible = true
    dance3Button.Visible = true
end)

danceTool.Parent = player.Backpack

danceTool.Unequipped:Connect(function()
    dance1Button.Visible = false
    dance2Button.Visible = false
    dance3Button.Visible = false
end)

dance1Button.MouseButton1Click:Connect(function()
    player:Chat("/e dance1")
end)

dance2Button.MouseButton1Click:Connect(function()
    player:Chat("/e dance2")
end)

dance3Button.MouseButton1Click:Connect(function()
    player:Chat("/e dance3")
end)

local flyTool = Instance.new("Tool")
flyTool.RequiresHandle = false
flyTool.Name = "fly"
flyTool.TextureId = "rbxassetid://223080070"

local flySpeed = 1.2
local flying = false

local bodyPosition = Instance.new("BodyPosition")
bodyPosition.Parent = rootPart
bodyPosition.D = 10
bodyPosition.P = 10000
bodyPosition.MaxForce = Vector3.new()

local bodyGyro = Instance.new("BodyGyro")
bodyGyro.Parent = rootPart
bodyGyro.D = 10
bodyGyro.MaxTorque = Vector3.new()

function StartFly()
    flying = true
    bodyPosition.MaxForce = Vector3.new(400000,400000,400000)
    bodyGyro.MaxTorque = Vector3.new(400000,400000,400000)

    while flying do
        runService.RenderStepped:Wait()

        bodyPosition.Position =
            rootPart.Position +
            (rootPart.Position - workspace.CurrentCamera.CFrame.Position).Unit * flySpeed

        bodyGyro.CFrame =
            CFrame.new(
                workspace.CurrentCamera.CFrame.Position,
                rootPart.Position
            )
    end
end

function StopFly()
    bodyPosition.MaxForce = Vector3.new()
    bodyGyro.MaxTorque = Vector3.new()
    flying = false
end

flyTool.Activated:Connect(StartFly)
flyTool.Unequipped:Connect(StopFly)
flyTool.Parent = player.Backpack

local teleportTool = Instance.new("Tool")
teleportTool.RequiresHandle = false
teleportTool.Name = "Teleport"
teleportTool.TextureId = "rbxassetid://45720930"

teleportTool.Activated:Connect(function()
    teleportMusic:Play()

    local targetPosition =
        mouse.Hit + Vector3.new(0,2.5,0)

    rootPart.CFrame =
        CFrame.new(
            targetPosition.X,
            targetPosition.Y,
            targetPosition.Z
        )
end)

teleportTool.Parent = player.Backpack

local spiderTool = Instance.new("Tool")
spiderTool.RequiresHandle = false
spiderTool.Name = "spiderweb"
spiderTool.TextureId = "http://www.roblox.com/asset/?id=4989967027"

spiderTool.Activated:Connect(function()
    webMusic:Play()

    local targetPosition =
        mouse.Hit.Position + Vector3.new(0,2.5,0)

    local tweenInfo =
        TweenInfo.new(
            1,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out
        )

    tweenService:Create(
        rootPart,
        tweenInfo,
        {CFrame = CFrame.new(targetPosition)}
    ):Play()
end)

spiderTool.Parent = player.Backpack

local flashlightTool = Instance.new("Tool")
flashlightTool.RequiresHandle = false
flashlightTool.Name = "Torch"
flashlightTool.TextureId = "http://www.roblox.com/asset/?id=115955232"

flashlightTool.Activated:Connect(function()
    local head = character:FindFirstChild("Head")

    local sound = Instance.new("Sound")
    sound.Parent = head
    sound.SoundId = "http://www.roblox.com/asset/?id=198914875"

    local light = rootPart:FindFirstChild("Light")

    if light then
        light:Destroy()
        sound:Play()
    else
        local newLight = Instance.new("SurfaceLight")
        newLight.Parent = rootPart
        newLight.Name = "Light"
        newLight.Range = 30
        newLight.Brightness = 35
        newLight.Shadows = true
        sound:Play()
    end
end)

flashlightTool.Parent = player.Backpack

flashlightTool.Unequipped:Connect(function()
    local light = rootPart:FindFirstChild("Light")

    if light then
        light:Destroy()
    end
end)

local wallhackTool = Instance.new("Tool")
wallhackTool.RequiresHandle = false
wallhackTool.Name = "WallHack"
wallhackTool.TextureId = "rbxassetid://9910999198"

local noclipEnabled = false

wallhackTool.Equipped:Connect(function()
    noclipEnabled = true
end)

wallhackTool.Parent = player.Backpack

wallhackTool.Unequipped:Connect(function()
    noclipEnabled = false
end)

runService.Stepped:Connect(function()
    if noclipEnabled then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

starterGui:SetCore(
    "SendNotification",
    {
        Title = "Made By Patrick",
        Text = "Sub @Im_Patrick On Youtube to get others script",
        Icon = "rbxthumb://type=Asset&id=11774242795&w=150&h=150"
    }
)
