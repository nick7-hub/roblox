--[[
	made by nick7
	OUTDATED
]]
local ui = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Workspace = game.Workspace
local RunService = game:GetService("RunService")
local _delay = .1
local Player = game.Players.LocalPlayer

function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end
function isNumber(str)
	if tonumber(str) ~= nil or str == 'inf' then
		return true
	end
end

function tp(instance:Part)
	local char = game.Players.LocalPlayer.Character
	if char and getRoot(char) then
		getRoot(char).CFrame = instance.CFrame
	end
end

function bring(instance:Part)
	local char = game.Players.LocalPlayer.Character
	if char and getRoot(char) then
		instance.CFrame = getRoot(char).CFrame
	end
end

local GC = getconnections or get_signal_cons
if GC then
	for i,v in pairs(GC(game.Players.LocalPlayer.Idled)) do
		if v["Disable"] then
			v["Disable"](v)
		elseif v["Disconnect"] then
			v["Disconnect"](v)
		end
	end
else
	game.Players.LocalPlayer.Idled:Connect(function()
		local VirtualUser = game:GetService("VirtualUser")
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end)
end

local Window = ui:MakeWindow({Name = "Ultimate Town Sandbox", HidePremium = false, SaveConfig = true, ConfigFolder = "utsScript", IntroEnabled = false})
local CharactersTab = Window:MakeTab({
	Name = "Character",
	Icon = nil,
	PremiumOnly = false
})
local FarmingTab = Window:MakeTab({
	Name = "Farming",
	Icon = nil,
	PremiumOnly = false
})
local WorldTab = Window:MakeTab({
	Name = "World",
	Icon = nil,
	PremiumOnly = false
})
local MoodTab = Window:MakeTab({
	Name = "Mood",
	Icon = nil,
	PremiumOnly = false
})
local TeleportTab = Window:MakeTab({
	Name = "Teleports",
	Icon = nil,
	PremiumOnly = false
})
local Settings = Window:MakeTab({
	Name = "Settings",
	Icon = nil,
	PremiumOnly = false
})
local CreditsTab = Window:MakeTab({
	Name = "Credits",
	Icon = nil,
	PremiumOnly = false
})

local allCharacters = workspace.PlayableCharacters:GetChildren()
local characterstbl = {}

for _,v in pairs(allCharacters) do
	table.insert(characterstbl, v.Name)
end

CharactersTab:AddDropdown({
	Name = "Swap to character",
	Default = "Sam",
	Options = characterstbl,
	Callback = function(Value)
		game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("SwapCharacter"):FireServer(Value)
	end    
})

CharactersTab:AddSection({Name = "Stats"})

CharactersTab:AddLabel("God Mode - will damage you with -inf hp")
local _godmode = false
CharactersTab:AddToggle({
	Name = "God mode",
	Default = false,
	Callback = function(Value)
		_godmode = Value
		while _godmode do
			task.wait()
			local args = {
				[1] = game.Players.LocalPlayer.Character,
				[2] = -math.huge,
				[3] = "Left Leg"
			}

			game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Shoot"):FireServer(unpack(args))
		end
	end
})
CharactersTab:AddLabel("Semi godmode - will set your hp to 10 using hospital")
local _semigod = false
CharactersTab:AddToggle({
	Name = "Semi godmode",
	Default = false,
	Callback = function(Value)
		_semigod = Value
		while _semigod do
			task.wait()
			game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("RestoreHealth"):FireServer(game:GetService("Players").LocalPlayer.Character.Humanoid)
		end
	end
})

local _greet = false
CharactersTab:AddLabel("Use loop greet to unlock Ari\nUse loop insult to unlock Alexia")
CharactersTab:AddToggle({
	Name = "Loop greet (bandit)",
	Default = false,
	Callback = function(Value)
		_greet = Value
		while _greet do
			game:GetService("ReplicatedStorage").Events.LootEvent:FireServer(workspace.NPCs.Enemies:FindFirstChild("Bandit"), "AddGreet")
			task.wait()
		end
	end
})

local _insult = false
CharactersTab:AddToggle({
	Name = "Loop insult (bandit)",
	Default = false,
	Callback = function(Value)
		_greet = Value
		while _greet do
			game:GetService("ReplicatedStorage").Events.LootEvent:FireServer(workspace.NPCs.Enemies:FindFirstChild("Bandit"), "AddInsult")
			task.wait()
		end
	end
})

FarmingTab:AddSection({Name = "Hospital"})

FarmingTab:AddButton({
	Name = "[BETA] Cure patients",
	Callback = function()
		local function get(item)
			if item.ClassName == "Part" then
				tp(item)
				task.wait(_delay)
				fireproximityprompt(item.ProximityPrompt)
			end
		end
		local customers = workspace.NPCs.Customers_Hospital:GetChildren()
		local bandages = workspace.JobParts.Hospital.Bandages
		local bandegesPrompt = bandages.ProximityPrompt
		bandegesPrompt.HoldDuration = 0
		local firstaidkid = workspace.JobParts.Hospital.FirstAidKit
		local fikPrompt = firstaidkid.ProximityPrompt
		fikPrompt.HoldDuration = 0
		local icepack = workspace.JobParts.Hospital.IcePack
		local icepackPrompt = icepack.ProximityPrompt
		icepackPrompt.HoldDuration = 0
		local medicine = workspace.JobParts.Hospital.Medicine
		local medicinePrompt = medicine.ProximityPrompt
		medicinePrompt.HoldDuration = 0
		local mop = workspace.JobParts.Hospital.Mop
		local mopPrompt = mop.ProximityPrompt
		mopPrompt.HoldDuration = 0
		local stethoscope = workspace.JobParts.Hospital.Stethoscope
		local stethoscopePrompt = stethoscope.ProximityPrompt
		stethoscopePrompt.HoldDuration = 0
		local thermometer = workspace.JobParts.Hospital.Thermometer
		local thermometerPrompt = thermometer.ProximityPrompt
		thermometerPrompt.HoldDuration = 0
		for _, v in pairs(customers) do
			local wanted = v:GetAttribute("WantedItem")
			local status = v:WaitForChild("Pose").Value
			if string.match(status, "Seated") then
				if string.match(wanted, "Bandages") then
					get(bandages)
				elseif string.match(wanted, "First Aid Kit") then
					get(firstaidkid)
				elseif string.match(wanted, "Medicine") then
					get(medicine)
				elseif string.match(wanted, "Thermometer") then
					get(thermometer)
				elseif string.match(wanted, "Ice Pack") then
					get(icepack)
				elseif string.match(wanted, "Stethoscope") then
					get(stethoscope)
				end
				task.wait(.4)
				tp(v.HumanoidRootPart)
				task.wait(.5)
				v.HumanoidRootPart.InteractNPC.HoldDuration = 0
				fireproximityprompt(v.HumanoidRootPart.InteractNPC)
				task.wait(.2)
			end
		end
	end
})

local _spillsauto = false
FarmingTab:AddToggle({
	Name = "Autofarm spills",
	Default = false,
	Callback = function(Value)
		_spillsauto = Value
		while _spillsauto do
			local char = game.Players.LocalPlayer.Character
			local mop = game:GetService("Workspace").JobParts.Hospital.Mop
			local spills = workspace.JobParts.Spills:GetChildren()
			if not char:FindFirstChild("Mop") then
				repeat
					tp(mop)
					task.wait(_delay)
					fireproximityprompt(mop.ProximityPrompt)
					task.wait()
				until char:FindFirstChild("Mop")
			end
			task.wait()
			task.spawn(function()
				for _,v in pairs(spills) do
					tp(v)
					game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid").Sit = false
					task.wait(_delay)
					repeat
						task.wait()
					until v:FindFirstChild("SpillPrompt")
					v:FindFirstChild("SpillPrompt").HoldDuration = 0
					fireproximityprompt(v:FindFirstChild("SpillPrompt"))
					if _spillsauto == false then
						break
					end
					task.wait()
				end
			end)
		end
	end    
})

WorldTab:AddSection({Name = "NPCs"})
local npcs_selected:Instance
local npcs_category_avaliable = {}
for _,v in pairs(workspace.NPCs:GetChildren()) do
	if #v:GetChildren() ~= 0 then
		table.insert(npcs_category_avaliable, v.Name)
	end
end
WorldTab:AddDropdown({
	Name = "Select type - Kill NPCs",
	Default = workspace.NPCs.SidewalkNPCs.Name,
	Options = npcs_category_avaliable,
	Callback = function(Value)
		npcs_selected = workspace.NPCs:FindFirstChild(Value)
	end
})
WorldTab:AddButton({
	Name = "Kill NPCs",
	Callback = function()
		local can_pass = false
		if Player.Character:FindFirstChild("Fists") then
			for i, v in pairs(npcs_selected:GetChildren()) do
				game:GetService("ReplicatedStorage").Events.Shoot:FireServer(v, 5000, "Head")
			end
			ui:MakeNotification({
				Name = "Kill NPCs",
				Content = "Done killing ".. npcs_selected.Name .." NPCs",
				Image = nil,
				Time = 3
			})
		else
			game:GetService("ReplicatedStorage").Events.Unequip:FireServer()
			game:GetService("ReplicatedStorage").Events.Equip:FireServer("Fists")
			task.wait()
			if Player.Backpack:FindFirstChild("Fists") then
				can_pass = true
			else
				repeat
					task.wait()
					game:GetService("ReplicatedStorage").Events.Equip:FireServer("Fists")
				until Player.Character:FindFirstChild("Fists")
			end
			if can_pass then
				for i, v in pairs(npcs_selected:GetChildren()) do
					game:GetService("ReplicatedStorage").Events.Shoot:FireServer(v, 5000, "Head")
				end
				ui:MakeNotification({
					Name = "Kill NPCs",
					Content = "Done killing ".. npcs_selected.Name .." NPCs",
					Image = nil,
					Time = 3
				})
				game:GetService("ReplicatedStorage").Events.Unequip:FireServer()
			end
		end
	end
})


MoodTab:AddSection({Name = "General"})

MoodTab:AddToggle({
	Name = "Toggle mood overlays",
	Default = true,
	Save = true,
	Flag = "MoodOverlay",
	Callback = function(Value)
		game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.EnergyVignette.Visible = Value
		game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.HungerStatic.Visible = Value
		game:GetService("Lighting").ThirstBlur.Enabled = Value 

	end    
})

MoodTab:AddButton({
	Name = "Show mood upgrades menu",
	Callback = function()
		game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.MoodUpgrades.Visible = true
	end
})

MoodTab:AddButton({
	Name = "Sleep",
	Callback = function()
		local char = game.Players.LocalPlayer.Character
		if char and getRoot(char) then
			local all = Workspace:GetDescendants()
			for _, v in pairs(all) do
				if v:IsA("ProximityPrompt") then
					if string.match(v.ObjectText, "Bed") then
						repeat
							tp(v.Parent)
							task.wait(_delay)
							fireproximityprompt(v)
						until char.Sit
						break
					end
				end
			end
		end
	end
})

MoodTab:AddButton({
	Name = "+100 to every mood ($24.99)",
	Callback = function()
		if not Player.Backpack:FindFirstChild("GhostBurger") then
			game:GetService("ReplicatedStorage").Events.BuyConsumable:FireServer("GhostBurger",game:GetService("ReplicatedStorage").GlobalVariables.FoodBuyPrices.BurgerPlace)
		end
		repeat
			game:GetService("ReplicatedStorage").Events.Equip:FireServer("GhostBurger")
			task.wait()
		until Player.Character:FindFirstChild("GhostBurger")
		repeat
			game:GetService("ReplicatedStorage").Events.UseConsumable:FireServer("GhostBurger")
			task.wait()
		until not Player.Character:FindFirstChild("GhostBurger")
	end
})

TeleportTab:AddSection({Name = "Houses"})
TeleportTab:AddButton({
	Name = "Sam's house",
	Callback = function()
		tp(Workspace.Waypoints.Sam.Home)
	end,
})

TeleportTab:AddButton({
	Name = "Ari's house",
	Callback = function()
		tp(Workspace.Waypoints.Ari.Home)
	end
})

TeleportTab:AddButton({
	Name = "Thomas' house",
	Callback = function()
		tp(Workspace.Waypoints.Thomas.Home)
	end
})

TeleportTab:AddButton({
	Name = "Isaac's house",
	Callback = function()
		tp(Workspace.Waypoints.Isaac.Home)
	end
})

TeleportTab:AddButton({
	Name = "Alexia's house",
	Callback = function()
		tp(Workspace.Waypoints.Alexia.Home)
	end
})

TeleportTab:AddButton({
	Name = "Jason's house",
	Callback = function()
		tp(Workspace.Waypoints.Jason.Home)
	end
})

TeleportTab:AddButton({
	Name = "Bill's house",
	Callback = function()
		tp(Workspace.Waypoints.Bill.Home)
	end
})

TeleportTab:AddButton({
	Name = "Mayor's Mansion",
	Callback = function()
		tp(Workspace.Waypoints.MayorCyprus.Home)
	end
})

TeleportTab:AddSection({Name = "Jobs"})
TeleportTab:AddButton({
	Name = "Pizza Place",
	Callback = function()
		tp(Workspace.Waypoints.AllChars["Pizza Place"])
	end
})

TeleportTab:AddButton({
	Name = "Burger Place",
	Callback = function()
		tp(Workspace.Waypoints.AllChars["Burger Place"])
	end
})

TeleportTab:AddButton({
	Name = "Hospital",
	Callback = function()
		tp(Workspace.Waypoints.AllChars.Hospital)
	end
})

TeleportTab:AddButton({
	Name = "Barber & Cafe",
	Callback = function()
		tp(Workspace.Waypoints.AllChars["Barber & Cafe"])
	end
})

TeleportTab:AddSection({Name = "Buildings & Misc"})
TeleportTab:AddButton({
	Name = "Clothing Store",
	Callback = function()
		tp(Workspace.Waypoints.AllChars["Clothing Store"])
	end
})

TeleportTab:AddButton({
	Name = "Gun Store",
	Callback = function()
		tp(Workspace.Waypoints.AllChars["Gun Store"])
	end
})

TeleportTab:AddButton({
	Name = "Police Station",
	Callback = function()
		tp(Workspace.Waypoints.AllChars["Police Station"])
	end
})

TeleportTab:AddButton({
	Name = "Gas Station",
	Callback = function()
		tp(Workspace.Waypoints.AllChars["Gas Station"])
	end
})

TeleportTab:AddButton({
	Name = "Trading Post",
	Callback = function()
		tp(Workspace.Waypoints.AllChars["Trading Post"])
	end
})

TeleportTab:AddButton({
	Name = "Sell Plants",
	Callback = function()
		tp(Workspace.Waypoints.AllChars["Sell Plants"])
	end
})

TeleportTab:AddButton({
	Name = "Mountain Race (start)",
	Callback = function()
		tp(Workspace.Waypoints.AllChars["Mountain Race"])
	end
})

TeleportTab:AddButton({
	Name = "Top of Mountain (end)",
	Callback = function()
		tp(Workspace.Waypoints.AllChars["Top of Mountain"])
	end
})

TeleportTab:AddButton({
	Name = "Beach",
	Callback = function()
		tp(Workspace.Waypoints.AllChars.Beach)
	end
})

TeleportTab:AddButton({
	Name = "Barber & Cafe",
	Callback = function()
		tp(Workspace.Waypoints.AllChars["Barber & Cafe"])
	end
})

Settings:AddSlider({
	Name = "Delay before firing proximity prompts",
	Min = 0,
	Max = 1,
	Default = 0.1,
	Color = Color3.fromRGB(38, 255, 45),
	Increment = 0.1,
	ValueName = "seconds",
	Save = true,
	Flag = "DelayProximityPrompt",
	Callback = function(Value)
		_delay = Value
	end    
})

Settings:AddToggle({
	Name = "Toggle 3D rendering",
	Default = true,
	Save = true,
	Flag = "3DRendering",
	Callback = function(Value)
		RunService:Set3dRenderingEnabled(Value)
	end    
})

Settings:AddButton({
	Name = "Destroy UI",
	Callback = function()
		ui:Destroy()
	end
})

CreditsTab:AddLabel("Script made by nick7 with <3")
CreditsTab:AddLabel("Join nick7 community - discord.gg/6tgCfU2fX8")
CreditsTab:AddLabel("Using Orion UI library for this script.")

ui:Init()