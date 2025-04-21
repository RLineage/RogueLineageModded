local player = game.Players.LocalPlayer

local playerGui = player.PlayerGui
playerGui:AddTag("GamingGaming")

for _, v in pairs(playerGui:GetDescendants()) do
	if (v:HasTag("GamingGaming")) then
		v:Destroy()
	end
end

local range = 1000

local list = nil
local gui = nil

local nofall = false

local _character = player.Character or player.CharacterAdded:Wait()
for _, v in pairs(workspace:GetChildren()) do
	if (v.Name == "NofallLeg") or (v:HasTag("GamingGaming")) then
		v:Destroy()
	end
end

local nofallleg = _character:FindFirstChild("Right Leg"):Clone()
nofallleg.Parent = workspace
nofallleg.Name = "NofallLeg"
nofallleg.CanCollide = false
nofallleg.Anchored = false
nofallleg.Transparency =1 
nofallleg.Size += Vector3.new(1,.4,1)

local weld = Instance.new("Weld", nofallleg)
weld.Part0 = _character:FindFirstChild("HumanoidRootPart")
weld.Part1 = nofallleg
weld.C0 = CFrame.new(0, -2, 0)
weld.C1	= CFrame.new(0, 0, 0)

local fallRemote = _character:WaitForChild("CharacterHandler"):WaitForChild("Remotes"):WaitForChild("ApplyFallDamage")

local trinketList = {
	["rbxassetid://5196551436"] = "Amulet",
	["rbxassetid://5196577540"] = "Old Amulet",
	["rbxassetid://5196776695"] = "Ring",
	["rbxassetid://5196782997"] = "Old Ring",
	["rbxassetid://5204003946"] = "Goblet",
}

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

function generateText(properties)
	local text = ""
	
	for _, textPiece in pairs(properties) do
		local last = ""
		local changed = false
		if (textPiece.color) or (textPiece.italic) or (text.bold) then
			text ..= "<font"
			last = '</font>'
		end
		if (textPiece.color) then
			changed = true

			text ..= ' color="rgb('..textPiece.color.R * 255 ..","..textPiece.color.G * 255 ..","..textPiece.color.B * 255 ..')"'	
		end
		if (textPiece.italic) then
			changed = true

			text ..= ' italic="true"'
		end
		if (textPiece.bold) then
			changed = true

			text ..= ' bold="true"'
		end
	
		if (changed) then
			text ..= ">"
		end
		
		text..= textPiece.text
		text..= last
	end
	
	print( text)
	
	return text
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

local espEnabled = false
local espTable:{BillboardGui} = {}

local playerEspEnabled = false
local playerEspTable = {}

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
		espEnabled = not espEnabled
		
		for _, v in pairs(espTable) do
			v.Enabled = espEnabled
		end
	end) -- Trinket <font color="rgb(255,50,50">ESP</font>

	createButton(generateUUID(), "Player ESP", function()
		playerEspEnabled = not playerEspEnabled

		for _, v in pairs(playerEspTable) do
			v.Enabled = playerEspEnabled
		end
	end)
	
	createButton(generateUUID(), "No Fall", function()
		nofall = not nofall
	end, true)
end

-- Trinket Trinket <font color="rgb(1,0.19607843458652496,0.19607843458652496)">ESPTrinket Trinket <font color="rgb(1,0.19607843458652496,0.19607843458652496)">ESP

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
	
	for i, v in pairs(playerEspTable) do
		v:Destroy()
		
		playerEspTable[i] = nil
	end

	for _,v in pairs(game.Players:GetChildren()) do
		if (player == v) then continue end
		--[[if (not player:FindFirstChild("Ingame")) then
			continue
		end]]
		
		local char = v.Character or v.CharacterAdded:Wait()
		if (not char:FindFirstChild("HumanoidRootPart")) then continue end
		
		print(v.Name)
		
		local billboard = Instance.new("BillboardGui", playerEspFolder)
		billboard.Adornee = char.HumanoidRootPart
		billboard.AlwaysOnTop = true
		billboard.MaxDistance = math.huge
		billboard.Enabled = playerEspEnabled
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
		else
			text.TextColor3 = Color3.fromRGB(255,255,255)
		end
		
		table.insert(playerEspTable, billboard)
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

	for i, v in pairs(espTable) do
		v:Destroy()
		
		espTable[i] = nil
	end

	for _,v in pairs(trinkets:GetChildren()) do
		if (root.Position - v.Position).Magnitude >= range then continue end
		
		if (not v:FindFirstChild("ClickPart")) then continue end
		
		local billboard = Instance.new("BillboardGui", esptrinket)
		billboard.Adornee = v.ClickPart
		billboard.AlwaysOnTop = true
		billboard.MaxDistance = range
		billboard.Enabled = espEnabled
		billboard.Size = UDim2.new(0, 75, 0, 75)
		
		local text = Instance.new("TextLabel", billboard)
		text.Text = "funny thing huh"
		text.Size = UDim2.new(1,0,1,0)
		text.Position = UDim2.new(0,0,0,0)
		text.BackgroundTransparency = 1
		text.TextColor3 = Color3.fromRGB(255,255,255)
		text.TextSize = 24
		
		if (v:IsA("UnionOperation")) then
			if (v.Color == Color3.fromRGB(255,89,89)) and (v.Material == Enum.Material.Neon) then
				text.Text = "Philosopher's Stone"
				text.TextColor3 = Color3.fromRGB(255, 0, 0)
			elseif (v.Color == Color3.fromRGB(248,248,248)) and (v.Material == Enum.Material.Neon) and (v:FindFirstChildOfClass("PointLight")) then
				text.Text = "White Kings Amulet"
				text.TextColor3  = Color3.fromRGB(255, 0, 0)
			elseif (v.Color == Color3.fromRGB(111, 113, 125)) and (v.Material == Enum.Material.Slate) and (v:FindFirstChildOfClass("ParticleEmitter")) then
				text.Text = "Idol of Forgotten"
			elseif (v.Color == Color3.fromRGB(248,248,248)) and (v.Material == Enum.Material.Neon) and (not v:FindFirstChildOfClass("ParticleEmitter")) then
				text.Text = "Lannis' Amulet"
				text.TextColor3 = Color3.fromRGB(136, 0, 255)
			elseif (v.Color == Color3.fromRGB(29, 46, 58)) and (v.Material == Enum.Material.Neon) and (not v:FindFirstChildOfClass("ParticleEmitter")) then
				text.Text = "Nightstone"
				text.TextColor3 = Color3.fromRGB(0, 17, 255)
			elseif (v.Color == Color3.fromRGB(248, 217, 109)) then
				text.Text = "Scroom Key"
				text.TextColor3 = Color3.fromRGB(248, 217, 109)
			elseif (v.Color == Color3.fromRGB(211, 0, 0)) and (v:FindFirstChildOfClass("Attachment")) then
				if (v:FindFirstChildOfClass("Attachment"):FindFirstChild("OrbParticle")) then
					text.Text = "Idol of War"
					text.TextColor3 = Color3.fromRGB(141, 255, 139)
				end
			end
		elseif (v:IsA("MeshPart")) then
			if (trinketList[v.MeshId]) then
				text.Text = trinketList[v.MeshId]
			end

			if (v.MeshId == "rbxassetid://%202877143560%20") then
				text.Text = "Gem"
				
				if (v.Color == Color3.fromRGB(255, 0, 0)) then
					text.Text = "Ruby"
				end
			elseif (v.MeshId == "rbxassetid://5204453430") then
				text.Text = "Scroll"
			elseif (v.MeshId == "rbxassetid://923469333") then
				text.Text = "Candy"
				text.TextColor3 = Color3.fromRGB(141, 255, 139)
			elseif (v.MeshId == "rbxassetid://2520762076") then
				text.Text = "Howler Friend"
				text.TextColor3 = Color3.fromRGB(255, 114, 49)
			end
		elseif (v:IsA("Part")) then
			if (v:FindFirstChildOfClass("SpecialMesh")) then
				if (v:FindFirstChildOfClass("SpecialMesh").MeshId == "rbxassetid://%202877143560%20") then
					text.Text = "Gem"
					text.TextColor3	= Color3.fromRGB(255, 194, 194)
					
					if (v.Color == Color3.fromRGB(255, 0, 191)) then
						text.Text = "Rift Gem"
						text.TextColor3	= Color3.fromRGB(255, 0, 191)
					elseif (v.Color == Color3.fromRGB(0, 184, 49)) then
						text.Text = "Emerald"
					elseif (v.Color == Color3.fromRGB(164, 187, 190)) then
						text.Text = "Diamond"
					elseif (v.Color == Color3.fromRGB(16, 42, 220)) then
						text.Text = "Sapphire"
					end
				elseif (v:FindFirstChildOfClass("SpecialMesh").MeshType == Enum.MeshType.Sphere) then
					if (v.Color == Color3.fromRGB(128, 187, 219)) then
						text.Text = "Fairfrozen"
						text.TextColor3 = Color3.fromRGB(128, 187, 219)
					elseif (v.Color == Color3.fromRGB(143, 219, 122)) then
						text.Text = "Nature Essence"
						text.TextColor3 = Color3.fromRGB(143, 219, 122)
					elseif (v.Color == Color3.fromRGB(248, 248, 248)) then
						text.Text = "Opal"
					end
				end
			elseif (v:FindFirstChildOfClass("Attachment")) then
				if (v:FindFirstChildOfClass("Attachment"):FindFirstChildOfClass("ParticleEmitter")) then
					if (v:FindFirstChildOfClass("Attachment"):FindFirstChildOfClass("ParticleEmitter").Texture == "rbxassetid://1536547385") then
						-- pd, ma or azael horn
						local particle = v:FindFirstChildOfClass("Attachment"):FindFirstChildOfClass("ParticleEmitter")
						if (particle.LightEmission == 0.5) and (particle.Color ~= ColorSequence.new(Color3.fromRGB(255, 10, 10))) then
							text.Text = "Phoenix Down"
							text.TextColor3 = Color3.fromRGB(255, 140, 0)
						elseif (particle.Color == ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.45098, 1, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(0.482353, 1, 0, 0))})) then
							text.Text = "Mysterious Artifact"
							text.TextColor3 = Color3.fromRGB(98, 255, 0)
						else
							text.Text = "Azael Horn"
							text.TextColor3 = Color3.fromRGB(255, 0, 4)
						end
					end
				end
			end
			
			if (v:FindFirstChildOfClass("ParticleEmitter")) then
				if (v:FindFirstChildOfClass("ParticleEmitter").Texture == "rbxassetid://20443483") then
					if (v:FindFirstChildOfClass("PointLight")) then
						if (v:FindFirstChildOfClass("PointLight").Color == Color3.fromRGB(132,255,0)) and (v.Color ~= Color3.fromRGB(255,255,0)) then
							text.Text = "Ice Essence"
							text.TextColor3 = Color3.fromRGB(53, 255, 188)
						elseif (v:FindFirstChildOfClass("PointLight").Color == Color3.fromRGB(106, 56, 255)) or (v.Color == Color3.fromRGB(89,34, 89)) then
							text.Text = "???"
							text.TextColor3 = Color3.fromRGB(151, 0, 52)
						elseif (v:FindFirstChildOfClass("PointLight").Color == Color3.fromRGB(132,255,0)) then
							text.Text = "Spider Cloak"
							text.TextColor3 = Color3.fromRGB(255, 255, 0)
						end
					end
				end
			end
		end
		
		if (text.Text == "funny thing huh") then
			text.Text = "UNKNOWN"
			text.TextColor3 = Color3.fromRGB(251, 255, 0)
			
			local unknown = Instance.new("Folder", v)
			unknown.Name = "Unknown"
		end
		
		table.insert(espTable, billboard)
	end
end

-- 0 ,0.45098, 1, 0, 0, 1, 0.482353, 1, 0 ,0

createGui()
esp()

playerGui:RemoveTag("GamingGaming")

local lastpespupdated = tick()
local lastupdated = tick()

local connect:RBXScriptConnection = nil
connect = game:GetService("RunService").Heartbeat:Connect(function()
	if (playerEspEnabled) then
		if (tick() - lastpespupdated) > 3 then
			playerEsp()

			lastpespupdated = tick()
		end
	end
	
	if (espEnabled) then
		if (tick() - lastupdated) > 3 then
			esp()

			lastupdated = tick()
		end
	end

	nofallleg.CanCollide = nofall
	
	if (playerGui:HasTag("GamingGaming")) then
		for _, v in pairs(playerEspTable) do
			v:Destroy()
		end
		for _, v in pairs(espTable) do
			v:Destroy()
		end
		nofallleg:Destroy()
		weld:Destroy()
		
		for _, v in pairs(playerGui:GetChildren()) do
			if (v:HasTag("GamingGaming")) then
				v:Destroy()
			end
		end
		
		print("REMOVED GUI GAMINGGAMING")
		
		connect:Disconnect()
	end
end)
