if (not game:IsLoaded()) then
	repeat task.wait(.1) until game:IsLoaded()
end

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart")

local playerGui = player.PlayerGui
playerGui:AddTag("GamingGaming")

for _, v in pairs(playerGui:GetDescendants()) do
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
				Range = 1000
			},
			Artifact = {
				Show = true,
				Color = Color3.fromRGB(255, 0, 0),
				Range = 1250
			},
			Unknown = {
				Show = true,
				Color = Color3.fromRGB(225, 0, 255),
				Range = 1250
			},
			Specifics = {
				["Rift Gem"] = {
					Show = true,
					Color = Color3.fromRGB(255, 0, 255),
					Range = 1250
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

			["Unknown"] = "Unknown"
		},
		MaxRange = 1250,
		LastUpdated = tick(),
		Table = {},
	},
	PlayerEsp = {
		LastUpdated = tick(),
		Table = {},	
	},
	NoFall = {
		NoFallLeg = character:FindFirstChild("Right Leg"):Clone()	
	},
	AutoPickup = {
		CanAutoPickup = true	
	},
}

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

local function createButton(name, text, mouse1click, toggle)
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
	boundFrame.Position = UDim2.new(0.05, 0, 0.05, 0)
	boundFrame.Size = UDim2.new(0.9, 0, 0.9, 0)
	boundFrame.BackgroundTransparency = 1
	
	list = boundFrame
	
	local uiListLayout = Instance.new("UIListLayout", boundFrame)
	uiListLayout.Padding = UDim.new(0.05, 0)
	uiListLayout.FillDirection = Enum.FillDirection.Horizontal
	
	gui = screenGui
	
	createButton(generateUUID(), "Trinket ESP", function()
		exploits.TrinketEsp = not exploits.TrinketEsp
		
		for _, v in pairs(configurations.TrinketEsp.Table) do
			v.Enabled = exploits.TrinketEsp
		end
	end, true) -- Trinket <font color="rgb(255,50,50">ESP</font>

	createButton(generateUUID(), "Player ESP", function()
		exploits.PlayerEsp = not exploits.PlayerEsp

		for _, v in pairs(configurations.PlayerEsp.Table) do
			v.Enabled = exploits.PlayerEsp
		end
	end, true)

	createButton(generateUUID(), "No Fall", function()
		exploits.NoFall = not exploits.NoFall
	end, true)

	createButton(generateUUID(), "Auto Pickup", function()
		exploits.AutoPickup = not exploits.AutoPickup
	end, true)
end

local function createExtraGui()
	local screenGui = Instance.new("ScreenGui", playerGui)
	screenGui.Name = generateUUID().."ScreenGui"

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
	boundFrame.Position = UDim2.new(0.05, 0, 0.05, 0)
	boundFrame.Size = UDim2.new(0.9, 0, 0.9, 0)
	boundFrame.BackgroundTransparency = 1

	list = boundFrame

	local uiListLayout = Instance.new("UIListLayout", boundFrame)
	uiListLayout.Padding = UDim.new(0.05, 0)
	uiListLayout.FillDirection = Enum.FillDirection.Horizontal

	gui = screenGui

	createButton(generateUUID(), "Common", function()
		
	end, true) -- Trinket <font color="rgb(255,50,50">ESP</font>
end

local function checkIllu(plr)
	local illu = false

	if (plr.Backpack:FindFirstChild("Observe")) then
		illu = true
	end
	if (plr.Character:FindFirstChild("Observe")) then
		illu = true
	end
	
	return illu
end

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
			elseif (v.Color == Color3.fromRGB(211, 0, 0)) and (v:FindFirstChildOfClass("Attachment")) then
				if (v:FindFirstChildOfClass("Attachment"):FindFirstChild("OrbParticle")) then
					trinketName = "Idol of War"
				end
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

local connect:RBXScriptConnection = nil
connect = game:GetService("RunService").Heartbeat:Connect(function()
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
		for _, v in pairs(workspace.Trinkets:GetChildren()) do
			if (root.Position - v.Position).Magnitude <= 5 then
				if (v:FindFirstChild("ClickPart")) then
					if (v.ClickPart:FindFirstChildOfClass("ClickDetector")) then
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

	configurations.NoFall.NoFallLeg.CanCollide = exploits.NoFall
	
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
		
		configurations.NoFall.NoFallLeg:Destroy()
		
		for _, v in pairs(playerGui:GetChildren()) do
			if (v:HasTag("GamingGaming")) then
				v:Destroy()
			end
		end
		
		connect:Disconnect()
	end
end)
