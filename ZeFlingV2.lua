-- =======================================================
-- Fling Script - Final Version (Translation)
-- =======================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local StarterGui = game:GetService("StarterGui")
local UIS = game:GetService("UserInputService")
local SocialService = nil
pcall(function() SocialService = game:GetService("SocialService") end)

-- =======================================================
-- MAIN FLING LOGIC
-- =======================================================

local GetPlayer = function(Name)
    Name = Name:lower()
    if Name == "random" then
        local GetPlayers = Players:GetPlayers()
        if table.find(GetPlayers,player) then table.remove(GetPlayers,table.find(GetPlayers,player)) end
        return GetPlayers[math.random(#GetPlayers)]
    else
        for _,x in next, Players:GetPlayers() do
            if x ~= player then
                if x.Name:lower():match("^"..Name) then
                    return x
                elseif x.DisplayName:lower():match("^"..Name) then
                    return x
                end
            end
        end
    end
    return nil
end

local Message = function(_Title, _Text, Time)
    pcall(function()
        StarterGui:SetCore("SendNotification", {Title = _Title, Text = _Text, Duration = Time})
    end)
end

local SkidFling = function(TargetPlayer, AllBool)
    local Character = player.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Humanoid and Humanoid.RootPart

    local TCharacter = TargetPlayer.Character
    local THumanoid
    local TRootPart
    local THead
    local Accessory
    local Handle

    if not TCharacter then
        return Message("Error Occurred", "Target's character is not available", 5)
    end

    THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
    if THumanoid and THumanoid.RootPart then
        TRootPart = THumanoid.RootPart
    end
    if TCharacter:FindFirstChild("Head") then
        THead = TCharacter.Head
    end
    Accessory = TCharacter:FindFirstChildOfClass("Accessory")
    if Accessory and Accessory:FindFirstChild("Handle") then
        Handle = Accessory.Handle
    end

    if Character and Humanoid and RootPart then
        if RootPart.Velocity.Magnitude < 50 then
            getgenv().OldPos = RootPart.CFrame
        end
        if THumanoid and THumanoid.Sit and not AllBool then
            return Message("Error Occurred", "Target is sitting", 5)
        end
        if THead then
            workspace.CurrentCamera.CameraSubject = THead
        elseif not THead and Handle then
            workspace.CurrentCamera.CameraSubject = Handle
        elseif THumanoid and TRootPart then
            workspace.CurrentCamera.CameraSubject = THumanoid
        end
        if not TCharacter:FindFirstChildWhichIsA("BasePart") then
            return
        end
        
        local FPos = function(BasePart, Pos, Ang)
            RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
            Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
            RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
            RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
        end
        
        local SFBasePart = function(BasePart)
            local TimeToWait = 2
            local Time = tick()
            local Angle = 0

            repeat
                if RootPart and THumanoid then
                    if BasePart.Velocity.Magnitude < 50 then
                        Angle = Angle + 100

                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                    else
                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        
                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()
                    end
                else
                    break
                end
            until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
        end
        
        workspace.FallenPartsDestroyHeight = 0/0
        
        local BV = Instance.new("BodyVelocity")
        BV.Name = "EpixVel"
        BV.Parent = RootPart
        BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
        BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
        
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
        
        if TRootPart and THead then
            if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
                SFBasePart(THead)
            else
                SFBasePart(TRootPart)
            end
        elseif TRootPart and not THead then
            SFBasePart(TRootPart)
        elseif not TRootPart and THead then
            SFBasePart(THead)
        elseif not TRootPart and not THead and Accessory and Handle then
            SFBasePart(Handle)
        else
            return Message("Error Occurred", "Target is missing everything", 5)
        end
        
        BV:Destroy()
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        workspace.CurrentCamera.CameraSubject = Humanoid
        
        repeat
            RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
            Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
            Humanoid:ChangeState("GettingUp")
            table.foreach(Character:GetChildren(), function(_, x)
                if x:IsA("BasePart") then
                    x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
                end
            end)
            task.wait()
        until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
        workspace.FallenPartsDestroyHeight = getgenv().FPDH
    else
        return Message("Error Occurred", "Random error", 5)
    end
end
getgenv().FPDH = workspace.FallenPartsDestroyHeight

local function FlingTarget(targetName, isAll)
    if not getgenv().Welcome then
        -- Updated notification
        Message("Fling", "Enjoy Fling all", 5)
        getgenv().Welcome = true
    end

    if isAll then
        for _, x in next, Players:GetPlayers() do
            if x ~= player then
                pcall(function()
                    SkidFling(x, true)
                end)
            end
        end
    else
        local targetPlayer = GetPlayer(targetName)
        if targetPlayer and targetPlayer ~= player then
            if targetPlayer.UserId ~= 1414978355 then
                pcall(function()
                    SkidFling(targetPlayer, false)
                end)
            else
                Message("Error Occurred", "This user is whitelisted! (Owner)", 5)
            end
        else
            Message("Error Occurred", "Username Invalid or Self", 5)
        end
    end
end

-- =======================================================
-- CUSTOM UI CREATION
-- =======================================================
local mainGui = Instance.new("ScreenGui")
mainGui.Name = "CustomFlingUI"
mainGui.ResetOnSpawn = false
mainGui.Parent = player.PlayerGui

-- Open/Close UI Button (Top Center Position)
local openButton = Instance.new("TextButton")
openButton.Name = "OpenButton"
openButton.Size = UDim2.new(0, 50, 0, 50)
openButton.Position = UDim2.new(0.5, -25, 0, 20)
openButton.AnchorPoint = Vector2.new(0.5, 0)
openButton.Text = "UI"
openButton.TextColor3 = Color3.fromRGB(255, 255, 255)
openButton.Font = Enum.Font.SourceSansBold
openButton.TextSize = 20
openButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
openButton.BorderSizePixel = 0
openButton.Parent = mainGui

local openButtonCorner = Instance.new("UICorner")
openButtonCorner.CornerRadius = UDim.new(0, 8)
openButtonCorner.Parent = openButton

local openButtonStroke = Instance.new("UIStroke")
openButtonStroke.Color = Color3.fromRGB(0, 255, 255)
openButtonStroke.Thickness = 1
openButtonStroke.Transparency = 0.5
openButtonStroke.Parent = openButton

-- Main UI Frame (Non-draggable)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 300)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Parent = mainGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

local mainFrameStroke = Instance.new("UIStroke")
mainFrameStroke.Color = Color3.fromRGB(0, 255, 255)
mainFrameStroke.Thickness = 2
mainFrameStroke.Transparency = 0.7
mainFrameStroke.Parent = mainFrame

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(38, 38, 48)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -60, 1, 0)
titleLabel.Position = UDim2.new(0, 5, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Fling Script"
titleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
titleLabel.Font = Enum.Font.SourceSans
titleLabel.TextSize = 18
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

local titleLabelStroke = Instance.new("UIStroke")
titleLabelStroke.Color = Color3.fromRGB(0, 255, 255)
titleLabelStroke.Thickness = 1.5
titleLabelStroke.Transparency = 0.5
titleLabelStroke.Parent = titleLabel

local titleGradient = Instance.new("UIGradient")
titleGradient.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 255, 0))
titleGradient.Parent = titleBar

spawn(function()
    while titleBar.Parent do
        local offset = tick() * 0.2
        titleGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromHSV((0 + offset) % 1,1,1)),
            ColorSequenceKeypoint.new(0.5, Color3.fromHSV((0.5 + offset) % 1,1,1)),
            ColorSequenceKeypoint.new(1, Color3.fromHSV((1 + offset) % 1,1,1)),
        }
        task.wait(0.05)
    end
end)

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 1, 0)
closeButton.Position = UDim2.new(1, -35, 0, 0)
closeButton.Text = "X"
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 20
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeButton.Parent = titleBar

local copyrightLabelUI = Instance.new("TextLabel")
copyrightLabelUI.Size = UDim2.new(0.5, 0, 0, 20)
copyrightLabelUI.Position = UDim2.new(0, 5, 1, -25)
copyrightLabelUI.BackgroundTransparency = 1
copyrightLabelUI.Text = "© vinzee"
copyrightLabelUI.TextColor3 = Color3.fromRGB(150, 150, 150)
copyrightLabelUI.Font = Enum.Font.SourceSans
copyrightLabelUI.TextSize = 12
copyrightLabelUI.TextXAlignment = Enum.TextXAlignment.Left
copyrightLabelUI.Parent = mainFrame

local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -20, 1, -50)
contentFrame.Position = UDim2.new(0, 10, 0, 40)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

local contentLayout = Instance.new("UIListLayout")
contentLayout.Padding = UDim.new(0, 10)
contentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
contentLayout.Parent = contentFrame

local flingAllButton = Instance.new("TextButton")
flingAllButton.Size = UDim2.new(0.9, 0, 0, 40)
flingAllButton.Text = "Fling All Players"
flingAllButton.Font = Enum.Font.SourceSansBold
flingAllButton.TextSize = 18
flingAllButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flingAllButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
flingAllButton.Parent = contentFrame

local flingAllCorner = Instance.new("UICorner")
flingAllCorner.CornerRadius = UDim.new(0, 6)
flingAllCorner.Parent = flingAllButton

flingAllButton.MouseButton1Click:Connect(function()
    FlingTarget(nil, true)
end)

local targetInput = Instance.new("TextBox")
targetInput.Size = UDim2.new(0.9, 0, 0, 40)
targetInput.PlaceholderText = "Enter target username..."
targetInput.Font = Enum.Font.SourceSans
targetInput.TextSize = 16
targetInput.TextColor3 = Color3.fromRGB(255, 255, 255)
targetInput.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
targetInput.Parent = contentFrame

local targetInputCorner = Instance.new("UICorner")
targetInputCorner.CornerRadius = UDim.new(0, 6)
targetInputCorner.Parent = targetInput

local flingTargetButton = Instance.new("TextButton")
flingTargetButton.Size = UDim2.new(0.9, 0, 0, 40)
flingTargetButton.Text = "Fling Target"
flingTargetButton.Font = Enum.Font.SourceSansBold
flingTargetButton.TextSize = 18
flingTargetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flingTargetButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
flingTargetButton.Parent = contentFrame

local flingTargetCorner = Instance.new("UICorner")
flingTargetCorner.CornerRadius = UDim.new(0, 6)
flingTargetCorner.Parent = flingTargetButton

flingTargetButton.MouseButton1Click:Connect(function()
    FlingTarget(targetInput.Text, false)
end)

-- Join Discord Button
local joinDiscordButton = Instance.new("TextButton")
joinDiscordButton.Size = UDim2.new(0.9, 0, 0, 40)
joinDiscordButton.Text = "Join Discord"
joinDiscordButton.Font = Enum.Font.SourceSansBold
joinDiscordButton.TextSize = 18
joinDiscordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
joinDiscordButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
joinDiscordButton.Parent = contentFrame

local discordCorner = Instance.new("UICorner")
discordCorner.CornerRadius = UDim.new(0, 6)
discordCorner.Parent = joinDiscordButton

local discordLink = "https://discord.gg/QjsgcpFDDr"
joinDiscordButton.MouseButton1Click:Connect(function()
    -- Copy link to clipboard
    setclipboard(discordLink)
    -- Show specific notification
    Message("Discord Link Copied", "The Discord link has been copied to your clipboard! Please paste it in your browser.", 5)
end)

-- Join WhatsApp Group Button
local joinWhatsAppButton = Instance.new("TextButton")
joinWhatsAppButton.Size = UDim2.new(0.9, 0, 0, 40)
joinWhatsAppButton.Text = "Join Group WhatsApp"
joinWhatsAppButton.Font = Enum.Font.SourceSansBold
joinWhatsAppButton.TextSize = 18
joinWhatsAppButton.TextColor3 = Color3.fromRGB(255, 255, 255)
joinWhatsAppButton.BackgroundColor3 = Color3.fromRGB(37, 211, 102)
joinWhatsAppButton.Parent = contentFrame

local whatsappCorner = Instance.new("UICorner")
whatsappCorner.CornerRadius = UDim.new(0, 6)
whatsappCorner.Parent = joinWhatsAppButton

local whatsappLink = "https://chat.whatsapp.com/CTzzMGBGnkJ3jgdfSF0y4d?mode=ac_t"
joinWhatsAppButton.MouseButton1Click:Connect(function()
    -- Copy link to clipboard
    setclipboard(whatsappLink)
    -- Show specific notification
    Message("WhatsApp Link Copied", "The WhatsApp group link has been copied to your clipboard! Please paste it in your browser.", 5)
end)

-- OPEN/CLOSE LOGIC
openButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)
closeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)
