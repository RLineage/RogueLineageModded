if (not game:IsLoaded()) then
	repeat task.wait(.1) until game:IsLoaded()
end

local connections:{RBXScriptConnection} = {}

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart")

local playerGui = player.PlayerGui
playerGui:AddTag("GamingGaming")

for _, v in pairs(playerGui:GetDescendants()) do
	if (v.Name == "GodObserve") then
		v:Destroy()
	end
	if (v:HasTag("GamingGaming")) then
		v:Destroy()
	end
end

local list = nil
local gui = nil

local exploits = {
	TrinketEsp = false,
	NPCEsp = false,
	PlayerEsp = false,
	NoFall = false,
	NoFog = false,
	Speedhack = false,
	InfJump = false,
	--GodObserve = true,
	Configurations = false,
}

local configurations = {
	TrinketEsp = {
		KnownMeshList = {
			["rbxassetid://5196551436"] = "Amulet",
			["rbxassetid://5196577540"] = "Old Amulet",
			["rbxassetid://5196776695"] = "Ring",
			["rbxassetid://5196782997"] = "Old Ring",
			["rbxassetid://5204003946"] = "Goblet",
		},
		ColorCoding = {
			Common = {
				Show = true,
				Color = Color3.fromRGB(255, 255, 255),
				Range = 350
			},
			Rare = {
				Show = true,
				Color = Color3.fromRGB(0, 255, 247),
				Range = 350
			},
			Gem = {
				Show = true,
				Color = Color3.fromRGB(0, 132, 255),
				Range = 350
			},
			Event = {
				Show = true,
				Color = Color3.fromRGB(130, 255, 108),
				Range = 450
			},
			SemiArtifact = {
				Show = true,
				Color = Color3.fromRGB(255, 140, 0),
				Range = 10000
			},
			Artifact = {
				Show = true,
				Color = Color3.fromRGB(255, 0, 0),
				Range = 10000
			},
			Unknown = {
				Show = true,
				Color = Color3.fromRGB(225, 0, 255),
				Range = 10000
			},
			Specifics = {
				["Rift Gem"] = {
					Show = true,
					Color = Color3.fromRGB(255, 0, 255),
					Range = 10000
				},
			},
		},
		TrinketList = {
			["Old Amulet"] = "Common",
			["Amulet"] = "Common",
			["Old Ring"] = "Common",
			["Ring"] = "Common",
			["Goblet"] = "Common",
			["Idol of the Forgotten"] = "Common",

			["Ruby"] = "Gem",
			["Emerald"] = "Gem",
			["Opal"] = "Gem",
			["Sapphire"] = "Gem",
			["Diamond"] = "Gem",

			["???"] = "Rare",
			["Scroll"] = "Rare",
			["Ice Essence"] = "Rare",

			["Idol of War"] = "Event",
			["Candy"] = "Event",
			["Ornament"] = "Event",

			["Phoenix Down"] = "SemiArtifact",
			["Phoenix Flower"] = "SemiArtifact",

			["Howler Friend"] = "Artifact",
			["Azael Horn"] = "Artifact",
			["Spider Cloak"] = "Artifact",
			["Philosopher's Stone"] = "Artifact",
			["Nightstone"] = "Artifact",
			["Scroom Key"] = "Artifact",
			["Mysterious Artifact"] = "Artifact",
			["Rift Gem"] = "Artifact",
			["White Kings Amulet"] = "Artifact",
			["Lannis' Amulet"] = "Artifact",
			["Fairfrozen"] = "Artifact",
			["Nature Essence"] = "Artifact",
			["Harpy Friend"] = "Artifact",
			["Phoenix Feather"] = "Artifact",
			["Azael Horns"] = "Artifact",
			["Solan Key"] = "Artifact",

			["Unknown"] = "Unknown"
		},
		MaxRange = 10000,
		LastUpdated = tick(),
		Table = {},
	},
	NPCEsp = {
		ColorCoding = {
			Common = {
				Show = true,
				Color = Color3.fromRGB(143, 255, 126),
				Range = 350,
			},
			Trainer = {
				Show = true,
				Color = Color3.fromRGB(255, 41, 41),
				Range = 750,
			},
			SemiTrainer = {
				Show = true,
				Color = Color3.fromRGB(255, 150, 150),
				Range = 750,
			},
			Weapon = {
				Show = false,
				Color = Color3.fromRGB(255, 255, 255),
				Range = 500,
			},
			Outfit = {
				Show = false,
				Color = Color3.fromRGB(255, 255, 255),
				Range = 500,
			},
			Item = {
				Show = true,
				Color = Color3.fromRGB(255, 255, 255),
				Range = 500,
			},
			Merchant = {
				Show = true,
				Color = Color3.fromRGB(255, 150, 50),
				Range = 500,
			},
			Doctor = {
				Show = true,
				Color = Color3.fromRGB(50, 255, 50),
				Range = 500,
			},
			Specifics = {
				Tai = {
					Show = true,
					Color = Color3.fromRGB(0, 251, 255),
					Range = 10000,
				},
				Tally = {
					Show = true,
					Color = Color3.fromRGB(8, 0, 255),
					Range = 10000,
				},
				Fallion = {
					Show = true,
					Color = Color3.fromRGB(255, 247, 0),
					Range = 10000,
				},
				Collector = {
					Show = true,
					Color = Color3.fromRGB(149, 0, 255),
					Range = 10000,
				},
			},
		},
		NPCList = {
			["Mother of Whisperers"] = "Trainer",
			["Rorsach"] = "Trainer",
			["Drake"] = "Trainer",
			["Gurn"] = "Trainer",

			["Doctor"] = "Doctor",
			["Therapist"] = "Doctor",
			["Dorgan"] = "Doctor",
			["Dorgath"] = "Doctor",

			["Alisone"] = "SemiTrainer",
			["MonsterOfficerInsight"] = "SemiTrainer",

			["Merchant"] = "Merchant",
			["Pawnbroker"] = "Merchant",
			["Banker"] = "Merchant",

			["Caestus"] = "Weapon",
			["BronzeSword"] = "Weapon",
			["BronzeDagger"] = "Weapon",
			["BronzeSpear"] = "Weapon",
			["SteelSword"] = "Weapon",
			["SteelDagger"] = "Weapon",
			["SteelSpear"] = "Weapon",
			["MythrilSword"] = "Weapon",
			["MythrilDagger"] = "Weapon",
			["MythrilSpear"] = "Weapon",
			["Mythril Rapier"] = "Weapon",
			["Greatsword"] = "Weapon",
			["TantoDagger"] = "Weapon",
			["WakizashiDagger"] = "Weapon",
			["WitchSilverSword"] = "Weapon",
			["Katana"] = "Weapon",

			["LordOutfit"] = "Outfit",
			["BrawlerOutfit"] = "Outfit",
			["SamuraiOutfit"] = "Outfit",
			["RogueOutfit"] = "Outfit",
			["AssassinOutfit"] = "Outfit",

			["Pickaxe"] = "Item",
			["Frying Pan"] = "Item",
			["Helmet"] = "Item",
		},
		MaxRange = 10000,
		LastUpdated = tick(),
		Table = {},	
	},
	PlayerEsp = {
		LastUpdated = tick(),
		Table = {},	
	},
	NoFall = {
		CanNoFall = true,
		NoFallLeg = character:FindFirstChild("Right Leg"):Clone()	
	},
	--[[GodObserve = {
		LastUpdated = tick()
	}]]
}

for _, v in pairs(workspace:GetChildren()) do
	if (v.Name == "NofallLeg") or (v:HasTag("GamingGaming")) then
		v:Destroy()
	end
end

local function changegui()
	playerGui.StatGui.Container.CharacterName.Shadow.Text = "LOCKEXPLOITS, THE LEGIT"
	playerGui.StatGui.Container.CharacterName.Text = "LOCKEXPLOITS, THE LEGIT"
end

local fallRemote

local function initialize()
	local s, m = pcall(function()
		fallRemote = character:WaitForChild("CharacterHandler", 1)
			:WaitForChild("Remotes", 1):WaitForChild("ApplyFallDamage", 1)
	end)
	if (not s) then
		warn("No Fall couldn't be initialized!")
		warn(m)
		configurations.NoFall.CanNoFall = false
	end
	
	changegui()
	
	if (connections.LoopWS) then
		connections.LoopWS:Disconnect()
	end

	connections.LoopWS = character:FindFirstChildOfClass("Humanoid"):GetPropertyChangedSignal("WalkSpeed"):Connect(function()
		if (exploits.Speedhack) then
			character:FindFirstChildOfClass("Humanoid").WalkSpeed = 90
		end
	end)
end

connections.CharacterAdded = player.CharacterAdded:Connect(function(char)
	character = char
	root = character:FindFirstChild("HumanoidRootPart")

	initialize()
end)

initialize()

configurations.NoFall.NoFallLeg.Parent = workspace
configurations.NoFall.NoFallLeg.Name = "NofallLeg"
configurations.NoFall.NoFallLeg.CanCollide = false
configurations.NoFall.NoFallLeg.Anchored = false
configurations.NoFall.NoFallLeg.Transparency =1 
configurations.NoFall.NoFallLeg.Size += Vector3.new(1,.4,1)

local weld = Instance.new("Weld", configurations.NoFall.NoFallLeg)
weld.Part0 = root
weld.Part1 = configurations.NoFall.NoFallLeg
weld.C0 = CFrame.new(0, -2, 0)
weld.C1	= CFrame.new(0, 0, 0)

function generateUUID()
	local table1 = { "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z" }
	local table2 = { 0,1,2,3,4,5,6,7,8,9 }
	local table3 = { "!","@","#","$","&" }

	local uuid = ""

	for i=1,15 do
		local rand = math.random(1,2)
		if (rand == 1) then
			uuid = uuid .. table1[math.random(1,#table1)]
		else
			uuid = uuid .. table2[math.random(1,#table2)]
		end
		if (i == 4) or (i == 8) or (i == 12) then
			uuid = uuid .. "-"
		end
		if (i == 15) then
			uuid = uuid .. table3[math.random(1, #table3)]
		end
	end

	return uuid
end

local function createButton(name, text, mouse1click, toggle):TextButton
	if (not list) then error("No List existant.") return end

	local button = Instance.new("TextButton", list)
	button.Name = name
	button.Text = text
	button.AnchorPoint = Vector2.new(0.5, 0)
	button.BackgroundTransparency = 0
	button.BackgroundColor3 = Color3.fromRGB(215, 203, 191)
	button.Size = UDim2.new(0, 50, 0, 50)
	button.TextTransparency = 0
	button.TextStrokeTransparency = 1
	button.TextSize = 13
	button.RichText = true
	button.FontFace = Font.new("rbxasset://fonts/families/Balthazar.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	button.TextWrapped = true
	button.TextColor3 = Color3.fromRGB(47, 43, 30)

	local overlay = Instance.new("ImageLabel", button)
	overlay.Name = "Overlay"
	overlay.Position = UDim2.new(0.5, 0, 0.5, 0)
	overlay.Size = UDim2.new(1, 10, 1, 10)
	overlay.BackgroundTransparency = 1
	overlay.Image = "rbxassetid://3419850962"
	overlay.ImageColor3 = Color3.fromRGB(245, 197, 130)
	overlay.ScaleType = Enum.ScaleType.Slice
	overlay.SliceCenter = Rect.new(13, 13, 13, 13)
	overlay.AnchorPoint = Vector2.new(0.5, 0.5)
	overlay.ZIndex = 1

	if (toggle) then
		button.Active = false

		button.MouseButton1Click:Connect(function()
			button.Active = not button.Active

			mouse1click(button.Active)

			button.BackgroundColor3 = (button.Active) and Color3.fromRGB(159, 255, 142) or Color3.fromRGB(215, 203, 191)
		end)
	else
		button.MouseButton1Click:Connect(mouse1click)
	end

	return button	
end

local areaMarkers = {}

local function createGui()
	if (gui ~= nil) then
		gui:Destroy()

		gui = nil		
	end

	for _,v in pairs(playerGui:GetChildren()) do
		if (v:HasTag("GamingGaming")) then
			v:Destroy()
		end
	end

	local screenGui = Instance.new("ScreenGui", playerGui)
	screenGui.Name = generateUUID().."ScreenGui"
	screenGui.ResetOnSpawn = false

	screenGui:AddTag("GamingGaming")

	local frame = Instance.new("Frame", screenGui)
	frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	frame.BackgroundTransparency = 0.8
	frame.Position = UDim2.new(0.3, 0, 0, 0)
	frame.Size = UDim2.new(0, 250, 0, 250)
	frame.Name = generateUUID().."Frame"

	local uiDragDetector = Instance.new("UIDragDetector", frame)

	local overlay = Instance.new("ImageLabel", frame)
	overlay.Name = "Overlay"
	overlay.Position = UDim2.new(0.5, 0, 0.5, 0)
	overlay.Size = UDim2.new(1, 4, 1, 4)
	overlay.BackgroundTransparency = 1
	overlay.Image = "rbxassetid://2739347995"
	overlay.ImageColor3 = Color3.fromRGB(245, 197, 130)
	overlay.ScaleType = Enum.ScaleType.Slice
	overlay.SliceCenter = Rect.new(5, 5, 5, 5)
	overlay.AnchorPoint = Vector2.new(0.5, 0.5)
	overlay.ZIndex = 0

	local boundFrame = Instance.new("Frame", overlay)
	boundFrame.Name = "BoundFrame"
	boundFrame.Position = UDim2.new(0, 10, 0, 10)
	boundFrame.Size = UDim2.new(1, -20, 1, -20)
	boundFrame.BackgroundTransparency = 1

	local title = Instance.new("TextLabel", boundFrame)
	title.Name = "Title"
	title.Text = "LOCK EXPLOITS"
	title.BackgroundTransparency = 1
	title.Size = UDim2.new(1, 0, .078,  0)
	title.TextTransparency = 0
	title.TextStrokeTransparency = .8
	title.TextSize = 13
	title.RichText = true
	title.FontFace = Font.new("rbxasset://fonts/families/Balthazar.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	title.TextWrapped = false
	title.TextColor3 = Color3.fromRGB(255, 232, 163)

	local buttonsFrame = Instance.new("Frame", boundFrame)
	buttonsFrame.Name = "ButtonsFrame"
	buttonsFrame.Position = UDim2.new(.047,  0, .125, 0)
	buttonsFrame.Size = UDim2.new(.9, 0, .875, 0)
	buttonsFrame.BackgroundTransparency = 1

	list = buttonsFrame

	local uiListLayout = Instance.new("UIListLayout", list)
	uiListLayout.Padding = UDim.new(0.1, 0)
	uiListLayout.FillDirection = Enum.FillDirection.Horizontal
	uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	uiListLayout.Wraps =  true
	uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	uiListLayout.HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween
	uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Top

	gui = screenGui

	local tEsp = createButton(generateUUID(), "Trinket ESP", function()
		exploits.TrinketEsp = not exploits.TrinketEsp

		for _, v in pairs(configurations.TrinketEsp.Table) do
			v.Enabled = exploits.TrinketEsp
		end
	end, true) -- Trinket <font color="rgb(255,50,50">ESP</font>

	local pEsp = createButton(generateUUID(), "Player ESP", function()
		exploits.PlayerEsp = not exploits.PlayerEsp

		for _, v in pairs(configurations.PlayerEsp.Table) do
			v.Enabled = exploits.PlayerEsp
		end
	end, true)

	local npcEsp = createButton(generateUUID(), "NPC Esp", function()
		exploits.NPCEsp = not exploits.NPCEsp

		for _, v in pairs(configurations.NPCEsp.Table) do
			v.Enabled = exploits.NPCEsp
		end
	end, true)

	local nFall = createButton(generateUUID(), "No Fall", function()
		exploits.NoFall = not exploits.NoFall
	end, true)

	local speedhack = createButton(generateUUID(), "Speedhack", function()
		exploits.Speedhack = not exploits.Speedhack
	end, true)

	local infjump = createButton(generateUUID(), "Infinite Jump", function()
		exploits.InfJump = not exploits.InfJump
	end, true)

	local nFog = createButton(generateUUID(), "No Fog", function()
		exploits.NoFog = not exploits.NoFog

		if (#areaMarkers == 0) then
			for _, v in pairs(workspace.AreaMarkers:GetChildren()) do
				table.insert(areaMarkers, v)
			end
		end

		if (exploits.NoFog) then
			for _, v in pairs(areaMarkers) do
				v.Parent = nil
			end

			game.Lighting.FogEnd = 100000000
			game.Lighting.FogStart = 100000000
			game.Lighting.FogColor = Color3.fromRGB(255, 255, 255)
			game.Lighting.Ambient = Color3.fromRGB(255, 255, 255)
			game.Lighting.ColorShift_Top = Color3.fromRGB(255, 255, 255)
			game.Lighting.ColorShift_Bottom = Color3.fromRGB(255, 255, 255)
			game.Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
			game.Lighting.ExposureCompensation = -.5
			game.Lighting.EnvironmentDiffuseScale = 1
			game.Lighting.GlobalShadows = false
			game.Lighting.Brightness = 0
		else
			for _, v in pairs(areaMarkers) do
				v.Parent = workspace.AreaMarkers
			end

			game.Lighting.ExposureCompensation = 0
			game.Lighting.GlobalShadows = true
			game.Lighting.Ambient = Color3.fromRGB(70, 70, 70)
			game.Lighting.ColorShift_Top = Color3.fromRGB(0,0,0)
			game.Lighting.ColorShift_Bottom = Color3.fromRGB(0,0,0)
			game.Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
			game.Lighting.EnvironmentDiffuseScale = 0
		end
	end, true)

	local reset = createButton(generateUUID(), "Knock", function()
		if (fallRemote) then
			fallRemote:FireServer(character:FindFirstChildOfClass("Humanoid").MaxHealth * 5)
		end
	end)

	--[[local configMenu = createExtraGui()
	configMenu.Enabled = false
	
	local configs
	configs = createButton(generateUUID(), "Config.", function()
		exploits.Configurations = not exploits.Configurations
		
		if (exploits.Configurations) then
			configs.BackgroundColor3 = Color3.fromRGB(255, 241, 227)
		else
			configs.BackgroundColor3 = Color3.fromRGB(215, 203, 191)
		end
		
		configMenu.Enabled = exploits.Configurations
	end)

	configs.AutoButtonColor = false]]

	tEsp.LayoutOrder = 1
	pEsp.LayoutOrder = 2
	npcEsp.LayoutOrder = 3
	nFall.LayoutOrder = 4
	nFog.LayoutOrder = 5
	speedhack.LayoutOrder = 6
	infjump.LayoutOrder = 7
	reset.LayoutOrder = 99
	--configs.LayoutOrder = 100

	return screenGui
end

function createExtraGui()
	local screenGui = Instance.new("ScreenGui", playerGui)
	screenGui.Name = "Configurations"
	screenGui.ResetOnSpawn = false

	screenGui:AddTag("GamingGaming")

	local frame = Instance.new("Frame", screenGui)
	frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	frame.BackgroundTransparency = 0.8
	frame.Position = UDim2.new(0.1, 0, 0.1, 0)
	frame.Size = UDim2.new(0, 250, 0, 250)
	frame.Name = generateUUID().."Frame"

	local uiDragDetector = Instance.new("UIDragDetector", frame)

	local overlay = Instance.new("ImageLabel", frame)
	overlay.Name = "Overlay"
	overlay.Position = UDim2.new(0.5, 0, 0.5, 0)
	overlay.Size = UDim2.new(1, 4, 1, 4)
	overlay.BackgroundTransparency = 1
	overlay.Image = "rbxassetid://2739347995"
	overlay.ImageColor3 = Color3.fromRGB(245, 197, 130)
	overlay.ScaleType = Enum.ScaleType.Slice
	overlay.SliceCenter = Rect.new(5, 5, 5, 5)
	overlay.AnchorPoint = Vector2.new(0.5, 0.5)
	overlay.ZIndex = 0

	local boundFrame = Instance.new("Frame", overlay)
	boundFrame.Name = "BoundFrame"
	boundFrame.Position = UDim2.new(0, 10, 0, 10)
	boundFrame.Size = UDim2.new(1, -20, 1, -20)
	boundFrame.BackgroundTransparency = 1

	local title = Instance.new("TextLabel", boundFrame)
	title.Name = "Title"
	title.Text = "CONFIGURATIONS"
	title.BackgroundTransparency = 1
	title.Size = UDim2.new(1, 0, .078,  0)
	title.TextTransparency = 0
	title.TextStrokeTransparency = .8
	title.TextSize = 13
	title.RichText = true
	title.FontFace = Font.new("rbxasset://fonts/families/Balthazar.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	title.TextWrapped = false
	title.TextColor3 = Color3.fromRGB(255, 232, 163)

	local buttonsFrame = Instance.new("Frame", boundFrame)
	buttonsFrame.Name = "ButtonsFrame"
	buttonsFrame.Position = UDim2.new(.047,  0, .125, 0)
	buttonsFrame.Size = UDim2.new(.9, 0, .875, 0)
	buttonsFrame.BackgroundTransparency = 1

	local uiListLayout = Instance.new("UIListLayout", buttonsFrame)
	uiListLayout.Padding = UDim.new(0.1, 0)
	uiListLayout.FillDirection = Enum.FillDirection.Horizontal
	uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	uiListLayout.Wraps =  true
	uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	uiListLayout.HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween
	uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Top

	--[[createButton(generateUUID(), "Common", function()
		
	end, true) -- Trinket <font color="rgb(255,50,50">ESP</font>]]

	return screenGui
end

local leaderboard = playerGui:FindFirstChild("LeaderboardGui")

local function createName(p1, p2, p3, p4, p5, p6)
	if not workspace:FindFirstChild("IsPriv") then
		local v2 = ""
		if p4 == "Owner" then
			local v3
			if p5 == "Female" then
				v3 = "Lady"
			else
				v3 = "Lord"
			end
			v2 = v3
			if p1 == "Ratriel" then
				v2 = "Pontiff"
			end
		end
		local v4 = {}
		if v2 ~= "" then
			table.insert(v4, v2)
		end
		if p1 ~= "" and p1 ~= " " then
			table.insert(v4, p1)
		end
		if p3 ~= "" then
			table.insert(v4, p3)
		end
		local v5 = table.concat(v4, " ")
		local v6 = 0
		if p6 > 0 then
			v6 = 3 + string.len(tostring(p6)) * 3
		end
		local v7 = v6 > 0 and string.rep(" ", v6) .. v5 or v5
		if p2 ~= "" then
			v7 = v7 .. ", " .. p2
		end
		return v7
	else
		local v4 = {}
		if p1 ~= "" and p1 ~= " " then
			return " "..p1
		end
	end
end

local function findPlayer(targetPlayer:Players)
	local leaderstats = targetPlayer:WaitForChild("leaderstats")
	local firstname = leaderstats:WaitForChild("FirstName")
	local ubertitle = leaderstats:WaitForChild("UberTitle")
	local lastname = leaderstats:WaitForChild("LastName")
	local houserank = leaderstats:WaitForChild("HouseRank")
	local gender = leaderstats:WaitForChild("Gender")
	local prestigeLeaderStats = leaderstats:WaitForChild("Prestige")
	local maxedict = leaderstats:WaitForChild("MaxEdict")
	local name = createName(firstname.Value, ubertitle.Value, lastname.Value, houserank.Value, gender.Value, prestigeLeaderStats.Value)

	for _, v in pairs(leaderboard.MainFrame.ScrollingFrame:GetChildren()) do
		if (v.Text == name) then
			return v
		end
	end

	return nil
end

--[[

local playerList = {}

local u1 = false

local function refresh()
	if u1 then
		return
	end
	u1 = true

	local v8 = {}
	local v10 = game.Players:GetPlayers()
	for i,v in pairs(v10)do
		if (v == player) then continue end

		local l__leaderstats__14 = v:FindFirstChild("leaderstats")
		local v15 = l__leaderstats__14 and l__leaderstats__14:FindFirstChild("FirstName")
		if l__leaderstats__14 then
			local l__UberTitle__16 = l__leaderstats__14:FindFirstChild("UberTitle")
		end

		table.insert(v8, v)
	end
	table.sort(v8, function(p7, p8)
		if not p7 then
			return true
		end
		if not p8 then
			return false
		end
		local l__leaderstats__18 = p7:FindFirstChild("leaderstats")
		local l__leaderstats__19 = p8:FindFirstChild("leaderstats")
		local l__Value__20 = l__leaderstats__18.LastName.Value
		local l__Value__21 = l__leaderstats__19.LastName.Value
		if l__Value__20 ~= "" and l__Value__21 == "" then
			return true
		end
		if l__Value__20 == "" and l__Value__21 ~= "" then
			return false
		end
		if l__Value__20 < l__Value__21 then
			return true
		end
		if l__Value__21 < l__Value__20 then
			return false
		end
		local l__Value__22 = l__leaderstats__18.FirstName.Value
		local l__Value__23 = l__leaderstats__19.FirstName.Value
		if l__Value__22 < l__Value__23 then
			return true
		end
		if l__Value__23 < l__Value__22 then
			return false
		end

		return p7.Name < p8.Name
	end)

	for v24, v25 in pairs(v8) do
		local v26 = playerList[v25]
		if (v26) and (typeof(v26) ~= "boolean") then
			v26.Position = UDim2.new(0, 0, 0, (v24 - 1) * 20)
			v26.Visible = true
		end
	end

	for v27, v28 in pairs(leaderboard.MainFrame.ScrollingFrame:children()) do

	end
	local v29 = #v8 * 20
	leaderboard.MainFrame.Size = UDim2.new(0.05, 150, 0, math.min(v29 + 20, 340))
	leaderboard.MainFrame.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, v29)
	u1 = false
end

local function createPlayerLabel(targetPlayer:Player)
	if playerList[targetPlayer] then
		return
	end
	if (findPlayer(targetPlayer)) then return end

	playerList[targetPlayer] = true
	local playerLabel = leaderboard.LeaderboardClient.PlayerLabel:clone()
	playerList[player] = playerLabel
	local prestige = playerLabel:WaitForChild("Prestige")
	local leaderstats = targetPlayer:WaitForChild("leaderstats")
	local firstname = leaderstats:WaitForChild("FirstName")
	local ubertitle = leaderstats:WaitForChild("UberTitle")
	local lastname = leaderstats:WaitForChild("LastName")
	local houserank = leaderstats:WaitForChild("HouseRank")
	local gender = leaderstats:WaitForChild("Gender")
	local prestigeLeaderStats = leaderstats:WaitForChild("Prestige")
	local maxedict = leaderstats:WaitForChild("MaxEdict")
	local Requests = game.ReplicatedStorage.Requests
	Requests.ShowMaxEdict:InvokeServer()
	local v41 = createName(firstname.Value, ubertitle.Value, lastname.Value, houserank.Value, gender.Value, prestigeLeaderStats.Value)
	playerLabel.Text = v41
	if prestigeLeaderStats.Value > 0 then
		prestige.Text = "#" .. prestigeLeaderStats.Value
		prestige.Visible = true
	else
		prestige.Visible = false
	end
	if maxedict.Value then
		playerLabel.TextColor3 = Color3.fromRGB(255, 214, 81)
	else
		playerLabel.TextColor3 = Color3.new(1, 1, 1)
	end
	local constructedName = v41
	ubertitle.Changed:Connect(function()
		constructedName = createName(firstname.Value, ubertitle.Value, lastname.Value, houserank.Value, gender.Value, prestigeLeaderStats.Value)
		playerLabel.Text = constructedName
		refresh()
	end)
	firstname.Changed:connect(function()
		constructedName = createName(firstname.Value, ubertitle.Value, lastname.Value, houserank.Value, gender.Value, prestigeLeaderStats.Value)
		playerLabel.Text = constructedName
		refresh()
	end)
	lastname.Changed:connect(function()
		constructedName = createName(firstname.Value, ubertitle.Value, lastname.Value, houserank.Value, gender.Value, prestigeLeaderStats.Value)
		playerLabel.Text = constructedName
		refresh()
	end)
	houserank.Changed:connect(function()
		constructedName = createName(firstname.Value, ubertitle.Value, lastname.Value, houserank.Value, gender.Value, prestigeLeaderStats.Value)
		playerLabel.Text = constructedName
		refresh()
	end)
	gender.Changed:connect(function()
		refresh()
	end)
	prestigeLeaderStats.Changed:connect(function()
		constructedName = createName(firstname.Value, ubertitle.Value, lastname.Value, houserank.Value, gender.Value, prestigeLeaderStats.Value)
		if prestigeLeaderStats.Value > 0 then
			prestige.Text = "#" .. prestigeLeaderStats.Value
			prestige.Visible = true
		else
			prestige.Visible = false
		end
		playerLabel.Text = constructedName
	end)
	maxedict.Changed:connect(function()
		if maxedict.Value then
			playerLabel.TextColor3 = Color3.fromRGB(255, 214, 81)
			return
		end
		playerLabel.TextColor3 = Color3.new(1, 1, 1)
	end)
	local u10 = targetPlayer.Name:sub(1, 2) .. "\226\128\142" .. targetPlayer.Name:sub(3)
	playerLabel.MouseEnter:connect(function()
		local v42 = 0
		if prestigeLeaderStats.Value > 0 then
			v42 = 3 + string.len(tostring(prestigeLeaderStats.Value)) * 3
		end
		playerLabel.Text = v42 > 0 and string.rep(" ", v42) .. u10 or u10
		playerLabel.TextTransparency = 0.3
	end)
	playerLabel.MouseLeave:connect(function()
		playerLabel.Text = constructedName
		playerLabel.TextTransparency = 0
	end)
	pcall(function()
		playerLabel.Parent = leaderboard.MainFrame.ScrollingFrame
	end)
	refresh()
	return playerLabel
end

game.Players.PlayerAdded:connect(function(p10)
	createPlayerLabel(p10)
end)
]]
local function checkIllu(plr)
	if (plr:FindFirstChild("Backpack")) then
		if (plr.Backpack:FindFirstChild("Observe")) then
			return true
		end
	end
	if (plr.Character) and (plr.Character:FindFirstChild("Observe")) then
		return "Equipped"
	end

	return false
end
--[[
leaderboard.LeaderboardClient.Enabled = false
for _, v in pairs(leaderboard.MainFrame.ScrollingFrame:GetChildren()) do
	v:Destroy()
end

local function refreshGodObserve()
	for v44, v45 in pairs(game.Players:GetPlayers()) do
		if (v45 == player) then 
			local playerLabel = findPlayer(v45)
			if (playerLabel) then
				playerLabel.Visible = false
			end

			continue 
		end
		spawn(function()
			createPlayerLabel(v45)

			local playerLabel = findPlayer(v45)
			if (playerLabel) then
				local illu = checkIllu(v45)
				if (illu) then
					if (illu == "Equipped") then
						playerLabel.TextColor3 = Color3.fromRGB(0, 55, 255)
					else
						playerLabel.TextColor3 = Color3.fromRGB(0, 213, 255)
					end
				else
					if (v45:FindFirstChild("leaderstats")) and (v45:FindFirstChild("leaderstats"):FindFirstChild("MaxEdict")) and (v45:FindFirstChild("leaderstats"):FindFirstChild("MaxEdict").Value) then
						playerLabel.TextColor3 = Color3.fromRGB(255, 214, 81)
					else
						playerLabel.TextColor3 = Color3.new(1, 1, 1)
					end
				end

				if (not v45:FindFirstChild("Ingame")) then
					playerLabel.TextColor3 = playerLabel.TextColor3:lerp(Color3.fromRGB(0, 0, 0), .5)
				end
			end
		end)
	end
end]]

function playerEsp()
	local player = game.Players.LocalPlayer

	local playerEspFolder = playerGui:FindFirstChild("PlayerEsp")
	if (not playerEspFolder) then
		playerEspFolder = Instance.new("Folder", playerGui)
		playerEspFolder:AddTag("GamingGaming")
		playerEspFolder.Name = "PlayerEsp"
	end

	for i, v in pairs(configurations.PlayerEsp.Table) do
		v:Destroy()

		configurations.PlayerEsp.Table[i] = nil
	end

	for _,v in pairs(game.Players:GetChildren()) do
		if (player == v) and (game.PlaceId ~= 18459294953) then continue end

		local char = v.Character or v.CharacterAdded:Wait()
		if (not char) then continue end
		if (not char:FindFirstChild("HumanoidRootPart")) then continue end

		local billboard = Instance.new("BillboardGui", playerEspFolder)
		billboard.Adornee = char.HumanoidRootPart
		billboard.AlwaysOnTop = true
		billboard.MaxDistance = math.huge
		billboard.Enabled = exploits.PlayerEsp
		billboard.Size = UDim2.new(0, 50, 0, 50)

		local text = Instance.new("TextLabel", billboard)
		text.Text = v.Name
		text.Size = UDim2.new(1,0,1,0)
		text.Position = UDim2.new(0,0,0,0)
		text.BackgroundTransparency = 1
		text.TextColor3 = Color3.fromRGB(255,255,255)
		text.TextSize = 24

		if checkIllu(v) then
			text.TextColor3 = Color3.fromRGB(30, 206, 255)
		end

		table.insert(configurations.PlayerEsp.Table, billboard)
	end
end

function esp()
	local player = game.Players.LocalPlayer
	local char = player.Character or player.CharacterAdded:Wait()
	local root = char:WaitForChild("HumanoidRootPart")

	local esptrinket = playerGui:FindFirstChild("EspTrinkets")
	if (not esptrinket) then
		esptrinket = Instance.new("Folder", playerGui)
		esptrinket:AddTag("GamingGaming")
		esptrinket.Name = "EspTrinkets"
	end

	local trinkets = workspace.Trinkets

	for i, v in pairs(configurations.TrinketEsp.Table) do
		v:Destroy()

		configurations.TrinketEsp.Table[i] = nil
	end

	for _,v in pairs(trinkets:GetChildren()) do
		if (not v:FindFirstChild("ClickPart")) then continue end

		local trinketType = "" -- Common, Rare, Gem, Event, SemiArtifact, Artifact, Unknown
		local trinketName = ""

		if (v:IsA("UnionOperation")) then
			if (v.Color == Color3.fromRGB(255,89,89)) and (v.Material == Enum.Material.Neon) then
				trinketName = "Philosopher's Stone"
			elseif (v.Color == Color3.fromRGB(248,248,248)) and (v.Material == Enum.Material.Neon) and (v:FindFirstChildOfClass("PointLight")) then
				trinketName = "White Kings Amulet"
			elseif (v.Color == Color3.fromRGB(111, 113, 125)) and (v.Material == Enum.Material.Slate) and (v:FindFirstChildOfClass("ParticleEmitter")) then
				trinketName = "Idol of the Forgotten"
			elseif (v.Color == Color3.fromRGB(248,248,248)) and (v.Material == Enum.Material.Neon) and (not v:FindFirstChildOfClass("ParticleEmitter")) then
				trinketName = "Lannis' Amulet"
			elseif (v.Color == Color3.fromRGB(29, 46, 58)) and (v.Material == Enum.Material.Neon) and (not v:FindFirstChildOfClass("ParticleEmitter")) then
				trinketName = "Nightstone"
			elseif (v.Color == Color3.fromRGB(248, 217, 109)) then
				trinketName = "Scroom Key"
			elseif (v.Color == Color3.fromRGB(21, 30, 38)) and (v.Material == Enum.Material.Neon) then
				trinketName = "Solan Key"
			elseif (v.Color == Color3.fromRGB(211, 0, 0)) and (v:FindFirstChildOfClass("Attachment")) then
				if (v:FindFirstChildOfClass("Attachment"):FindFirstChild("OrbParticle")) then
					trinketName = "Idol of War"
				end
			elseif (v.Color == Color3.fromRGB(151, 234, 99)) and (v.Material == Enum.Material.Neon) and (v:FindFirstChildOfClass("UnionOperation")) then
				trinketName = "Alter Beetle"
			end
		elseif (v:IsA("MeshPart")) then
			if (configurations.TrinketEsp.KnownMeshList[v.MeshId]) then
				trinketName = configurations.TrinketEsp.KnownMeshList[v.MeshId]
			end

			if (v.MeshId == "rbxassetid://%202877143560%20") then
				trinketName = "Gem"

				if (v.Color == Color3.fromRGB(255, 0, 0)) then
					trinketName = "Ruby"
				end
			elseif (v.MeshId == "rbxassetid://5204453430") then
				trinketName = "Scroll"
			elseif (v.MeshId == "rbxassetid://923469333") then
				trinketName = "Candy"
			elseif (v.MeshId == "rbxassetid://2520762076") then
				trinketName = "Howler Friend"
			elseif (v.MeshId == "rbxassetid://439102658") then
				if (v.Material == Enum.Material.Neon) then
					trinketName = "Phoenix Feather"
				elseif (v.Material == Enum.Material.Sandstone) then
					trinketName = "Harpy Friend"
				end
			end
		elseif (v:IsA("Part")) then
			if (v:FindFirstChildOfClass("SpecialMesh")) then
				if (v:FindFirstChildOfClass("SpecialMesh").MeshId == "rbxassetid://%202877143560%20") then
					trinketName = "Gem"

					if (v.Color == Color3.fromRGB(255, 0, 191)) then
						trinketName = "Rift Gem"
					elseif (v.Color == Color3.fromRGB(0, 184, 49)) then
						trinketName = "Emerald"
					elseif (v.Color == Color3.fromRGB(164, 187, 190)) then
						trinketName = "Diamond"
					elseif (v.Color == Color3.fromRGB(16, 42, 220)) then
						trinketName = "Sapphire"
					end
				elseif (v:FindFirstChildOfClass("SpecialMesh").MeshType == Enum.MeshType.Sphere) then
					if (v.Color == Color3.fromRGB(128, 187, 219)) then
						trinketName = "Fairfrozen"
					elseif (v.Color == Color3.fromRGB(143, 219, 122)) then
						trinketName = "Nature Essence"
					elseif (v.Color == Color3.fromRGB(248, 248, 248)) then
						trinketName = "Opal"
					elseif (v.Material == Enum.Material.Plastic) or (v.Material == Enum.Material.Fabric) then
						if (v:FindFirstChildOfClass("UnionOperation")) then
							trinketName = "Ornament"
						end
					end
				end
			elseif (v:FindFirstChildOfClass("Attachment")) then
				if (v:FindFirstChildOfClass("Attachment"):FindFirstChildOfClass("ParticleEmitter")) then
					if (v:FindFirstChildOfClass("Attachment"):FindFirstChildOfClass("ParticleEmitter").Texture == "rbxassetid://1536547385") then
						-- pd, ma or azael horn
						local particle = v:FindFirstChildOfClass("Attachment"):FindFirstChildOfClass("ParticleEmitter")
						if (particle.LightEmission == 0.5) and (particle.Color ~= ColorSequence.new(Color3.fromRGB(255, 10, 10))) then
							trinketName = "Phoenix Down"
						elseif (particle.Color == ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.45098, 1, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(0.482353, 1, 0, 0))})) then
							trinketName = "Mysterious Artifact"
						else
							trinketName = "Phoenix Flower"
						end
					end
				end
			end

			if (v:FindFirstChild("Horn1") or v:FindFirstChild("Horn2")) then
				trinketName = "Azael Horns"
			end

			if (v:FindFirstChildOfClass("ParticleEmitter")) then
				if (v:FindFirstChildOfClass("ParticleEmitter").Texture == "rbxassetid://20443483") then
					if (v:FindFirstChildOfClass("PointLight")) then
						if (v:FindFirstChildOfClass("PointLight").Color == Color3.fromRGB(132,255,0)) and (v.Color ~= Color3.fromRGB(255,255,0)) then
							trinketName = "Ice Essence"
						elseif (v:FindFirstChildOfClass("PointLight").Color == Color3.fromRGB(106, 56, 255)) or (v.Color == Color3.fromRGB(89,34, 89)) then
							trinketName = "???"
						elseif (v:FindFirstChildOfClass("PointLight").Color == Color3.fromRGB(132,255,0)) then
							trinketName = "Spider Cloak"
						end
					end
				end
			end
		end

		if (trinketName == "") then
			trinketName = "Unknown"
		end

		trinketType = configurations.TrinketEsp.TrinketList[trinketName]
		local trinketTier = configurations.TrinketEsp.ColorCoding[trinketType]
		if (configurations.TrinketEsp.ColorCoding.Specifics[trinketName]) then
			trinketTier = configurations.TrinketEsp.ColorCoding.Specifics[trinketName]
		end

		if (not trinketTier) then continue end
		if (not trinketTier.Show) then
			continue
		end

		local distance = (root.Position - v.Position).Magnitude
		if (distance >= trinketTier.Range) or (distance >= configurations.TrinketEsp.MaxRange) then continue end

		local billboard = Instance.new("BillboardGui", esptrinket)
		billboard.Adornee = v.ClickPart
		billboard.AlwaysOnTop = true
		billboard.MaxDistance = trinketTier.Range
		billboard.Enabled = exploits.TrinketEsp
		billboard.Size = UDim2.new(0, 75, 0, 75)

		local text = Instance.new("TextLabel", billboard)
		text.Text = trinketName
		text.Font = Enum.Font.Antique
		text.Size = UDim2.new(1,0,1,0)
		text.Position = UDim2.new(0,0,0,0)
		text.BackgroundTransparency = 1
		text.TextColor3 = trinketTier.Color
		text.TextTransparency = 0
		text.TextStrokeTransparency = 0
		text.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		text.RichText = true
		text.FontFace = Font.new("rbxasset://fonts/families/Balthazar.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		text.TextWrapped = true
		text.TextSize = 16

		table.insert(configurations.TrinketEsp.Table, billboard)
	end
end

function npcEsp()
	local player = game.Players.LocalPlayer
	local char = player.Character or player.CharacterAdded:Wait()
	local root = char:WaitForChild("HumanoidRootPart")

	local espNPC = playerGui:FindFirstChild("EspNPCs")
	if (not espNPC) then
		espNPC = Instance.new("Folder", playerGui)
		espNPC:AddTag("GamingGaming")
		espNPC.Name = "EspNPCs"
	end

	local npcs = workspace.NPCs

	for i, v in pairs(configurations.NPCEsp.Table) do
		v:Destroy()

		configurations.NPCEsp.Table[i] = nil
	end

	for _,v in pairs(npcs:GetChildren()) do
		if (not v:FindFirstChild("HumanoidRootPart")) then continue end

		local npcType = "Common" -- Common, Rare, Gem, Event, SemiArtifact, Artifact, Unknown
		local npcName = v.Name

		npcType = configurations.NPCEsp.NPCList[npcName] or "Common"
		if (npcType == "Common") then
			if (npcName:find("Outfit")) then
				npcType = "Outfit"
			end
		end
		local npcTier = configurations.NPCEsp.ColorCoding[npcType]
		if (configurations.NPCEsp.ColorCoding.Specifics[npcName]) then
			npcTier = configurations.NPCEsp.ColorCoding.Specifics[npcName]
		end

		if (not npcTier) then continue end
		if (not npcTier.Show) then
			continue
		end

		local distance = (root.Position - v.HumanoidRootPart.Position).Magnitude
		if (distance >= npcTier.Range) or (distance >= configurations.NPCEsp.MaxRange) then continue end

		local billboard = Instance.new("BillboardGui", espNPC)
		billboard.Adornee = v.HumanoidRootPart
		billboard.AlwaysOnTop = true
		billboard.MaxDistance = npcTier.Range
		billboard.Enabled = exploits.NPCEsp
		billboard.Size = UDim2.new(0, 75, 0, 75)

		local text = Instance.new("TextLabel", billboard)
		text.Text = (npcName == "Tai") and "Snowball Tal" or npcName
		text.Font = Enum.Font.Antique
		text.Size = UDim2.new(1,0,1,0)
		text.Position = UDim2.new(0,0,0,0)
		text.BackgroundTransparency = 1
		text.TextColor3 = npcTier.Color
		text.TextTransparency = 0
		text.TextStrokeTransparency = 0
		text.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		text.RichText = true
		text.FontFace = Font.new("rbxasset://fonts/families/Balthazar.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		text.TextWrapped = true
		text.TextSize = 16

		table.insert(configurations.NPCEsp.Table, billboard)
	end
end

local cheatGUI = createGui()
esp()
npcEsp()

playerGui:RemoveTag("GamingGaming")

game.UserInputService.InputBegan:Connect(function(input:InputObject, gpe)
	if (gpe) then
		return
	end

	if (input.KeyCode == Enum.KeyCode.M) then
		cheatGUI.Enabled = not cheatGUI.Enabled
	end
end)

game.UserInputService.JumpRequest:Connect(function()
	if (exploits.InfJump) then
		character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

if (player) and (player:FindFirstChild("leaderstats")) then
	if (player:FindFirstChild("leaderstats"):FindFirstChild("FirstName")) then
		connections.FirstName = player.leaderstats.FirstName:GetPropertyChangedSignal("Value"):Connect(function()
			player.leaderstats.FirstName.Value = "LockExploits"
			changegui()
		end)
		player.leaderstats.FirstName.Value = "LockExploits"
	end
end
if (player) and (player:FindFirstChild("leaderstats")) then
	if (player:FindFirstChild("leaderstats"):FindFirstChild("LastName")) then
		connections.LastName = player.leaderstats.LastName:GetPropertyChangedSignal("Value"):Connect(function()
			player.leaderstats.LastName.Value = ""
			changegui()
		end)
		player.leaderstats.LastName.Value = ""
	end
end
if (player) and (player:FindFirstChild("leaderstats")) then
	if (player:FindFirstChild("leaderstats"):FindFirstChild("HouseRank")) then
		connections.HouseRank = player.leaderstats.HouseRank:GetPropertyChangedSignal("Value"):Connect(function()
			player.leaderstats.HouseRank.Value = ""
			changegui()
		end)
		player.leaderstats.HouseRank.Value = ""
	end
end
if (player) and (player:FindFirstChild("leaderstats")) then
	if (player:FindFirstChild("leaderstats"):FindFirstChild("UberTitle")) then
		connections.UberTitle = player.leaderstats.UberTitle:GetPropertyChangedSignal("Value"):Connect(function()
			player.leaderstats.UberTitle.Value = "The Legit"
			changegui()
		end)
		player.leaderstats.UberTitle.Value = "The Legit"
	end
end
if (player) and (player:FindFirstChild("leaderstats")) then
	if (player:FindFirstChild("leaderstats"):FindFirstChild("Prestige")) then
		connections.Prestige = player.leaderstats.Prestige:GetPropertyChangedSignal("Value"):Connect(function()
			player.leaderstats.Prestige.Value = 1
			changegui()
		end)
		player.leaderstats.Prestige.Value = 1
	end
end
if (player) and (player:FindFirstChild("leaderstats")) then
	if (player:FindFirstChild("leaderstats"):FindFirstChild("MaxEdict")) then
		connections.MaxEdict = player.leaderstats.MaxEdict:GetPropertyChangedSignal("Value"):Connect(function()
			player.leaderstats.MaxEdict.Value = true
			changegui()
		end)
		player.leaderstats.MaxEdict.Value = true
	end
end

connections.Heartbeat = game:GetService("RunService").Heartbeat:Connect(function()
	if (exploits.PlayerEsp) then
		if (tick() - configurations.PlayerEsp.LastUpdated) > 3 then
			playerEsp()

			configurations.PlayerEsp.LastUpdated = tick()
		end
	end

	if (exploits.TrinketEsp) then
		if (tick() - configurations.TrinketEsp.LastUpdated) > 3 then
			esp()

			configurations.TrinketEsp.LastUpdated = tick()
		end
	end

	if (exploits.NPCEsp) then
		if (tick() - configurations.NPCEsp.LastUpdated) > 3 then
			npcEsp()

			configurations.NPCEsp.LastUpdated = tick()
		end
	end

	changegui()
		
--[[
	if (exploits.GodObserve) and (tick() - configurations.GodObserve.LastUpdated) > 1 then
		refreshGodObserve()

		configurations.GodObserve.LastUpdate = tick()
	end]]

	--[[local playerlabel = findPlayer(player)
	if (playerlabel) then
		playerlabel.Visible = false
	end]]

	if (exploits.NoFall) and (configurations.NoFall.CanNoFall) then
		fallRemote:FireServer(0.1)
	end

	if (playerGui:HasTag("GamingGaming")) then
		for _, v in pairs(configurations.PlayerEsp.Table) do
			v:Destroy()
		end
		for _, v in pairs(configurations.TrinketEsp.Table) do
			v:Destroy()
		end
		for _, v in pairs(configurations.NPCEsp.Table) do
			v:Destroy()
		end

		exploits.AutoPickup = false
		exploits.TrinketEsp = false
		exploits.PlayerEsp = false
		exploits.NPCEsp = false
		exploits.InfJump = false
		exploits.Speedhack = false
		exploits.NoFog = false
		--exploits.GodObserve = false
		exploits.NoFall = false

		configurations.NoFall.NoFallLeg:Destroy()

		--leaderboard.LeaderboardClient.Enabled = true

		for _, v in pairs(areaMarkers) do
			v.Parent = workspace.AreaMarkers
		end

		game.Lighting.ExposureCompensation = 0
		game.Lighting.GlobalShadows = true
		game.Lighting.Ambient = Color3.fromRGB(70, 70, 70)
		game.Lighting.ColorShift_Top = Color3.fromRGB(0,0,0)
		game.Lighting.ColorShift_Bottom = Color3.fromRGB(0,0,0)
		game.Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
		game.Lighting.EnvironmentDiffuseScale = 0

		for _, v in pairs(playerGui:GetChildren()) do
			if (v:HasTag("GamingGaming")) then
				v:Destroy()
			end
		end

		for _, v in pairs(connections) do
			v:Disconnect()
		end
	end
end)
