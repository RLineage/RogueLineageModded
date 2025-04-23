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
	PlayerEsp = false,
	NoFall = false,
	AutoPickup = false,
	Configurations = false,
	GodObserve = true,
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
	PlayerEsp = {
		LastUpdated = tick(),
		Table = {},	
	},
	NoFall = {
		CanNoFall = true,
		NoFallLeg = character:FindFirstChild("Right Leg"):Clone()	
	},
	AutoPickup = {
		CanAutoPickup = true,
		Percent = 0.9,
		LastUpdated = tick()
	},
	GodObserve = {
		UltraClasses = {
			"sigilknightcommander",
			"facelessone",
			"shinobi",
			"oni",
			""
		},
		Observing = false,
	}
}

local fallRemote
local s, m = pcall(function()
	fallRemote = character:FindFirstChild("CharacterHandler"):FindFirstChild("Remotes"):FindFirstChild("ApplyFallDamage")
end)
if (not s) then
	warn("No Fall couldn't be initialized!")
	warn(m)
	configurations.NoFall.CanNoFall = false
end

connections.CharacterAdded = player.CharacterAdded:Connect(function(char)
	character = char
	root = character:FindFirstChild("HumanoidRootPart")
	
	local s, m = pcall(function()
		fallRemote = character:FindFirstChild("CharacterHandler"):FindFirstChild("Remotes"):FindFirstChild("ApplyFallDamage")
	end)
	if (not s) then
		warn("No Fall couldn't be initialized!")
		warn(m)
		configurations.NoFall.CanNoFall = false
	end
end)

for _, v in pairs(workspace:GetChildren()) do
	if (v.Name == "NofallLeg") or (v:HasTag("GamingGaming")) then
		v:Destroy()
	end
end

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
	frame.Position = UDim2.new(0.6, 0, 0.1, 0)
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
	title.Text = "ROGUE CHEAT"
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

	local aPickup = createButton(generateUUID(), "Auto Pickup", function()
		exploits.AutoPickup = not exploits.AutoPickup
	end, true)
	
	local nFall = createButton(generateUUID(), "No Fall", function()
		exploits.NoFall = not exploits.NoFall
	end, true)
	
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
	aPickup.LayoutOrder = 3
	nFall.LayoutOrder = 4
	--configs.LayoutOrder = 100
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

local function checkIllu(plr)
	if (plr.Backpack:FindFirstChild("Observe")) then
		return true
	end
	if (plr.Character) and (plr.Character:FindFirstChild("Observe")) then
		return "Equipped"
	end

	return false
end

function godObserve()
	local screenGui = Instance.new("ScreenGui", playerGui)
	screenGui.Name = "GodObserve"
	screenGui.ResetOnSpawn = false
	
	local mainFrame = Instance.new("ImageLabel", screenGui)
	mainFrame.Position = UDim2.new(1, 0, 0, 0)
	mainFrame.Size = UDim2.new(0.05, 150, 0, 200)
	mainFrame.BackgroundTransparency = 1
	mainFrame.AnchorPoint = Vector2.new(1, 0)
	mainFrame.ZIndex = 1
	mainFrame.Image = "rbxassetid://1327087642"
	mainFrame.ImageColor3 = Color3.fromRGB(255, 255, 255)
	mainFrame.ImageTransparency = 0.8
	mainFrame.ScaleType = Enum.ScaleType.Slice
	mainFrame.SliceCenter = Rect.new(20, 20, 190, 190)
	mainFrame.SliceScale = 1
	
	local scrollingFrame = Instance.new("ScrollingFrame", mainFrame)
	scrollingFrame.Position = UDim2.new(0, 15, 0, 10)
	scrollingFrame.Size = UDim2.new(1, -30, 1, -20)
	scrollingFrame.BackgroundTransparency = 1
	scrollingFrame.ClipsDescendants = true
	scrollingFrame.BottomImage = "rbxassetid://3515608177"
	scrollingFrame.MidImage = "rbxassetid://3515608813"
	scrollingFrame.TopImage = "rbxassetid://3515609176"
	scrollingFrame.ScrollBarImageTransparency = 0
	scrollingFrame.ScrollBarThickness = 10
	scrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y
	scrollingFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
	scrollingFrame.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right
	scrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(121, 245, 231)
	scrollingFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
	
	local uiList = Instance.new("UIListLayout", scrollingFrame)
	
	local mouseInside = false
	
	local function createPlayerLabel(plr:Player)
		if (plr == player) then return end
		
		local playerLabel = Instance.new("TextButton", scrollingFrame)
		playerLabel.BackgroundTransparency = 1
		playerLabel.Size = UDim2.new(1, 0, 0, 20)
		playerLabel.ClipsDescendants = false
		playerLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
		playerLabel.Name = plr.UserId
		playerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		playerLabel.TextSize = 18
		playerLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		playerLabel.TextStrokeTransparency = 0.5
		playerLabel.Text = ""
		playerLabel.TextXAlignment = Enum.TextXAlignment.Left

		local prestigeLabel = Instance.new("TextButton", playerLabel)
		prestigeLabel.BackgroundTransparency = 1
		prestigeLabel.TextSize = 16
		prestigeLabel.Size = UDim2.new(0, 35, 0, 20)
		prestigeLabel.Position = UDim2.new(0,0,0,1)
		prestigeLabel.ClipsDescendants = false
		prestigeLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
		prestigeLabel.Name = "Prestige"
		prestigeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		prestigeLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		prestigeLabel.TextStrokeTransparency = 0.5
		prestigeLabel.TextTransparency = 0.2
		prestigeLabel.TextXAlignment = Enum.TextXAlignment.Left
		prestigeLabel.Text = "#???"
		
		local function renew()
			playerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			
			local leaderstats = plr.leaderstats

			local firstName = leaderstats.FirstName.Value
			local lastName = leaderstats.LastName.Value
			local houseRank = leaderstats.HouseRank.Value
			local gender = leaderstats.Gender.Value
			local maxEdict = leaderstats.MaxEdict.Value
			local prestige = leaderstats.Prestige.Value
			local uberTitle = leaderstats.UberTitle.Value

			local name = ""

			if (houseRank == "Owner") then
				if (gender == "Female") then
					name = "Lady "
				else
					name = "Lord "
				end

				if (firstName == "Ratriel") then
					lastName = "Pontiff"
				end
			end

			name ..= firstName
			if (lastName ~= "") then
				name ..= " "..lastName
			end
			if (uberTitle ~= "") then
				name ..= ", "..uberTitle
			end
			
			if (maxEdict) then
				playerLabel.TextColor3 = Color3.fromRGB(255, 255, 105)
			end
			if (prestige ~= 0) then
				playerLabel.Text = "          "
				prestigeLabel.Visible = true
				prestigeLabel.Text = "#"..prestige
			else
				prestigeLabel.Visible = false	
			end
			local illu = checkIllu(player)
			if (illu) then
				if (illu == "Equipped") then
					playerLabel.TextColor3 = Color3.fromRGB(0, 38, 255)
				else
					playerLabel.TextColor3 = Color3.fromRGB(0, 242, 255)
				end
			end
			if (not player:FindFirstChild("Ingame")) then
				playerLabel.TextColor3 = playerLabel.TextColor3:Lerp(Color3.fromRGB(0, 0, 0), .5)
			end
			
			if (mouseInside) then
				playerLabel.TextColor3 = playerLabel.TextColor3:Lerp(Color3.fromRGB(0, 0, 0), .3)
				name = plr.Name 
			end
			playerLabel.Text = name
		end
		
		renew()

		connections[math.random(-99999999999999, 99999999999999)] = playerLabel.MouseButton1Click:Connect(function()
			renew()

			if (not plr.Character) then return end
				if (not plr:FindFirstChild("Ingame")) then
				return
			end

			local humanoid
			local s, m = pcall(function()
				humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
			end)

			if (not s) then return end

			if (configurations.GodObserve.Observing == humanoid) then
				configurations.GodObserve.Observing = false
			else
				configurations.GodObserve.Observing = humanoid
			end
		end)

		connections[math.random(-99999999999999, 99999999999999)] = playerLabel.MouseEnter:Connect(function()
			mouseInside = true
			renew()

			playerLabel.Text = plr.Name
		end)
		
		connections[math.random(-99999999999999, 99999999999999)] = playerLabel.MouseLeave:Connect(function()
			mouseInside = false
			renew()
		end)
	end

	connections[math.random(-99999999999999, 99999999999999)] = game.Players.PlayerAdded:Connect(function(v)
		createPlayerLabel(v)
	end)

	connections[math.random(-99999999999999, 99999999999999)] = game.Players.PlayerRemoving:Connect(function(v)
		if (scrollingFrame:FindFirstChild(v.UserId)) then
			scrollingFrame:FindFirstChild(v.UserId):Destroy()
		end
	end)

	for _, v in pairs(game.Players:GetPlayers()) do
		createPlayerLabel(v)
	end
	
	return screenGui
end

local godObserveGui = godObserve()
leaderboard.Enabled = false

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

createGui()
esp()

playerGui:RemoveTag("GamingGaming")

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
	
	if (exploits.AutoPickup) and (configurations.AutoPickup.CanAutoPickup) then
		if (tick() - configurations.AutoPickup.LastUpdated) > 0.7 then
			configurations.AutoPickup.LastUpdated = tick()

			for _, v in pairs(workspace.Trinkets:GetChildren()) do
				if (v:FindFirstChild("ClickPart")) then
					if (v.ClickPart:FindFirstChildOfClass("ClickDetector")) then
						if (root.Position - v.Position).Magnitude <= v.ClickPart:FindFirstChildOfClass("ClickDetector").MaxActivationDistance * configurations.AutoPickup.Percent then
							if fireclickdetector then
								fireclickdetector(v.ClickPart:FindFirstChildOfClass("ClickDetector"))
							else
								warn("Your exploit doesn't have needed dependencies.")
								warn("Missing: 'fireclickdetector'.")

								configurations.AutoPickup.CanAutoPickup = false

								break
							end
						end
					end
				end
			end
		end
	end

	configurations.NoFall.NoFallLeg.CanCollide = exploits.NoFall
	
	--[[if (exploits.NoFall) and (configurations.NoFall.CanNoFall) then
		fallRemote:FireServer(-0.1)
	end]]
	
	if (configurations.GodObserve.Observing == false) then
		workspace.CurrentCamera.CameraSubject = character:FindFirstChildOfClass("Humanoid")
	else
		print("observing")
		workspace.CurrentCamera.CameraSubject = configurations.GodObserve.Observing	
	end	

	leaderboard.Enabled = not godObserveGui.Enabled

	if (playerGui:HasTag("GamingGaming")) then
		for _, v in pairs(configurations.PlayerEsp.Table) do
			v:Destroy()
		end
		for _, v in pairs(configurations.TrinketEsp.Table) do
			v:Destroy()
		end

		exploits.AutoPickup = false
		exploits.TrinketEsp = false
		exploits.PlayerEsp = false
		exploits.NoFall = false
		exploits.GodObserve = false
		
		configurations.NoFall.NoFallLeg:Destroy()
		
		godObserveGui:Destroy()
		leaderboard.Enabled = true
		
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
