do -- protection
	if getfenv().getconnections then
		for _, Connection in next, getfenv().getconnections(game:GetService("ScriptContext").Error) do
			Connection:Disable()
		end
		for _, Connection in next, getfenv().getconnections(game:GetService("LogService").MessageOut) do
			Connection:Disable()
		end
	end
end

local id = game.PlaceId
local notif = loadstring(game:HttpGet("https://raw.githubusercontent.com/laagginq/ui-libraries/main/dxhooknotify/src.lua", true))()
function load(str)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/nick7-hub/roblox/main/scripts/"..str))()
end
if id == 205224386 then
    load("hidenseek_extreme.lua")
elseif id == 2693739238 then
    load("thief_life.lua")
--elseif id == 15214140740 then
--    load("UltimateTownSandbox.lua")
elseif id == 9647190122 then
    load("max_obby.lua")
elseif id == 32331218 then
    load("mmrp-autofarm.lua")
elseif id == 6999691637 then
    load("rbds.lua")
elseif id == 230362888 then
    load("normal_elevator.lua")
elseif id == 15410077867 then
    load("superhero_obby.lua")
elseif id == 2537430692 then
    load("bnp.lua")
elseif id == 394773622 then
    game.Workspace.DoShopPurchase:InvokeServer(game.Players.LocalPlayer.leaderstats.Coins, -945986745698454679,"skill3")
elseif id == 4104106043 then
    local space=game:GetService("Workspace")
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = space.Lobby.Teleporters.Enter.CFrame;task.wait(.5)
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = space.Lobby.SpawnLocation.CFrame
	game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
elseif id == 537413528 then
    load("babft.lua")
elseif id == 3411100258 then
    load("bordr_autofarm.lua")
else
    print("===")
    warn("Game ("..game.PlaceId..") is not supported by nick7 hub!")
    print("If game IS supported, create a ticket in our discord: discord.gg/6tgCfU2fX8")
    print("===")
    notif:Notify("nick7 hub","Game is not supported! Check \"/console\"",10)
end