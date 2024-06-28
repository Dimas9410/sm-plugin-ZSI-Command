//updated 9/12/2023 @ 8:27 PM
#include <sourcemod>
#include <sdktools>
#include <multicolors> 

#pragma semicolon 1

new Float:g_fSeconds[MAXPLAYERS + 1];
new Handle:gcV_DiscordCountdownTime;
new Handle:gcV_SteamCountdownTime;

public Plugin myinfo =
{
    name = "ZSI Command",
    author = "ArmadiLo, Dimas9410",
    description = "Trigger to print link to the user chat",
    version = "1.1",
    url = "github.com/afaqih"
};

public void OnPluginStart()
{
    RegConsoleCmd("sm_discord", Command_Discord);
    gcV_DiscordCountdownTime = CreateConVar("sm_discord_command_wait_time", "5.0", "discord Wait time", FCVAR_NONE, true, 0.0);
    RegConsoleCmd("sm_steamgroup", Command_Steam);
    gcV_SteamCountdownTime = CreateConVar("sm_steamgroup_command_wait_time", "5.0", "steamgroup Wait time", FCVAR_NONE, true, 0.0);
}

public void OnClientPutInServer(int client)
{
    g_fSeconds[client] = GetGameTime();
}

public Action Command_Discord(int client, int args)
{
	if (IsClientInGame(client) && !IsFakeClient(client))
	{
		if (args > 0)
		return Plugin_Handled;
	}

	if (g_fSeconds[client] + GetConVarFloat(gcV_DiscordCountdownTime) > GetGameTime())
	{
		CPrintToChat(client, "{lightgreen}You need to wait {green}%.1f {lightgreen}more time to use this command.", ((g_fSeconds[client] + RoundFloat(GetConVarFloat(gcV_DiscordCountdownTime))) - RoundFloat(GetGameTime())));
	}
	else {
		CPrintToChat(client, "{grey}[{green}ZSI{grey}] {green}Discord {lightgreen}Group : {white}https://discord.com/invite/zsi");
	}

	g_fSeconds[client] = GetGameTime();
	
	return Plugin_Handled;
} 

public Action Command_Steam(int client, int args)
{	
	if (g_fSeconds[client] + GetConVarFloat(gcV_SteamCountdownTime) > GetGameTime()) {
		CPrintToChat(client, "{lightgreen}You need to wait {green}%.1f {lightgreen}more time to use this command.", ((g_fSeconds[client] + RoundFloat(GetConVarFloat(gcV_SteamCountdownTime))) - RoundFloat(GetGameTime())));
	}
	else {
		CPrintToChat(client, "{grey}[{green}ZSI{grey}] {green}Steam {lightgreen}Group : {white}https://steamcommunity.com/groups/zombieescapeserverindonesia");
	}
	
	g_fSeconds[client] = GetGameTime();
	
	return Plugin_Handled;
}
