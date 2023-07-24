if game.PlaceId == 537413528 then

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "⛵ Build A Boat For Treasure | Nexus X💫",
    LoadingTitle = "Nexus X💫",
    LoadingSubtitle = "by Flames",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = NexusX, -- Create a custom folder for your hub/game
       FileName = "Nexus Hub"
    },
    Discord = {
       Enabled = true,
       Invite = "MpY7h3WqNh", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
       RememberJoins = false -- Set this to false to make them join the discord every time they load it up
    },
    KeySystem = true, -- Set this to true to use our key system
    KeySettings = {
       Title = "NexusX - Key🔐",
       Subtitle = "Key System",
       Note = "Key Is In Discord",
       FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
       SaveKey = false, -- The user's key will be saved, but if you change the key, they will be unable to use your script
       GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = {"NexusV2Update013"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
 })

 local PlayerTab = Window:CreateTab("LocalPlayer", 10579484688) -- Title, Image

 local Section = PlayerTab:CreateSection("Character")

 -- For WalkSpeed
local WalkSpeedSlider = PlayerTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 250},
    Increment = 1,
    Suffix = "%",
    CurrentValue = 16,
    Flag = "Slider1",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end,
})

-- For JumpPower
local JumpPowerSlider = PlayerTab:CreateSlider({
    Name = "JumpPower",
    Range = {50, 250},
    Increment = 1,
    Suffix = "%",
    CurrentValue = 50,
    Flag = "Slider2",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end,
})

-- For Gravity
local GravitySlider = PlayerTab:CreateSlider({
    Name = "Gravity",
    Range = {0, 500},
    Increment = 1,
    Suffix = "%",
    CurrentValue = 196,
    Flag = "Slider3",
    Callback = function(Value)
        workspace.Gravity = Value
    end,
})

-- For InfiniteJump
-- Note that this is a checkbox since it's a true/false value
-- For InfiniteJump
local jumpConnection
local InfJumpCheckbox = PlayerTab:CreateToggle({
    Name = "Infinite Jump",
    Flag = "Toggle1",
    Callback = function(Value)
        _G.InfiniteJumpEnabled = Value
        if _G.InfiniteJumpEnabled then
            -- Create the connection if it doesn't exist or has been disconnected.
            jumpConnection = jumpConnection or game:GetService("UserInputService").JumpRequest:Connect(function()
                if _G.InfiniteJumpEnabled then
                    game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
                end
            end)
        elseif jumpConnection then
            -- Disconnect the connection if InfiniteJump is disabled.
            jumpConnection:Disconnect()
            jumpConnection = nil
        end
    end,
})

-- For Noclip
local noclipConnection
local NoclipCheckbox = PlayerTab:CreateToggle({
    Name = "Noclip",
    Flag = "Toggle2",
    Callback = function(Value)
        _G.NoclipEnabled = Value
        if _G.NoclipEnabled then
            -- Create the connection if it doesn't exist or has been disconnected.
            noclipConnection = noclipConnection or game:GetService('RunService').Stepped:Connect(function()
                if _G.NoclipEnabled then
                    for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        elseif noclipConnection then
            -- Disconnect the connection if Noclip is disabled.
            noclipConnection:Disconnect()
            noclipConnection = nil
            -- Re-enable collision for character parts.
            for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end,
})


local AutoTab = Window:CreateTab("AutoBuy", 6052557392) -- Title, Image

local Section = AutoTab:CreateSection("Chests")

-- Define loop flags
_G.loopingCommon = false
_G.loopingUncommon = false
_G.loopingRare = false
_G.loopingEpic = false
_G.loopingLegendary = false

-- Define a coroutine to handle the looping action
local function loopAction(chestName, loopingFlag)
    local args = {
        [1] = chestName,
        [2] = 1
    }
    while _G[loopingFlag] do
        workspace:WaitForChild("ItemBoughtFromShop"):InvokeServer(unpack(args))
        wait() -- to prevent locking up the client
    end
end

-- Define toggles
local function createChestToggle(name, flag)
    return AutoTab:CreateToggle({
        Name = "Buy " .. name .. " Chest",
        Flag = flag,
        Callback = function(Value)
            _G[flag] = Value
            if _G[flag] then
                -- Start the loop in a new coroutine
                coroutine.wrap(function()
                    loopAction(name .. " Chest", flag)
                end)()
            end
        end,
    })
end

local ChestToggles = {
    createChestToggle("Common", "loopingCommon"),
    createChestToggle("Uncommon", "loopingUncommon"),
    createChestToggle("Rare", "loopingRare"),
    createChestToggle("Epic", "loopingEpic"),
    createChestToggle("Legendary", "loopingLegendary"),
}

local AutoFarmTab = Window:CreateTab("AutoFarm", 5445557932) -- Title, Image

local Section = AutoFarmTab:CreateSection("Farm")


local Button = AutoFarmTab:CreateButton({
    Name = "AutoFarm",
    Callback = function()
    -- Get the services we need
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

-- Define the teleport destinations
local destinations = {
	Workspace.BoatStages.NormalStages.CaveStage1.DarknessPart,
	Workspace.BoatStages.NormalStages.CaveStage2.DarknessPart,
	Workspace.BoatStages.NormalStages.CaveStage3.DarknessPart,
	Workspace.BoatStages.NormalStages.CaveStage4.DarknessPart,
	Workspace.BoatStages.NormalStages.CaveStage5.DarknessPart,
	Workspace.BoatStages.NormalStages.CaveStage6.DarknessPart,
	Workspace.BoatStages.NormalStages.CaveStage7.DarknessPart,
	Workspace.BoatStages.NormalStages.CaveStage8.DarknessPart,
	Workspace.BoatStages.NormalStages.CaveStage9.DarknessPart,
	Workspace.BoatStages.NormalStages.CaveStage10.DarknessPart,
}

-- Get the player's character
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Define the Tweening information
local tweenInfo = TweenInfo.new(
	2, -- Time
	Enum.EasingStyle.Linear, -- Easing style
	Enum.EasingDirection.InOut, -- Easing direction
	0, -- Repeat count (0 means no repeat)
	false, -- Reverses the tween on completion if true
	0 -- Delay before tween starts
)

-- Function to tween the character to a destination
local function teleportCharacterTo(destination)
	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	if humanoidRootPart then
		local goal = {CFrame = destination.CFrame}
		local tween = TweenService:Create(humanoidRootPart, tweenInfo, goal)

		local humanoid = character:FindFirstChildOfClass("Humanoid")
		local originalGravity = humanoid.JumpPower -- store original jump power
		humanoid.JumpPower = 0 -- set jump power to 0 to "freeze" in air

		-- Anchor the HumanoidRootPart
		local wasAnchored = humanoidRootPart.Anchored
		humanoidRootPart.Anchored = true

		tween.Completed:Connect(function()
			humanoid.JumpPower = originalGravity -- restore original jump power
			-- Restore original anchored state
			humanoidRootPart.Anchored = wasAnchored
		end)

		tween:Play()
		tween.Completed:Wait() -- Wait for the tween to complete before returning
	end
end

-- Teleport the character to each destination in order
for _, destination in ipairs(destinations) do
	teleportCharacterTo(destination)
	wait(0.1) -- Wait for a second between each teleport
end

-- Finally, teleport to TheEnd
teleportCharacterTo(Workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger)
    end,
 })

 local LocalPlayer = game:GetService("Players").LocalPlayer

 local TeleportTab = Window:CreateTab("Teleport", 6052561658) -- Title, Image

 local Section = TeleportTab:CreateSection("Teleports")


 local Button1 = TeleportTab:CreateButton({
	Name = "Really blueZone",
	Callback = function()
		LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(221.835587, -9.89999294, 289.496735, 3.00895917e-05, 1.89661886e-08, -1, -1.8994708e-08, 1, 1.89656184e-08, 1, 1.89941378e-08, 3.00895917e-05)
		Rayfield:Notify({
			Title = "Teleportation",
			Content = "Teleported To Really blueZone",
			Duration = 6.5,
			Image = 5578470911,
			Actions = {
				Ignore = {
					Name = "Okay!",
					Callback = function()
						print("The user acknowledged the teleportation to Really blueZone!")
					end
				},
			},
		})
	end,
})

TeleportTab:CreateButton({
    Name = "CamoZone",
    Callback = function()
       LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-328.966553, -9.89999294, 285.890778, 2.32723869e-05, 4.81436508e-08, 1, -8.0430631e-08, 1, -4.81417786e-08, -1, -8.04295084e-08, 2.32723869e-05)
       
       Rayfield:Notify({
          Title = "Teleportation",
          Content = "Teleported To CamoZone",
          Duration = 6.5,
          Image = 4483362458,
          Actions = {
             Ignore = {
                Name = "Okay!",
                Callback = function()
                   print("The user acknowledged the teleportation to CamoZone!")
                end
             },
          },
       })
    end,
 })
 
 
 TeleportTab:CreateButton({
    Name = "MagentaZone",
    Callback = function()
       LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(221.835083, -9.89999294, 647.695251, -2.21245518e-05, -1.27197168e-08, -1, -7.80432288e-08, 1, -1.27179902e-08, 1, 7.80429446e-08, -2.21245518e-05)
       
       Rayfield:Notify({
          Title = "Teleportation",
          Content = "Teleported To MagentaZone",
          Duration = 6.5,
          Image = 4483362458,
          Actions = {
             Ignore = {
                Name = "Okay!",
                Callback = function()
                   print("The user acknowledged the teleportation to MagentaZone!")
                end
             },
          },
       })
    end,
 })

 TeleportTab:CreateButton({
    Name = "Really redZone",
    Callback = function()
       LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(221.835068, -9.89999294, -68.7047195, -2.20595903e-05, -1.15739818e-08, -1, -8.31205469e-08, 1, -1.15721486e-08, 1, 8.31202911e-08, -2.20595903e-05)
       
       Rayfield:Notify({
          Title = "Teleportation",
          Content = "Teleported To Really redZone",
          Duration = 6.5,
          Image = 4483362458,
          Actions = {
             Ignore = {
                Name = "Okay!",
                Callback = function()
                   print("The user acknowledged the teleportation to Really redZone!")
                end
             },
          },
       })
    end,
 })
 
 TeleportTab:CreateButton({
    Name = "WhiteZone",
    Callback = function()
       LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-53.5637512, -9.89999294, -345.507538, 1, 4.29280682e-08, -2.15271102e-05, -4.29279226e-08, 1, 6.71854927e-09, 2.15271102e-05, -6.71762512e-09, 1)
       
       Rayfield:Notify({
          Title = "Teleportation",
          Content = "Teleported To WhiteZone",
          Duration = 6.5,
          Image = 4483362458,
          Actions = {
             Ignore = {
                Name = "Okay!",
                Callback = function()
                   print("The user acknowledged the teleportation to WhiteZone!")
                end
             },
          },
       })
    end,
 })
 
 TeleportTab:CreateButton({
    Name = "New YellerZone",
    Callback = function()
       LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-328.942108, -9.89999294, 643.876709, -0.00115210481, -5.0259036e-08, 0.999999344, 4.44386856e-08, 1, 5.03102662e-08, -0.999999344, 4.44966162e-08, -0.00115210481)
       
       Rayfield:Notify({
          Title = "Teleportation",
          Content = "Teleported To New YellerZone",
          Duration = 6.5,
          Image = 4483362458,
          Actions = {
             Ignore = {
                Name = "Okay!",
                Callback = function()
                   print("The user acknowledged the teleportation to New YellerZone!")
                end
             },
          },
       })
    end,
 })
 
 local ExtraTab = Window:CreateTab("Extra", 6052579475) -- Title, Image

 local Section = ExtraTab:CreateSection("Extra")

-- Button for Kill All
local ButtonKillAll = ExtraTab:CreateButton({
	Name = "Kill All",
	Callback = function()
		Rayfield:Notify({
            Title = "WARNING",
            Content = "Only Works If Players Have Pvp Mode Enabled",
            Duration = 6.5,
            Image = 11745872910,
            Actions = { -- Notification Buttons
               Ignore = {
                  Name = "Okay!",
                  Callback = function()
                  print("The user tapped Okay!")
               end
            },
         },
         })
		 LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-53.5655861, -360.700012, 9391.29199, 0.999978304, 8.00575783e-09, -0.00659008743, -8.00250088e-09, 1, 5.20489041e-10, 0.00659008743, -4.67740568e-10, 0.999978304)
    print("Successfully Teleported Players")
    game:GetService("RunService").Stepped:connect(function()
        for i,v in pairs (game:GetService("Players"):GetChildren()) do
            if v.TeamColor ~= LocalPlayer.TeamColor and v.Name ~= LocalPlayer.Name then
                v.Character.HumanoidRootPart.Anchored = true
                v.Character.HumanoidRootPart.CFrame = CFrame.new(-53.5905228, -360.700012, 9499.88184, 0.99999994, 5.23848342e-09, 0.000277680316, -5.23909627e-09, 1, 2.20502683e-09, -0.000277680316, -2.20648144e-09, 0.99999994)
            end
        end
    end)
	end,
})

-- Button for Big Head Player
local ButtonBigHead = ExtraTab:CreateButton({
	Name = "Big Head Player",
	Callback = function()
		LocalPlayerName = game:GetService("Players").LocalPlayer.Name
		LocalPlayerWorkspace = game:GetService("Workspace")[LocalPlayerName]
		LocalPlayerWorkspace.Head.Size = Vector3.new(4, 2, 2)
		Rayfield:Notify({
			Title = "Character Modification",
			Content = "Head Enlarged",
			Duration = 6.5,
			Image = 5578470911,
			Actions = {
				Ignore = {
					Name = "Okay!",
					Callback = function()
						print("The user acknowledged the head enlargement!")
					end
				},
			},
		})
	end,
})


Rayfield:LoadConfiguration()


end



--------------------------------- // MM2 \\ -----------------------------------------------
if game.PlaceId == 142823291 then



--<>----<>----<>----<>----<>----<>----<>--
repeat wait() until game:IsLoaded() wait()
    game:GetService("Players").LocalPlayer.Idled:connect(function()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new());
end);
--<>----<>----<>----<>----<>----<>----<>--
--<>----<>----<>----<>----<>----<>----<>--
pcall(function()
    for i, v in pairs(getconnections(game:GetService("ScriptContext").Error)) do
        v:Disable();
    end;
end);
--<>----<>----<>----<>----<>----<>----<>--

--<>----<>----<>----<>----<>----<>----<>--
local Workspace = game:GetService('Workspace');
local ReplicatedStorage = game:GetService('ReplicatedStorage');
local Players = game:GetService('Players');
local Client = Players.LocalPlayer;
local RunService = game:GetService('RunService');
local Workspace = game:GetService("Workspace");
local Lighting = game:GetService("Lighting");
local UIS = game:GetService("UserInputService");
local Teams = game:GetService("Teams");
local ScriptContext = game:GetService("ScriptContext");
local CoreGui = game:GetService("CoreGui");
local Camera = Workspace.CurrentCamera;
local Mouse = Client:GetMouse();
local Terrain = Workspace.Terrain;
local VirtualUser = game:GetService("VirtualUser");
--<>----<>----<>----<>----<>----<>----<>--
local Modules = ReplicatedStorage.Modules;
local EmoteModule = Modules.EmoteModule;
local Emotes = Client.PlayerGui.MainGUI.Game:FindFirstChild("Emotes");
local EmoteList = {"headless","zombie","zen","ninja","floss","dab"};
local CanGrab 
CanGrab = false;

local Origins = {{2,0,0},{-2,0,0},{0,2,0},{0,-2,0},{0,0,1},{0,0,-1}};

local GunHighlight = Instance.new("Highlight");
local GunHandleAdornment = Instance.new("SphereHandleAdornment");

GunHighlight.FillColor = Color3.fromRGB(248, 241, 174);
GunHighlight.Adornee = Workspace:FindFirstChild("GunDrop");
GunHighlight.OutlineTransparency = 1;
GunHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
GunHighlight.RobloxLocked = true;

GunHandleAdornment.Color3 = Color3.fromRGB(248, 241, 174);
GunHandleAdornment.Transparency = 0.2;
GunHandleAdornment.Adornee = Workspace:FindFirstChild("GunDrop");
GunHandleAdornment.AlwaysOnTop = true;
GunHandleAdornment.AdornCullingMode = Enum.AdornCullingMode.Never;
GunHandleAdornment.RobloxLocked = true;

GunHighlight.Parent = CoreGui;
GunHandleAdornment.Parent = CoreGui;

local Client = game:GetService("Players").LocalPlayer -- Assuming Client is the local player
local RootPart = Client.Character.HumanoidRootPart

local lobbyPosition = CFrame.new(-99.068924, 140.449982, 43.3706665, -0.981621504, 0, 0.190838262, 0, 1, 0, -0.190838262, 0, -0.981621504)
local votePosition = CFrame.new(-110.874992, 136, 92.125, 1, 0, 0, 0, 1, 0, 0, 0, 1)


local currentPos = 1 -- variable to keep track of the current position


local function notify(title, content)
    Rayfield:Notify({
        Title = title,
        Content = content,
        Duration = 6.5,
        Image = 4483362458,
        Actions = {
            Ignore = {
                Name = "Okay!",
                Callback = function()
                    print("The user tapped Okay!")
                end
            },
        },
    })
end

local Murderer, Sheriff = nil, nil;

function GetMurderer()
    for i,v in pairs(Players:GetChildren()) do 
        if v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") and v.Name == "Tool" then
            return v.Name;
        end;
    end;
    return nil;
end;

function GetSheriff()
    for i,v in pairs(Players:GetChildren()) do 
        if v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun") and v.Name == "Tool" then
            return v.Name;
        end;
        return nil;
    end;
end;
--<>----<>----<>----<>----<>----<>----<>--
local Character = nil;
local RootPart = nil;
local Humanoid = nil;

getgenv().WS = 16
getgenv().JP = 50
function SetCharVars()
	Character = Client.Character;
	Humanoid = Character:FindFirstChild("Humanoid") or Character:WaitForChild("Humanoid");
	RootPart = Character:FindFirstChild("HumanoidRootPart") or Character:WaitForChild("HumanoidRootPart");
	if getgenv().Speed then
		Humanoid.WalkSpeed = getgenv().WS;
	end;
	Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
		if getgenv().Speed then
			Humanoid.WalkSpeed = getgenv().WS;
		end;
	end);
    if getgenv().Jump then
		Humanoid.WalkSpeed = getgenv().JP;
	end;
	Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
		if getgenv().Jump then
			Humanoid.WalkSpeed = getgenv().JP;
		end;
	end);
end;
SetCharVars();
Client.CharacterAdded:Connect(SetCharVars);

local Ws;
Ws = hookmetamethod(game, "__index", function(self, Value)
    if tostring(self) == "Humanoid" and tostring(Value) == "WalkSpeed" then
        return 16;
    end;
    return Ws(self, Value);
end);

local Jp;
Jp = hookmetamethod(game, "__index", function(self, Value)
    if tostring(self) == "Humanoid" and tostring(Value) == "WalkSpeed" then
        return 16;
    end;
    return Jp(self, Value);
end);

--<>----<>----<>----<>----<>----<>----<>--
local c;
local h;
local bv;
local bav;
local cam;
local flying;
local p = Client;
local buttons = {W = false, S = false, A = false, D = false, Moving = false};

local StartFly = function ()
    if not Client.Character or not Character.Head or flying then return end;
    c = Character;
    h = Humanoid;
    h.PlatformStand = true;
    cam = workspace:WaitForChild('Camera');
    bv = Instance.new("BodyVelocity");
    bav = Instance.new("BodyAngularVelocity");
    bv.Velocity, bv.MaxForce, bv.P = Vector3.new(0, 0, 0), Vector3.new(10000, 10000, 10000), 1000;
    bav.AngularVelocity, bav.MaxTorque, bav.P = Vector3.new(0, 0, 0), Vector3.new(10000, 10000, 10000), 1000;
    bv.Parent = c.Head;
    bav.Parent = c.Head;
    flying = true;
    h.Died:connect(function() flying = false end);
end;

local EndFly = function ()
    if not p.Character or not flying then return end
    h.PlatformStand = false;
    bv:Destroy();
    bav:Destroy();
    flying = false;
end;

game:GetService("UserInputService").InputBegan:connect(function (input, GPE) 
    if GPE then return end;
    for i, e in pairs(buttons) do
        if i ~= "Moving" and input.KeyCode == Enum.KeyCode[i] then
            buttons[i] = true;
            buttons.Moving = true;
        end;
    end;
end);

game:GetService("UserInputService").InputEnded:connect(function (input, GPE) 
    if GPE then return end;
    local a = false;
    for i, e in pairs(buttons) do
        if i ~= "Moving" then
            if input.KeyCode == Enum.KeyCode[i] then
                buttons[i] = false;
            end;
            if buttons[i] then a = true end;
        end;
    end;
    buttons.Moving = a;
end);

local setVec = function (vec)
    return vec * ((getgenv().FlySpeed or 50) / vec.Magnitude);
end;

game:GetService("RunService").Heartbeat:connect(function (step) -- The actual fly function, called every frame
    if flying and c and c.PrimaryPart then
        local p = c.PrimaryPart.Position;
        local cf = cam.CFrame;
        local ax, ay, az = cf:toEulerAnglesXYZ();
        c:SetPrimaryPartCFrame(CFrame.new(p.x, p.y, p.z) * CFrame.Angles(ax, ay, az));
        if buttons.Moving then
            local t = Vector3.new();
            if buttons.W then t = t + (setVec(cf.lookVector)) end;
            if buttons.S then t = t - (setVec(cf.lookVector)) end;
            if buttons.A then t = t - (setVec(cf.rightVector)) end;
            if buttons.D then t = t + (setVec(cf.rightVector)) end;
            c:TranslateBy(t * step);
        end;
    end;
end);


local accessories = {}

function GodMode()
    local player = game.Players.LocalPlayer
    local character = player.Character
    
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            for _, accessory in pairs(humanoid:GetAccessories()) do
                table.insert(accessories, accessory:Clone())
            end
            humanoid.Name = "boop"
            
            local clonedHumanoid = character["boop"]:Clone()
            clonedHumanoid.Parent = character
            clonedHumanoid.Name = "Humanoid"
            wait(0.1)
            
            character["boop"]:Destroy()
            
            workspace.CurrentCamera.CameraSubject = character.Humanoid
            for _, accessory in pairs(accessories) do
                character.Humanoid:AddAccessory(accessory)
            end
            
            local animate = character:FindFirstChild("Animate")
            if animate then
                animate.Disabled = true
                wait(0.1)
                animate.Disabled = false
            end
        end
    end
end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()


local mm2Window = Rayfield:CreateWindow({
    Name = "🔪 Murder Mystery 2 | Nexus X💫",
    LoadingTitle = "Nexus X💫",
    LoadingSubtitle = "by Flames",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "NexusX", -- Create a custom folder for your hub/game
        FileName = "Nexus Hub"
    },
    Discord = {
        Enabled = true,
        Invite = "MpY7h3WqNh", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
        RememberJoins = false -- Set this to false to make them join the discord every time they load it up
    },
    KeySystem = true, -- Set this to true to use our key system
    KeySettings = {
        Title = "NexusX - Key🔐",
        Subtitle = "Key System",
        Note = "Key Is In Discord",
        FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
        SaveKey = false, -- The user's key will be saved, but if you change the key, they will be unable to use your script
        GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
        Key = {"NexusV2Update013"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22", "🔪", "|")
    }
})

local HomeTab = mm2Window:CreateTab("🏠 Home", nil) -- Title, Image

 local Section = HomeTab:CreateSection("⬆️ Stats")

local Paragraph7 = HomeTab:CreateParagraph({
    Title = "",
    Content = [[
    📢 7. Report Bugs: Please report any bugs or issues you encounter in our Discord server. We value your feedback!
    ]]
})

local Paragraph8 = HomeTab:CreateParagraph({
    Title = "",
    Content = [[
    👏 As always, thank you for your continued support!
    ]]
})

local CreditsSection = HomeTab:CreateSection("👨‍💻 Dev")
local CreditsParagraph = HomeTab:CreateParagraph({
    Title = "🏆 Credits",
    Content = "🎉 This script was created by Flames. Special thanks to everyone who contributed. 🥳"
})



local Section = HomeTab:CreateSection("❌ Remove GUI")

local Button = HomeTab:CreateButton({
    Name = "Delete GUI",
    Callback = function()
        Rayfield:Destroy()
    end,
 })



local PlayerTab = mm2Window:CreateTab("⚜️ LocalPlayer", nil) -- Title, Image

 local Section = PlayerTab:CreateSection("🎭 Character")

 -- For WalkSpeed
local WalkSpeedSlider = PlayerTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 250},
    Increment = 1,
    Suffix = "%",
    CurrentValue = 16,
    Flag = "Slider1",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end,
})

-- For JumpPower
local JumpPowerSlider = PlayerTab:CreateSlider({
    Name = "JumpPower",
    Range = {50, 250},
    Increment = 1,
    Suffix = "%",
    CurrentValue = 50,
    Flag = "Slider2",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end,
})

-- For Gravity
local GravitySlider = PlayerTab:CreateSlider({
    Name = "Gravity",
    Range = {0, 500},
    Increment = 1,
    Suffix = "%",
    CurrentValue = 196,
    Flag = "Slider3",
    Callback = function(Value)
        workspace.Gravity = Value
    end,
})

local Button = PlayerTab:CreateButton({
    Name = "Reset Gravity",
    Callback = function()
        workspace.Gravity = 196.2
    end,
 })

-- For InfiniteJump
-- Note that this is a checkbox since it's a true/false value
-- For InfiniteJump
local jumpConnection
local InfJumpCheckbox = PlayerTab:CreateToggle({
    Name = "Infinite Jump",
    Flag = "Toggle1",
    Callback = function(Value)
        _G.InfiniteJumpEnabled = Value
        if _G.InfiniteJumpEnabled then
            -- Create the connection if it doesn't exist or has been disconnected.
            jumpConnection = jumpConnection or game:GetService("UserInputService").JumpRequest:Connect(function()
                if _G.InfiniteJumpEnabled then
                    game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
                end
            end)
        elseif jumpConnection then
            -- Disconnect the connection if InfiniteJump is disabled.
            jumpConnection:Disconnect()
            jumpConnection = nil
        end
    end,
})

-- For Noclip
local noclipConnection
local NoclipCheckbox = PlayerTab:CreateToggle({
    Name = "Noclip",
    Flag = "Toggle2",
    Callback = function(Value)
        _G.NoclipEnabled = Value
        if _G.NoclipEnabled then
            -- Create the connection if it doesn't exist or has been disconnected.
            noclipConnection = noclipConnection or game:GetService('RunService').Stepped:Connect(function()
                if _G.NoclipEnabled then
                    for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        elseif noclipConnection then
            -- Disconnect the connection if Noclip is disabled.
            noclipConnection:Disconnect()
            noclipConnection = nil
            -- Re-enable collision for character parts.
            for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end,
})




local Button = PlayerTab:CreateButton({
    Name = "God Mode",
    Callback = function()
        GodMode()
    end,
 })

 local Section = PlayerTab:CreateSection("✈️ Flight")

 local Toggle = PlayerTab:CreateToggle({
    Name = "Flight",
    CurrentValue = false,
    Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(state)
        getgenv().Flying = state;
        if getgenv().Flying then
            StartFly();
        else
            EndFly();
        end;
    end,
 })

 local Slider = PlayerTab:CreateSlider({
    Name = "Flight Speed",
    Range = {20, 150},
    Increment = 1,
    Suffix = "%",
    CurrentValue = 50,
    Flag = "Slider1", -- A flag is the identifier ✈️ for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(val)
        getgenv().FlySpeed = tonumber(val) or 50;
    end,
 })

 local Section = PlayerTab:CreateSection("👾 Extra")

 local Toggle = PlayerTab:CreateToggle({
    Name = "Ctrl-Click TP",
    CurrentValue = false,
    Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(state)
        getgenv().ClickTP = state;
    end,
 })
 Mouse.Button1Down:connect(function()
    if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then return end;
    if not Mouse.Target then return end;
    if not getgenv().ClickTP then return end;
    Character:MoveTo(Mouse.Hit.p);
end)

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local defaultSpeed = 16 -- replace this with the default walkspeed
local shiftSpeed = 32 -- replace this with the initial speed when shift is held

local function updateWalkSpeed(player, isShifted)
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = isShifted and shiftSpeed or defaultSpeed
        end
    end
end

local shiftEnabled = false

local Toggle = PlayerTab:CreateToggle({
    Name = "Shift Sprint",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        shiftEnabled = Value
        if not Value then
            updateWalkSpeed(Players.LocalPlayer, false)
        end
    end,
})

local Slider = PlayerTab:CreateSlider({
    Name = "Sprint Speed",
    Range = {0, 100},
    Increment = 1,
    Suffix = "Studs/Sec",
    CurrentValue = shiftSpeed,
    Flag = "Slider1",
    Callback = function(Value)
        shiftSpeed = Value
        if shiftEnabled and UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            updateWalkSpeed(Players.LocalPlayer, true)
        end
    end,
})

UserInputService.InputBegan:Connect(function(input)
    if shiftEnabled and input.KeyCode == Enum.KeyCode.LeftShift then
        updateWalkSpeed(Players.LocalPlayer, true)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if shiftEnabled and input.KeyCode == Enum.KeyCode.LeftShift then
        updateWalkSpeed(Players.LocalPlayer, false)
    end
end)


 local Section = PlayerTab:CreateSection("❓ Useless")

 local Button = PlayerTab:CreateButton({
    Name = "Btools",
    Callback = function()
        if not Client.Backpack:FindFirstChildOfClass("HopperBin") then
            local tool1 = Instance.new("HopperBin", Client.Backpack)
            local tool2 = Instance.new("HopperBin", Client.Backpack)
            local tool3 = Instance.new("HopperBin", Client.Backpack)
            local tool4 = Instance.new("HopperBin", Client.Backpack)
            local tool5 = Instance.new("HopperBin", Client.Backpack)
            tool1.BinType = Enum.BinType.Clone
            tool2.BinType = Enum.BinType.GameTool
            tool3.BinType = Enum.BinType.Hammer
            tool4.BinType = Enum.BinType.Script
            tool5.BinType = Enum.BinType.Grab
        end
        
    end,
 })

 local Section = PlayerTab:CreateSection("⚠️ Emergency Stop")

 local Button = PlayerTab:CreateButton({
    Name = "Force Reset",
    Callback = function()
        Character.Head:Remove();
		Humanoid.BreakJointsOnDeath = false;
		Humanoid.Health = 0;
    end,
 })



local ESPTab = mm2Window:CreateTab("👁️‍🗨️ Visuals", nil) -- Title, Image

local Section = ESPTab:CreateSection("👁️ ESP")

local folder = Instance.new("Folder",CoreGui);
folder.Name = "ESP Holder";
	
local function AddBillboard(player)
    local billboard = Instance.new("BillboardGui",folder);
    billboard.Name = player.Name;
    billboard.AlwaysOnTop = true;
    billboard.Size = UDim2.fromOffset(200,50);
    billboard.ExtentsOffset = Vector3.new(0,3,0);
    billboard.Enabled = false

    local textLabel = Instance.new("TextLabel",billboard);
    textLabel.TextSize = 20;
    textLabel.Text = player.Name;
    textLabel.Font = Enum.Font.SourceSans;
    textLabel.BackgroundTransparency = 1;
    textLabel.Size = UDim2.fromScale(1,1);

    if getgenv().AllEsp then
        billboard.Enabled = true
    end
    repeat
        wait()
        pcall(function()
            billboard.Adornee = player.Character.Head;
            if player.Character:FindFirstChild("Knife") or player.Backpack:FindFirstChild("Knife") then
                textLabel.TextColor3 = Color3.new(1,0,0);
                if not billboard.Enabled and getgenv().MurderEsp then
                    billboard.Enabled = true
                end
            elseif player.Character:FindFirstChild("Gun") or player.Backpack:FindFirstChild("Gun") then
                textLabel.TextColor3 = Color3.new(0,0,1);
                if not billboard.Enabled and getgenv().SheriffEsp then
                    billboard.Enabled = true
                end
            else
                textLabel.TextColor3 = Color3.new(0,1,0);
            end;
        end);
    until not player.Parent;
end;

for _,player in pairs(Players:GetPlayers()) do
    if player ~= Client then
        coroutine.wrap(AddBillboard)(player);
    end;
end;
Players.PlayerAdded:Connect(AddBillboard);

Players.PlayerRemoving:Connect(function(player)
    folder[player.Name]:Destroy();
end);


local Toggle = ESPTab:CreateToggle({
    Name = "All Esp",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(state)
        getgenv().AllEsp = state;
        for i, v in pairs(folder:GetChildren()) do
            if v:IsA("BillboardGui") and Players[tostring(v.Name)] then
                if getgenv().AllEsp then
                    v.Enabled = true;
                else
                    v.Enabled = false;
                end;
            end;
        end;
    end,
})


local ToggleMurderESP = ESPTab:CreateToggle({
    Name = "Murder Only ESP",
    CurrentValue = false,
    Flag = "ToggleMurderESP",
    Callback = function(state)
        getgenv().MurderEsp = state;
        while getgenv().MurderEsp do
            wait()
            pcall(function()
                for i, v in pairs(folder:GetChildren()) do
                    if v:IsA("BillboardGui") and Players[tostring(v.Name)] then
                        if Players[tostring(v.Name)].Character:FindFirstChild("Knife") or Players[tostring(v.Name)].Backpack:FindFirstChild("Knife")  then
                            if getgenv().MurderEsp then
                                v.Enabled = true;
                            else
                                v.Enabled = false;
                            end;
                        end
                    end;
                end;
            end);
        end;
    end,
})

local ToggleSheriffESP = ESPTab:CreateToggle({
    Name = "Sheriff Only ESP",
    CurrentValue = false,
    Flag = "ToggleSheriffESP",
    Callback = function(state)
        getgenv().SheriffEsp = state;
        while getgenv().SheriffEsp do
            wait()
            pcall(function()
                for i, v in pairs(folder:GetChildren()) do
                    if v:IsA("BillboardGui") and Players[tostring(v.Name)] then
                        if Players[tostring(v.Name)].Character:FindFirstChild("Gun") or Players[tostring(v.Name)].Backpack:FindFirstChild("Gun")  then
                            if getgenv().SheriffEsp then
                                v.Enabled = true;
                            else
                                v.Enabled = false;
                            end;
                        end
                    end;
                end;
            end);
        end;
    end,
})

local ToggleGunESP = ESPTab:CreateToggle({
    Name = "Gun ESP",
    CurrentValue = false,
    Flag = "ToggleGunESP",
    Callback = function(state)
        getgenv().GunESP = state;
    end,
})

coroutine.wrap(function()
    RunService.RenderStepped:Connect(function()
        pcall(function()
            if getgenv().GunESP then
                local gundrop = Workspace:FindFirstChild("GunDrop");
                GunHighlight.Adornee = gundrop;
                GunHandleAdornment.Adornee = gundrop;
                if gundrop then 
                    GunHandleAdornment.Size = gundrop.Size + Vector3.new(0.05, 0.05, 0.05) ;
                end;
        
                GunHighlight.Enabled = getgenv().GunESP;
                GunHandleAdornment.Visible = getgenv().GunESP;
            end;
        end);
    end);
end)();

local Section = ESPTab:CreateSection("✏️ Chams")

-- > Declarations < --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local roles

-- > Functions <--

function CreateHighlight(v) -- make any new highlights for new players
	if v ~= LP and v.Character and not v.Character:FindFirstChild("Highlight") then
		Instance.new("Highlight", v.Character)
	end
end

function UpdateHighlight(v) -- Get Current Role Colors (messy)
	if v ~= LP and v.Character and v.Character:FindFirstChild("Highlight") then
		Highlight = v.Character:FindFirstChild("Highlight")
		if v.Name == Sheriff and IsAlive(v) then
			Highlight.FillColor = Color3.fromRGB(0, 0, 225)
		elseif v.Name == Murder and IsAlive(v) then
			Highlight.FillColor = Color3.fromRGB(225, 0, 0)
		elseif v.Name == Hero and IsAlive(v) then
			Highlight.FillColor = Color3.fromRGB(255, 250, 0)
		else
			Highlight.FillColor = Color3.fromRGB(0, 225, 0)
		end
	end
end

function IsAlive(Player) -- Simple function
	for i, v in pairs(roles) do
		if Player.Name == i then
			if not v.Killed and not v.Dead then
				return true
			else
				return false
			end
		end
	end
end

function UpdateESP()
    if getgenv().AllEsp then
        roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
        for i, v in pairs(roles) do
            if v.Role == "Murderer" then
                Murder = i
            elseif v.Role == 'Sheriff' then
                Sheriff = i
            elseif v.Role == 'Hero' then
                Hero = i
            end
        end

        local players = game:GetService("Players"):GetPlayers()
        for _, v in pairs(players) do
            CreateHighlight(v)
            UpdateHighlight(v)
        end
    else
        local players = game:GetService("Players"):GetPlayers()
        for _, v in pairs(players) do
            local playerESP = v.Character:FindFirstChild("Highlight")
            if playerESP then
                playerESP:Destroy()
            end
        end
    end
end

local Toggle = ESPTab:CreateToggle({
    Name = "All Players Cham",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(state)
        getgenv().AllEsp = state
        UpdateESP()
    end,
})

game:GetService("Players").PlayerAdded:Connect(function(player)
    if getgenv().AllEsp then
        UpdateESP()
    end
end)

game:GetService("Players").PlayerRemoving:Connect(function(player)
    local playerESP = player.Character:FindFirstChild("Highlight")
    if playerESP then
        playerESP:Destroy()
    end
end)




local Workspace = game:GetService("Workspace")

local holder = game.CoreGui:FindFirstChild("ESPHolder") or Instance.new("Folder")

if holder.Name == "Folder" then
    holder.Name = "ESPHolder"
    holder.Parent = game.CoreGui
end

local Toggle = ESPTab:CreateToggle({
    Name = "Coin Cham",
    CurrentValue = false,
    Flag = "ToggleESP", 
    Callback = function(Value)
        if Value then
            for _,v in pairs(Workspace:GetDescendants()) do
                if v.Name == "CoinContainer" then
                    local esp = holder:FindFirstChild(v:GetFullName()) or Instance.new("Highlight")
                    esp.Name = v:GetFullName()
                    esp.Parent = holder
                    esp.FillColor = Color3.fromRGB(255, 215, 0) -- Gold color for coins
                    esp.OutlineColor = Color3.fromRGB(255, 215, 0) 
                    esp.FillTransparency = 0.8
                    esp.OutlineTransparency = 0
                    esp.Adornee = v
                    esp.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                end
            end
        else
            for _,v in pairs(holder:GetChildren()) do
                v:Destroy()
            end
        end
    end,
})





-- > Declarations < --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer
local roles
local murdererStepped, sheriffStepped

local highlights = {}

-- > Functions <--
function CreateHighlight(player, role) 
    if player ~= LP and player.Character and not player.Character:FindFirstChild("Highlight") then
        local Highlight = Instance.new("Highlight", player.Character)
        Highlight.FillColor = (role == "Murderer") and Color3.fromRGB(225, 0, 0) or Color3.fromRGB(0, 0, 225)
        highlights[player] = Highlight
    end
end

function RemoveHighlight(player)
    if player.Character and highlights[player] then
        highlights[player]:Destroy()
        highlights[player] = nil
    end
end

-- > Toggle ESP < --
local ToggleMurderESP = ESPTab:CreateToggle({
    Name = "Murder Only Cham",
    CurrentValue = false,
    Flag = "ToggleMurderESP",
    Callback = function(state)
        if state then
            murdererStepped = RunService.RenderStepped:Connect(function()
                roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
                for i, v in pairs(roles) do
                    if v.Role == "Murderer" and not v.Killed and not v.Dead then
                        CreateHighlight(game.Players[i], "Murderer")
                    end
                end
            end)
        else
            if murdererStepped then
                murdererStepped:Disconnect()
                murdererStepped = nil
                for i, v in pairs(roles) do
                    if v.Role == "Murderer" then
                        RemoveHighlight(game.Players[i])
                    end
                end
            end
        end
    end,
})

local ToggleSheriffESP = ESPTab:CreateToggle({
    Name = "Sheriff Only Cham",
    CurrentValue = false,
    Flag = "ToggleSheriffESP",
    Callback = function(state)
        if state then
            sheriffStepped = RunService.RenderStepped:Connect(function()
                roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
                for i, v in pairs(roles) do
                    if v.Role == 'Sheriff' and not v.Killed and not v.Dead then
                        CreateHighlight(game.Players[i], 'Sheriff')
                    end
                end
            end)
        else
            if sheriffStepped then
                sheriffStepped:Disconnect()
                sheriffStepped = nil
                for i, v in pairs(roles) do
                    if v.Role == 'Sheriff' then
                        RemoveHighlight(game.Players[i])
                    end
                end
            end
        end
    end,
})



local Section = ESPTab:CreateSection("🎉 Fun")

local ButtonFakeInventory = ESPTab:CreateButton({
    Name = "Fake Inventory",
    Callback = function()
        local WeaponOwnRange = {
            min=1,
            max=5
           }
           
           local DataBase, PlayerData = getrenv()._G.Database, getrenv()._G.PlayerData
           
           local newOwned = {}
           
           for i,v in next, DataBase.Item do
            newOwned[i] = math.random(WeaponOwnRange.min, WeaponOwnRange.max) -- newOwned[Weapon]: ItemCount
           end
           
           local PlayerWeapons = PlayerData.Weapons
           
           game:GetService("RunService"):BindToRenderStep("InventoryUpdate", 0, function()
            PlayerWeapons.Owned = newOwned
           end)
           
           game.Players.LocalPlayer.Character.Humanoid.Health = 0
           
           
    end,
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Modules = ReplicatedStorage.Modules
local EmoteModule = Modules.EmoteModule
local EmoteList = {"headless","zombie","zen","ninja","floss","dab"}

local function setEmotes(character)
    -- We have to wait until PlayerGui is added to character
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    local Emotes = PlayerGui:WaitForChild("MainGUI"):WaitForChild("Game"):FindFirstChild("Emotes")
    
    if Emotes then
        require(EmoteModule).GeneratePage(EmoteList, Emotes, 'Free Emotes')
    else
        warn("Emotes not found.")
    end
end

-- Create a button
local Button = ESPTab:CreateButton({
   Name = "Get All Emotes",
   Callback = function()
       -- Initial call for the current character
       setEmotes(LocalPlayer.Character)

       -- And then every time the character is added (respawned)
       LocalPlayer.CharacterAdded:Connect(setEmotes)
   end,
})


local Button = ESPTab:CreateButton({
    Name = "Roblox Free Emotes (Comma To Open) (wasnt made by me)",
    Callback = function()
    --keybind to open is comma
local ContextActionService = game:GetService("ContextActionService")
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local CoreGui = game:GetService("CoreGui")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")

local Emotes = {}
local LoadedEmotes = {}
local function AddEmote(name: string, id: IntValue, price: IntValue?)
	LoadedEmotes[id] = false
	task.spawn(function()
		if not (name and id) then
			return
		end
		local success, date = pcall(function()
			local info = MarketplaceService:GetProductInfo(id)
			local updated = info.Updated
			return DateTime.fromIsoDate(updated):ToUniversalTime()
		end)
		if not success then
			task.wait(10)
			AddEmote(name, id, price)
			return
		end
		local unix = os.time({
			year = date.Year,
			month = date.Month,
			day = date.Day,
			hour = date.Hour,
			min = date.Minute,
			sec = date.Second
		})
		LoadedEmotes[id] = true
		table.insert(Emotes, {
			["name"] = name,
			["id"] = id,
			["icon"] = "rbxthumb://type=Asset&id=".. id .."&w=150&h=150",
			["price"] = price or 0,
			["lastupdated"] = unix,
			["sort"] = {}
		})
	end)
end
local CurrentSort = "recentfirst"

local FavoriteOff = "rbxassetid://10651060677"
local FavoriteOn = "rbxassetid://10651061109"
local FavoritedEmotes = {}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Emotes"
ScreenGui.DisplayOrder = 2
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Enabled = false

local BackFrame = Instance.new("Frame")
BackFrame.Size = UDim2.new(0.9, 0, 0.5, 0)
BackFrame.AnchorPoint = Vector2.new(0.5, 0.5)
BackFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
BackFrame.SizeConstraint = Enum.SizeConstraint.RelativeYY
BackFrame.BackgroundTransparency = 1
BackFrame.BorderSizePixel = 0
BackFrame.Parent = ScreenGui

local EmoteName = Instance.new("TextLabel")
EmoteName.Name = "EmoteName"
EmoteName.TextScaled = true
EmoteName.AnchorPoint = Vector2.new(0.5, 0.5)
EmoteName.Position = UDim2.new(-0.1, 0, 0.5, 0)
EmoteName.Size = UDim2.new(0.2, 0, 0.2, 0)
EmoteName.SizeConstraint = Enum.SizeConstraint.RelativeYY
EmoteName.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
EmoteName.TextColor3 = Color3.new(1, 1, 1)
EmoteName.BorderSizePixel = 0
EmoteName.Parent = BackFrame

local Corner = Instance.new("UICorner")
Corner.Parent = EmoteName

local Loading = Instance.new("TextLabel", BackFrame)
Loading.AnchorPoint = Vector2.new(0.5, 0.5)
Loading.Text = "Loading..."
Loading.TextColor3 = Color3.new(1, 1, 1)
Loading.BackgroundColor3 = Color3.new(0, 0, 0)
Loading.TextScaled = true
Loading.BackgroundTransparency = 0.5
Loading.Size = UDim2.fromScale(0.2, 0.1)
Loading.Position = UDim2.fromScale(0.5, 0.2)
Corner:Clone().Parent = Loading

local Frame = Instance.new("ScrollingFrame")
Frame.Size = UDim2.new(1, 0, 1, 0)
Frame.CanvasSize = UDim2.new(0, 0, 0, 0)
Frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
Frame.ScrollingDirection = Enum.ScrollingDirection.Y
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.BackgroundTransparency = 1
Frame.ScrollBarThickness = 5
Frame.BorderSizePixel = 0
Frame.MouseLeave:Connect(function()
	EmoteName.Text = "Select an Emote"
end)
Frame.Parent = BackFrame

local Grid = Instance.new("UIGridLayout")
Grid.CellSize = UDim2.new(0.105, 0, 0, 0)
Grid.CellPadding = UDim2.new(0.006, 0, 0.006, 0)
Grid.SortOrder = Enum.SortOrder.LayoutOrder
Grid.Parent = Frame

local SortFrame = Instance.new("Frame")
SortFrame.Visible = false
SortFrame.BorderSizePixel = 0
SortFrame.Position = UDim2.new(1, 5, -0.125, 0)
SortFrame.Size = UDim2.new(0.2, 0, 0, 0)
SortFrame.AutomaticSize = Enum.AutomaticSize.Y
SortFrame.BackgroundTransparency = 1
Corner:Clone().Parent = SortFrame
SortFrame.Parent = BackFrame

local SortList = Instance.new("UIListLayout")
SortList.Padding = UDim.new(0.02, 0)
SortList.HorizontalAlignment = Enum.HorizontalAlignment.Center
SortList.VerticalAlignment = Enum.VerticalAlignment.Top
SortList.SortOrder = Enum.SortOrder.LayoutOrder
SortList.Parent = SortFrame

local function SortEmotes()
	for i,Emote in pairs(Emotes) do
		local EmoteButton = Frame:FindFirstChild(Emote.id)
		if not EmoteButton then
			continue
		end
		local IsFavorited = table.find(FavoritedEmotes, Emote.id)
		EmoteButton.LayoutOrder = Emote.sort[CurrentSort] + ((IsFavorited and 0) or #Emotes)
		EmoteButton.number.Text = Emote.sort[CurrentSort]
	end
end

local function createsort(order, text, sort)
	local CreatedSort = Instance.new("TextButton")
	CreatedSort.SizeConstraint = Enum.SizeConstraint.RelativeXX
	CreatedSort.Size = UDim2.new(1, 0, 0.2, 0)
	CreatedSort.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	CreatedSort.LayoutOrder = order
	CreatedSort.TextColor3 = Color3.new(1, 1, 1)
	CreatedSort.Text = text
	CreatedSort.TextScaled = true
	CreatedSort.BorderSizePixel = 0
	Corner:Clone().Parent = CreatedSort
	CreatedSort.Parent = SortFrame
	CreatedSort.MouseButton1Click:Connect(function()
		SortFrame.Visible = false
		CurrentSort = sort
		SortEmotes()
	end)
	return CreatedSort
end

createsort(1, "Recently Updated First", "recentfirst")
createsort(2, "Recently Updated Last", "recentlast")
createsort(3, "Alphabetically First", "alphabeticfirst")
createsort(4, "Alphabetically Last", "alphabeticlast")
createsort(5, "Highest Price", "highestprice")
createsort(6, "Lowest Price", "lowestprice")

local SortButton = Instance.new("TextButton")
SortButton.BorderSizePixel = 0
SortButton.AnchorPoint = Vector2.new(0.5, 0.5)
SortButton.Position = UDim2.new(0.925, -5, -0.075, 0)
SortButton.Size = UDim2.new(0.15, 0, 0.1, 0)
SortButton.TextScaled = true
SortButton.TextColor3 = Color3.new(1, 1, 1)
SortButton.BackgroundColor3 = Color3.new(0, 0, 0)
SortButton.BackgroundTransparency = 0.3
SortButton.Text = "Sort"
SortButton.MouseButton1Click:Connect(function()
	SortFrame.Visible = not SortFrame.Visible
end)
Corner:Clone().Parent = SortButton
SortButton.Parent = BackFrame

local CloseButton = Instance.new("TextButton")
CloseButton.BorderSizePixel = 0
CloseButton.AnchorPoint = Vector2.new(0.5, 0.5)
CloseButton.Position = UDim2.new(0.075, 0, -0.075, 0)
CloseButton.Size = UDim2.new(0.15, 0, 0.1, 0)
CloseButton.TextScaled = true
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.BackgroundColor3 = Color3.new(0, 0, 0)
CloseButton.BackgroundTransparency = 0.3
CloseButton.Text = "Close"
CloseButton.MouseButton1Click:Connect(function()
	ScreenGui.Enabled = false
end)
Corner:Clone().Parent = CloseButton
CloseButton.Parent = BackFrame

local SearchBar = Instance.new("TextBox")
SearchBar.BorderSizePixel = 0
SearchBar.AnchorPoint = Vector2.new(0.5, 0.5)
SearchBar.Position = UDim2.new(0.5, 0, -0.075, 0)
SearchBar.Size = UDim2.new(0.55, 0, 0.1, 0)
SearchBar.TextScaled = true
SearchBar.PlaceholderText = "Search"
SearchBar.TextColor3 = Color3.new(1, 1, 1)
SearchBar.BackgroundColor3 = Color3.new(0, 0, 0)
SearchBar.BackgroundTransparency = 0.3
SearchBar:GetPropertyChangedSignal("Text"):Connect(function()
	local text = SearchBar.Text:lower()
	local buttons = Frame:GetChildren()
	if text ~= text:sub(1,50) then
		SearchBar.Text = SearchBar.Text:sub(1,50)
		text = SearchBar.Text:lower()
	end
	if text ~= ""  then
		for i,button in pairs(buttons) do
			if button:IsA("GuiButton") then
				local name = button:GetAttribute("name"):lower()
				if name:match(text) then
					button.Visible = true
				else
					button.Visible = false
				end
			end
		end
	else
		for i,button in pairs(buttons) do
			if button:IsA("GuiButton") then
				button.Visible = true
			end
		end
	end
end)
Corner:Clone().Parent = SearchBar
SearchBar.Parent = BackFrame

local function openemotes(name, state, input)
	if state == Enum.UserInputState.Begin then
		ScreenGui.Enabled = not ScreenGui.Enabled
	end
end

ContextActionService:BindCoreActionAtPriority(
	"Emote Menu",
	openemotes,
	true,
	2001,
	Enum.KeyCode.Comma
)

local inputconnect
ScreenGui:GetPropertyChangedSignal("Enabled"):Connect(function()
	if ScreenGui.Enabled == true then
		EmoteName.Text = "Select an Emote"
		SearchBar.Text = ""
		SortFrame.Visible = false
		GuiService:SetEmotesMenuOpen(false)
		inputconnect = UserInputService.InputBegan:Connect(function(input, processed)
			if not processed then
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					ScreenGui.Enabled = false
				end
			end
		end)
	else
		inputconnect:Disconnect()
	end
end)

GuiService.EmotesMenuOpenChanged:Connect(function(isopen)
	if isopen then
		ScreenGui.Enabled = false
	end
end)

GuiService.MenuOpened:Connect(function()
	ScreenGui.Enabled = false
end)

if not game:IsLoaded() then
	game.Loaded:Wait()
end

--thanks inf yield
local SynV3 = syn and DrawingImmediate
if (not is_sirhurt_closure) and (not SynV3) and (syn and syn.protect_gui) then
	syn.protect_gui(ScreenGui)
	ScreenGui.Parent = CoreGui
elseif get_hidden_gui or gethui then
	local hiddenUI = get_hidden_gui or gethui
	ScreenGui.Parent = hiddenUI()
else
	ScreenGui.Parent = CoreGui
end

local function SendNotification(title, text)
	if syn and syn.toast_notification then
		syn.toast_notification({
			Type = ToastType.Error,
			Title = title,
			Content = text
		})
	else
		StarterGui:SetCore("SendNotification", {
			Title = title,
			Text = text
		})
	end
end

local LocalPlayer = Players.LocalPlayer

local function PlayEmote(name: string, id: IntValue)
	ScreenGui.Enabled = false
	SearchBar.Text = ""
	local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	local Description = Humanoid and Humanoid:FindFirstChildOfClass("HumanoidDescription")
	if not Description then
		return
	end
	if LocalPlayer.Character.Humanoid.RigType ~= Enum.HumanoidRigType.R6 then
		local succ, err = pcall(function()
			Humanoid:PlayEmoteAndGetAnimTrackById(id)
		end)
		if not succ then
			Description:AddEmote(name, id)
			Humanoid:PlayEmoteAndGetAnimTrackById(id)
		end
	else
		SendNotification(
			"r6? lol",
			"you gotta be r15 dude"
		)
	end
end

local function WaitForChildOfClass(parent, class)
	local child = parent:FindFirstChildOfClass(class)
	while not child or child.ClassName ~= class do
		child = parent.ChildAdded:Wait()
	end
	return child
end

local Cursor = ""
while true do
	local function Request()
		local success, Response = pcall(function()
			return game:HttpGetAsync("https://catalog.roblox.com/v1/search/items/details?Category=12&Subcategory=39&SortType=1&SortAggregation=&limit=30&IncludeNotForSale=true&cursor=".. Cursor)
		end)
		if not success then
			task.wait(10)
			return Request()
		end
		return Response
	end
	local Response = Request()
	local Body = HttpService:JSONDecode(Response)
	for i,v in pairs(Body.data) do
		AddEmote(v.name, v.id, v.price)
	end
	if Body.nextPageCursor ~= nil then
		Cursor = Body.nextPageCursor
	else
		break
	end
end

--unreleased emotes
AddEmote("Arm Wave", 5915773155)
AddEmote("Head Banging", 5915779725)
AddEmote("Face Calisthenics", 9830731012)

--wait for emotes to finish loading

local function EmotesLoaded()
	for i, loaded in pairs(LoadedEmotes) do
		if not loaded then
			return false
		end
	end
	return true
end
while not EmotesLoaded() do
	task.wait()
end
Loading:Destroy()

--sorting options setup
table.sort(Emotes, function(a, b)
	return a.lastupdated > b.lastupdated
end)
for i,v in pairs(Emotes) do
	v.sort.recentfirst = i
end

table.sort(Emotes, function(a, b)
	return a.lastupdated < b.lastupdated
end)
for i,v in pairs(Emotes) do
	v.sort.recentlast = i
end

table.sort(Emotes, function(a, b)
	return a.name:lower() < b.name:lower()
end)
for i,v in pairs(Emotes) do
	v.sort.alphabeticfirst = i
end

table.sort(Emotes, function(a, b)
	return a.name:lower() > b.name:lower()
end)
for i,v in pairs(Emotes) do
	v.sort.alphabeticlast = i
end

table.sort(Emotes, function(a, b)
	return a.price < b.price
end)
for i,v in pairs(Emotes) do
	v.sort.lowestprice = i
end

table.sort(Emotes, function(a, b)
	return a.price > b.price
end)
for i,v in pairs(Emotes) do
	v.sort.highestprice = i
end

if isfile("FavoritedEmotes.txt") then
	if not pcall(function()
		FavoritedEmotes = HttpService:JSONDecode(readfile("FavoritedEmotes.txt"))
	end) then
		FavoritedEmotes = {}
	end
else
	writefile("FavoritedEmotes.txt", HttpService:JSONEncode(FavoritedEmotes))
end

local UpdatedFavorites = {}
for i,name in pairs(FavoritedEmotes) do
	if typeof(name) == "string" then
		for i,emote in pairs(Emotes) do
			if emote.name == name then
				table.insert(UpdatedFavorites, emote.id)
				break
			end
		end
	end
end
if #UpdatedFavorites ~= 0 then
	FavoritedEmotes = UpdatedFavorites
	writefile("FavoritedEmotes.txt", HttpService:JSONEncode(FavoritedEmotes))
end

local function CharacterAdded(Character)
	for i,v in pairs(Frame:GetChildren()) do
		if not v:IsA("UIGridLayout") then
			v:Destroy()
		end
	end
	local Humanoid = WaitForChildOfClass(Character, "Humanoid")
	local Description = Humanoid:WaitForChild("HumanoidDescription", 5) or Instance.new("HumanoidDescription", Humanoid)
	local random = Instance.new("TextButton")
	local Ratio = Instance.new("UIAspectRatioConstraint")
	Ratio.AspectType = Enum.AspectType.ScaleWithParentSize
	Ratio.Parent = random
	random.LayoutOrder = 0
	random.TextColor3 = Color3.new(1, 1, 1)
	random.BorderSizePixel = 0
	random.BackgroundTransparency = 0.5
	random.BackgroundColor3 = Color3.new(0, 0, 0)
	random.TextScaled = true
	random.Text = "Random"
	random:SetAttribute("name", "")
	Corner:Clone().Parent = random
	random.MouseButton1Click:Connect(function()
		local randomemote = Emotes[math.random(1, #Emotes)]
		PlayEmote(randomemote.name, randomemote.id)
	end)
	random.MouseEnter:Connect(function()
		EmoteName.Text = "Random"
	end)
	random.Parent = Frame
	for i,Emote in pairs(Emotes) do
		Description:AddEmote(Emote.name, Emote.id)
		local EmoteButton = Instance.new("ImageButton")
		local IsFavorited = table.find(FavoritedEmotes, Emote.id)
		EmoteButton.LayoutOrder = Emote.sort[CurrentSort] + ((IsFavorited and 0) or #Emotes)
		EmoteButton.Name = Emote.id
		EmoteButton:SetAttribute("name", Emote.name)
		Corner:Clone().Parent = EmoteButton
		EmoteButton.Image = Emote.icon
		EmoteButton.BackgroundTransparency = 0.5
		EmoteButton.BackgroundColor3 = Color3.new(0, 0, 0)
		EmoteButton.BorderSizePixel = 0
		Ratio:Clone().Parent = EmoteButton
		local EmoteNumber = Instance.new("TextLabel")
		EmoteNumber.Name = "number"
		EmoteNumber.TextScaled = true
		EmoteNumber.BackgroundTransparency = 1
		EmoteNumber.TextColor3 = Color3.new(1, 1, 1)
		EmoteNumber.BorderSizePixel = 0
		EmoteNumber.AnchorPoint = Vector2.new(0.5, 0.5)
		EmoteNumber.Size = UDim2.new(0.2, 0, 0.2, 0)
		EmoteNumber.Position = UDim2.new(0.1, 0, 0.9, 0)
		EmoteNumber.Text = Emote.sort[CurrentSort]
		EmoteNumber.TextXAlignment = Enum.TextXAlignment.Center
		EmoteNumber.TextYAlignment = Enum.TextYAlignment.Center
		local UIStroke = Instance.new("UIStroke")
		UIStroke.Transparency = 0.5
		UIStroke.Parent = EmoteNumber
		EmoteNumber.Parent = EmoteButton
		EmoteButton.Parent = Frame
		EmoteButton.MouseButton1Click:Connect(function()
			PlayEmote(Emote.name, Emote.id)
		end)
		EmoteButton.MouseEnter:Connect(function()
			EmoteName.Text = Emote.name
		end)
		local Favorite = Instance.new("ImageButton")
		Favorite.Name = "favorite"
		if table.find(FavoritedEmotes, Emote.id) then
			Favorite.Image = FavoriteOn
		else
			Favorite.Image = FavoriteOff
		end
		Favorite.AnchorPoint = Vector2.new(0.5, 0.5)
		Favorite.Size = UDim2.new(0.2, 0, 0.2, 0)
		Favorite.Position = UDim2.new(0.9, 0, 0.9, 0)
		Favorite.BorderSizePixel = 0
		Favorite.BackgroundTransparency = 1
		Favorite.Parent = EmoteButton
		Favorite.MouseButton1Click:Connect(function()
			local index = table.find(FavoritedEmotes, Emote.id)
			if index then
				table.remove(FavoritedEmotes, index)
				Favorite.Image = FavoriteOff
				EmoteButton.LayoutOrder = Emote.sort[CurrentSort] + #Emotes
			else
				table.insert(FavoritedEmotes, Emote.id)
				Favorite.Image = FavoriteOn
				EmoteButton.LayoutOrder = Emote.sort[CurrentSort]
			end
			writefile("FavoritedEmotes.txt", HttpService:JSONEncode(FavoritedEmotes))
		end)
	end
	for i=1,9 do
		local EmoteButton = Instance.new("Frame")
		EmoteButton.LayoutOrder = 2147483647
		EmoteButton.Name = "filler"
		EmoteButton.BackgroundTransparency = 1
		EmoteButton.BorderSizePixel = 0
		Ratio:Clone().Parent = EmoteButton
		EmoteButton.Visible = true
		EmoteButton.Parent = Frame
		EmoteButton.MouseEnter:Connect(function()
			EmoteName.Text = "Select an Emote"
		end)
	end
end

if LocalPlayer.Character then
	CharacterAdded(LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(CharacterAdded)

    end,
 })




local Section = ESPTab:CreateSection("🌌 Effects")


 local Toggle = ESPTab:CreateToggle({
    Name = "2022 Materials",
    CurrentValue = false,
    Flag = "Toggle1", 
    Callback = function(Value)
        local MaterialService = game:GetService("MaterialService")
        
        if Value then
            MaterialService.Use2022Materials = true -- Enable the 2022 materials
            Rayfield:Notify({
                Title = "2022 Materials Activated",
                Content = "The 2022 Materials are now active.",
                Duration = 6.5,
                Image = 4483362458,
                Actions = { 
                    Ignore = {
                        Name = "Okay!",
                        Callback = function()
                            print("2022 Materials are active!")
                        end
                    }
                },
            })
        else
            MaterialService.Use2022Materials = false -- Disable the 2022 materials
            Rayfield:Notify({
                Title = "2022 Materials Deactivated",
                Content = "The 2022 Materials are now inactive.",
                Duration = 6.5,
                Image = 4483362458,
                Actions = { 
                    Ignore = {
                        Name = "Okay!",
                        Callback = function()
                            print("2022 Materials are deactivated!")
                        end
                    }
                },
            })
        end
    end,
 })
 
 
 


 local FarmTab = mm2Window:CreateTab("🤑 AutoFarms", nil) -- Title, Image

-- Get references to services
local Players = game:GetService("Players")
local Client = Players.LocalPlayer
local RootPart = Client.Character and Client.Character:FindFirstChild("HumanoidRootPart")

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Initialize global variables
getgenv().Autofarm = false
getgenv().AutofarmSpeed = 2.5
getgenv().CoinPickupDelay = 1.8

local function getClosestCoin()
     local shortestDistance = math.huge
     local closestCoin = nil
     local CoinContainer = workspace:FindFirstChild("CoinContainer", true)
     
     if CoinContainer then
         for _, coin in ipairs(CoinContainer:GetChildren()) do
             if coin.Name == "Coin_Server" then
                 local distance = (coin.Position - RootPart.Position).Magnitude
                 
                 if distance < shortestDistance then
                     shortestDistance = distance
                     closestCoin = coin
                 end
             end
         end
     end
     
     return closestCoin
end

-- Moving function
local function moveToCoin(coin)
    local TweenInformation = TweenInfo.new(
        getgenv().AutofarmSpeed, -- Time
        Enum.EasingStyle.Linear, -- Easing style of the Tween
        Enum.EasingDirection.Out, -- Easing direction of the Tween
        0, -- Number of times the tween will repeat
        false, -- Should the tween repeat?
        0  -- Delay time
    )
    
    local Goals = {
        CFrame = CFrame.new(coin.Position - Vector3.new(0, 2.5, 0)) * CFrame.Angles(0, 0, math.rad(180)) 
    }

    local Tween = TweenService:Create(RootPart, TweenInformation, Goals)
    Tween:Play()

    return Tween
end

local function startAutofarm()
    RootPart = Client.Character and Client.Character:FindFirstChild("HumanoidRootPart")
    while getgenv().Autofarm do
        task.wait()
        local CoinContainer = workspace:FindFirstChild("CoinContainer", true)
        
        if CoinContainer and Client.PlayerGui.MainGUI.Game.CashBag.Visible == true then
            
            for _, coin in pairs(CoinContainer:GetChildren()) do
                if coin.Name == "Coin_Server" then
                    getgenv().CurrentCoin = coin
                    local Tween = moveToCoin(coin)

                    repeat
                        RunService.Stepped:Wait()
                    until not coin:IsDescendantOf(workspace) or coin.Name ~= "Coin_Server" or not getgenv().Autofarm or not Tween.PlaybackState == Enum.PlaybackState.Playing
                    
                    task.wait(getgenv().CoinPickupDelay)
                end
            end

        else
            task.wait(1.5)
        end
    end
end


local FarmingSection = FarmTab:CreateSection("💸 Farming")

-- Toggle in Farming Section
local Toggle = FarmTab:CreateToggle({
    Name = "Autofarm Coins",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        getgenv().Autofarm = Value
        if Value then
            startAutofarm()
        end
    end,
})

local SettingsSection = FarmTab:CreateSection("⚙️ Settings")

-- Create a slider for setting the delay time in Settings Section
local coinPickupDelaySlider = FarmTab:CreateSlider({
    Name = "Coin Pickup Delay",
    Range = {0, 5}, -- The user can set a delay from 0 to 5 seconds
    Increment = 0.5,
    Suffix = "Seconds",
    CurrentValue = 1.8,
    Flag = "CoinPickupDelay",
    Callback = function(Value)
        -- Update the delay time in the autofarm function
        getgenv().CoinPickupDelay = Value
    end,
})

-- Create a slider for setting the autofarm speed in Settings Section
local autofarmSpeedSlider = FarmTab:CreateSlider({
    Name = "Autofarm Speed",
    Range = {1, 10}, -- Increase the maximum value to 10
    Increment = 0.5,
    Suffix = "Speed",
    CurrentValue = 2.5,
    Flag = "AutofarmSpeed",
    Callback = function(Value)
        -- Update the speed in the autofarm function
        getgenv().AutofarmSpeed = Value
    end,
})

 

local MiscTab = mm2Window:CreateTab("⚙️ Misc", nil) -- Title, Image

local Section = MiscTab:CreateSection("🌐 World")

--<>----<>----<>----<>----<>----<>----<>--
--<>----<>----<>----<>----<>----<>----<>--

function XrayOn(obj)
    for _,v in pairs(obj:GetChildren()) do
        if (v:IsA("BasePart")) and not v.Parent:FindFirstChild("Humanoid") then
            v.LocalTransparencyModifier = 0.75;
        end;
        XrayOn(v);
    end;
end;

function XrayOff(obj)
    for _,v in pairs(obj:GetChildren()) do
        if (v:IsA("BasePart")) and not v.Parent:FindFirstChild("Humanoid") then
            v.LocalTransparencyModifier = 0;
        end ;
        XrayOff(v);
    end;
end;

local FP = MiscTab:CreateLabel("")
spawn(function()
    while game:GetService("RunService").RenderStepped:wait() do
        FP:Set("FPS : "..tostring(game:GetService("Stats").Workspace.FPS:GetValueString()))
    end
end)

local Time = MiscTab:CreateLabel("")
spawn(function()
    while task.wait() do
        local Data = os.date("*t")
        Time:Set("IRL Time : "..Data.hour..":"..Data.min..":"..Data.sec)
    end
end)


local Toggle = MiscTab:CreateToggle({
    Name = "Xray",
    CurrentValue = false,
    Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(state)
        getgenv().Xray = state;
        if getgenv().Xray then
            XrayOn(Workspace);
        else
            XrayOff(Workspace);
        end;
    end,
 })

 local Button = MiscTab:CreateButton({
    Name = "Teleport to Lobby",
    Callback = function()
        pcall(function()
            RootPart.CFrame = lobbyPosition
            Rayfield:Notify({
                Title = "Teleportation",
                Content = "Teleported successfully to Lobby",
                Duration = 3,
            })
        end)
    end,
})

local Button = MiscTab:CreateButton({
    Name = "Teleport to VotingArea",
    Callback = function()
        pcall(function()
            RootPart.CFrame = votePosition
            Rayfield:Notify({
                Title = "Teleportation",
                Content = "Teleported successfully to VotingArea",
                Duration = 3,
            })
        end)
    end,
})


local Button1 = MiscTab:CreateButton({
    Name = "Teleport to Murder",
    Callback = function()
        local players = game:GetService("Players"):GetPlayers()
        for _, player in ipairs(players) do
            if player.Character and (player.Backpack:FindFirstChild("Knife") or player.Character:FindFirstChild("Knife")) then
                print("Found a player with a Knife: ", player.Name)  -- Debug print
                local position = player.Character.HumanoidRootPart.Position
                print("Teleporting to position: ", position)  -- Debug print
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(position)
                return  -- If teleportation is successful, no need to continue the loop
            end
        end
        Rayfield:Notify({
            Title = "Teleport Unsuccessful",
            Content = "No player with a Knife was found.",
            Duration = 6.5,
            Image = 4483362458,
            Actions = {
                Ignore = {
                    Name = "Okay!",
                    Callback = function()
                        print("The user acknowledged the unsuccessful teleportation.")
                    end
                },
            },
        })
    end,
})

local Button2 = MiscTab:CreateButton({
    Name = "Teleport to Sheriff",
    Callback = function()
        local players = game:GetService("Players"):GetPlayers()
        for _, player in ipairs(players) do
            if player.Character and (player.Backpack:FindFirstChild("Gun") or player.Character:FindFirstChild("Gun")) then
                print("Found a player with a Gun: ", player.Name)  -- Debug print
                local position = player.Character.HumanoidRootPart.Position
                print("Teleporting to position: ", position)  -- Debug print
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(position)
                return  -- If teleportation is successful, no need to continue the loop
            end
        end
        Rayfield:Notify({
            Title = "Teleport Unsuccessful",
            Content = "No player with a Gun was found.",
            Duration = 6.5,
            Image = 4483362458,
            Actions = {
                Ignore = {
                    Name = "Okay!",
                    Callback = function()
                        print("The user acknowledged the unsuccessful teleportation.")
                    end
                },
            },
        })
    end,
})



 local players = game:GetService("Players"):GetPlayers()

 local playerNames = {}
 
 for i, player in ipairs(players) do
     table.insert(playerNames, player.Name)
 end
 
 local dropdown = MiscTab:CreateDropdown({
     Name = "Player Teleport",
     Options = playerNames,
     CurrentOption = {playerNames[1]},
     MultipleOptions = false,
     Flag = "playerTeleport",
     Callback = function(Option)
         local selectedPlayer = game:GetService("Players"):FindFirstChild(Option[1])
         if selectedPlayer and selectedPlayer.Character then
             local position = selectedPlayer.Character:WaitForChild("HumanoidRootPart").Position
             game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(position)
         end
     end,
 })

 local Section = MiscTab:CreateSection("🔫 SherrifSection")

 local GunLabel = MiscTab:CreateLabel("Gun Not Dropped")
coroutine.wrap(function()
    local gunDropped = false
    while wait(0.1) do
        local gunExists = Workspace:FindFirstChild("GunDrop")
        
        if gunExists then
            GunLabel:Set("Gun Dropped")
            
            -- Only send notification if the gun has been dropped since last check
            if not gunDropped then
                gunDropped = true
                Rayfield:Notify({
                    Title = "Gun Status",
                    Content = "Gun Dropped",
                    Duration = 6.5,
                    Image = 5578470911,
                    Actions = {
                        Ignore = {
                            Name = "Okay!",
                            Callback = function()
                                print("The user tapped Okay!")
                            end
                        },
                    },
                })
            end
        else
            GunLabel:Set("Gun Not Dropped")
            gunDropped = false
        end
    end
end)()


local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Player = game:GetService("Players").LocalPlayer

local Keybind = MiscTab:CreateKeybind({
    Name = "Get gun",
    CurrentKeybind = "Y",
    HoldToInteract = false,
    Flag = "Keybind1", 
    Callback = function(Keybind)
        local gundrop = Workspace:FindFirstChild("GunDrop")
        if gundrop then
            local player = game.Players.LocalPlayer
            local RootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if RootPart then
                local lastCFrame = RootPart.CFrame
                
                pcall(function()
                    repeat
                        RootPart.CFrame = gundrop.CFrame
                        game:GetService("RunService").Stepped:Wait()
                    until not gundrop:IsDescendantOf(Workspace)

                    -- Re-obtain RootPart here, as it may have changed or been destroyed
                    RootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                    if RootPart then
                        RootPart.CFrame = lastCFrame
                    else
                        print("HumanoidRootPart does not exist or has been destroyed.")
                    end
                end)
            else
                print("HumanoidRootPart does not exist. Cannot perform the teleportation.")
            end
        end
    end
})


local function autoGetGun()
    while getgenv().AutoGetGun do
        task.wait()
        local gundrop = Workspace:FindFirstChild("GunDrop")
        if gundrop then
            local RootPart = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
            if RootPart then
                pcall(function()
                    -- Check if GunDrop still exists and the toggle is still on
                    while gundrop:IsDescendantOf(Workspace) and getgenv().AutoGetGun do
                        RootPart.CFrame = gundrop.CFrame
                        RunService.Stepped:Wait()
                    end
                end)
            end
        end
    end
end

local ToggleAutoGetGun = MiscTab:CreateToggle({
    Name = "Auto GetGun",
    CurrentValue = false,
    Flag = "ToggleAutoGetGun",
    Callback = function(Value)
        getgenv().AutoGetGun = Value
        if Value then
            autoGetGun()
        end
    end,
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local Keybind = MiscTab:CreateKeybind({
   Name = "Equip Gun and TP to Knife holder",
   CurrentKeybind = "C",
   HoldToInteract = false,
   Flag = "Keybind1",
   Callback = function(Keybind)
      -- Check if LocalPlayer's character exists
      if LocalPlayer.Character then
         local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
         local HumanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

         -- Check if humanoid and HumanoidRootPart exists
         if humanoid and HumanoidRootPart then
            -- Equip gun
            local Gun = LocalPlayer.Backpack:FindFirstChild("Gun")

            -- Check if Gun exists
            if Gun then
               humanoid:EquipTool(Gun)

               -- Find player with knife
               for _, Player in pairs(Players:GetPlayers()) do
                  if Player ~= LocalPlayer and Player.Character then
                     local Knife = Player.Backpack:FindFirstChild("Knife") or Player.Character:FindFirstChild("Knife")

                     -- Check if Knife exists
                     if Knife then
                        -- Teleport to knife holder
                        local PlayerHumanoidRootPart = Player.Character:FindFirstChild("HumanoidRootPart")

                        -- Check if Player's HumanoidRootPart exists
                        if PlayerHumanoidRootPart then
                           HumanoidRootPart.CFrame = PlayerHumanoidRootPart.CFrame * CFrame.new(0, 0, -5) -- Teleport behind the player

                           -- Shoot gun
                           local ShootGun = Gun:FindFirstChild("ShootGun") -- Assuming ShootGun is a RemoteFunction
                           if ShootGun then
                              ShootGun:InvokeServer(Mouse.Hit.p) -- Shoots at the point your mouse is pointing at
                           else
                              print("ShootGun does not exist in", Gun.Name)
                           end
                        else
                           print("Player's HumanoidRootPart does not exist")
                        end
                        break
                     end
                  end
               end
            else
               print("Gun does not exist in Backpack")
            end
         else
            print("Humanoid or HumanoidRootPart does not exist in LocalPlayer's character")
         end
      else
         print("LocalPlayer's character does not exist")
      end
   end,
})




local Toggle = MiscTab:CreateToggle({
    Name = "Silent aim",
    CurrentValue = false,
    Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(state)
        getgenv().SheriffAim = state;
        print(getgenv().SheriffAim);
    end,
 })

 local Slider = MiscTab:CreateSlider({
    Name = "Accuracy",
    Range = {0, 200},
    Increment = 1,
    Suffix = "%",
    CurrentValue = 25,
    Flag = "Slider1",
    Callback = function(val)
        getgenv().GunAccuracy = tonumber(val) or 25;
    end,
})


 local Section = MiscTab:CreateSection("🔪 MurdererSection")

 local Toggle = MiscTab:CreateToggle({
    Name = "Kill aura",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(state)
        getgenv().KnifeAura = state;
    end,
})

local Slider = MiscTab:CreateSlider({
    Name = "Knife Range",
    Range = {5, 100},
    Increment = 1,
    Suffix = " studs",
    CurrentValue = 25,
    Flag = "Slider1",
    Callback = function(val)
        getgenv().KnifeRange = tonumber(val) or 25;
    end,
})

local lastAttack = tick();
local Client = Players.LocalPlayer

local rateLimit = 1.5 -- introducing a rate limit

RunService.Heartbeat:Connect(function()
    if (tick() - lastAttack) < rateLimit or not getgenv().KnifeAura then
        return;
    end;
    
    local Knife = Client.Backpack:FindFirstChild("Knife") or Client.Character:FindFirstChild("Knife");
    if Knife and Knife:IsA("Tool") then
        for i, v in ipairs(Players:GetPlayers()) do
            if v ~= Client and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and not table.find(getgenv().Whitelisted, v.Name) then
                local Distance = (v.Character.HumanoidRootPart.Position - Client.Character.HumanoidRootPart.Position).Magnitude;
                if (Distance <= getgenv().KnifeRange) then
                    game:GetService("VirtualUser"):CaptureController()
                    game:GetService("VirtualUser"):ClickButton1(Vector2.new());
                    firetouchinterest(v.Character.HumanoidRootPart, Knife.Handle, 1);
                    wait(rateLimit) -- waiting for rate limit after attack
                    firetouchinterest(v.Character.HumanoidRootPart, Knife.Handle, 0);
                    lastAttack = tick();
                end;
            end;
        end;
    end;
end);



local GameOver = nil;
local Blocked = nil;
getgenv().Whitelisted = getgenv().Whitelisted or {}

local Keybind = MiscTab:CreateKeybind({
    Name = "Kill All",
    CurrentKeybind = "K",
    HoldToInteract = false,
    Flag = "Keybind1",
    Callback = function(Keybind)
        local Knife = Client.Backpack:FindFirstChild("Knife") or Client.Character:FindFirstChild("Knife");
        if Knife then
            Humanoid:EquipTool(Knife);
            for i, v in ipairs(Players:GetPlayers()) do
                if v ~= Client and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and not table.find(getgenv().Whitelisted, v.Name) then
                    VirtualUser:ClickButton1(Vector2.new());
                    firetouchinterest(v.Character.HumanoidRootPart, Knife.Handle, 1);
                    firetouchinterest(v.Character.HumanoidRootPart, Knife.Handle, 0);
                    lastAttack = tick();
                end;
            end;
        end;
    end,
})

local Button = MiscTab:CreateButton({
    Name = "Print whitelisted",
    Callback = function()
        print("----------WHITELISTED----------");
        for _,v in pairs(getgenv().Whitelisted) do
            print(v);
        end;
        print("-------------------------------");
    end,
})

coroutine.wrap(function()
    repeat wait()
        pcall(function()
            Murderer = GetMurderer();
            Sheriff = GetSheriff();
        end);
    until Murderer and Sheriff;
end)();

--<>----<>----<>----<>----<>----<>----<>--
--<>----<>----<>----<>----<>----<>----<>--
ReplicatedStorage.UpdatePlayerData.OnClientEvent:Connect(function()
    CanGrab = false;
end);

local GunHook
GunHook = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if not checkcaller() then
        if typeof(self) == "Instance" and self.Name == "ShootGun" and method == "InvokeServer" then
            if getgenv().SheriffAim and getgenv().GunAccuracy then
                if Murderer then
                    local Root = Players[tostring(Murderer)].Character.PrimaryPart
                    if Root then
                        local Veloc = Root.AssemblyLinearVelocity
                        -- This part calculates the prediction
                        local Pos = Root.Position + (Veloc * getgenv().GunAccuracy / 200)
                        -- Updating the target position with the prediction
                        args[2] = Pos
                    end
                end
            end
        end
    end
    
    return GunHook(self, unpack(args))
end)




local __namecall
__namecall = hookmetamethod(game, "__namecall", function(self, ...)
	local method = getnamecallmethod();
	local args = { ... };
	if not checkcaller() then
        if tostring(method) == "InvokeServer" and tostring(self) == "GetChance" then
            wait(13);
            Murderer = GetMurderer();
            Sheriff = GetSheriff();
            CanGrab = true;
        end;
	end;
	return __namecall(self, unpack(args));
end);


local Section = MiscTab:CreateSection("😇 InnocentSection")

local Button = MiscTab:CreateButton({
    Name = "Notify Roles",
    Callback = function()
         local knifeUserFound = false
         local gunUserFound = false
         for i, player in ipairs(game.Players:GetPlayers()) do
             if player.Backpack:FindFirstChild("Knife") then
                 knifeUserFound = true
                 Rayfield:Notify({
                     Title = "Notification",
                     Content = player.Name .. " has a Knife!",
                     Duration = 6.5,
                     Image = 5578470911,
                     Actions = {
                         Ignore = {
                             Name = "Okay!",
                             Callback = function()
                                 print(player.Name .. " has a Knife!")
                             end
                         },
                     },
                 })
             end
             if player.Backpack:FindFirstChild("Gun") then
                 gunUserFound = true
                 Rayfield:Notify({
                     Title = "Notification",
                     Content = player.Name .. " has a Gun!",
                     Duration = 6.5,
                     Image = 5578470911,
                     Actions = {
                         Ignore = {
                             Name = "Okay!",
                             Callback = function()
                                 print(player.Name .. " has a Gun!")
                             end
                         },
                     },
                 })
             end
         end
         if not knifeUserFound and not gunUserFound then
             Rayfield:Notify({
                 Title = "Notification",
                 Content = "The game hasn't started. Please wait.",
                 Duration = 6.5,
                 Image = 5578470911,
                 Actions = {
                     Ignore = {
                         Name = "Okay!",
                         Callback = function()
                             print("The game hasn't started. Please wait.")
                         end
                     },
                 },
             })
         end
    end,
 })
 

getgenv().SecureMode = true
Rayfield:LoadConfiguration()


end
