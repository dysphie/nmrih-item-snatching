#include <sdktools>
#include <sdkhooks>

public Plugin myinfo = {
	name        = "[NMRiH] Item Snatching",
	author      = "Dysphie",
	description = "Allows you to snatch props carried by other players",
	version     = "1.0.0",
	url         = "https://github.com/dysphie/nmrih-item-snatch"
};

ConVar cvEnabled;

public void OnPluginStart()
{
	cvEnabled = CreateConVar("sm_item_snatch_enabled", "1", "Enables or disables item snatching");
	AutoExecConfig(true, "plugin.item-snatch");
}

public void OnEntityCreated(int entity, const char[] classname)
{
	if (cvEnabled.BoolValue && StrEqual(classname, "player_pickup"))
		SDKHook(entity, SDKHook_Spawn, OnPickupSpawned);
}
	
void OnPickupSpawned(int entity)
{
	RequestFrame(GetAttachedEntity, EntIndexToEntRef(entity));
}

void GetAttachedEntity(int pickup_ref)
{
	int pickup = EntRefToEntIndex(pickup_ref);
	if (pickup == -1)
		return;

	int entity = GetEntPropEnt(pickup, Prop_Data, "m_attachedEntity");
	int client = GetEntPropEnt(pickup, Prop_Data, "m_hParent");

	if (entity == -1 || client == -1 || !IsPlayerAlive(client))
		return;

	for (int i = 1; i <= MaxClients; i++)
	{
		if (i == client || !IsClientInGame(i) || !IsPlayerAlive(i))
			continue;

		int useEnt = GetEntPropEnt(i, Prop_Data, "m_hUseEntity");
		if (useEnt == -1)
			continue;

		char classname[15];
		GetEntityClassname(useEnt, classname, sizeof(classname));

		if (StrEqual(classname, "player_pickup") &&
			GetEntPropEnt(useEnt, Prop_Data, "m_attachedEntity") == entity)
		{
			AcceptEntityInput(useEnt, "Use", i);
		}
	}
}