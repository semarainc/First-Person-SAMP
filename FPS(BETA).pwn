/*				==================OTONG FPS=====================
Little Explanation, this is my third FS(i think) cuzz i want to make FPS mode for my server so i release this FS
you can edit this fs , and change the credit if you want :D
i know there are many bugs on camera view like whe aim, and on vehicle, but i will try do my best to fix is asap
if you can make this FS better dont forget to post it :D it will be useful for other members :D

Credits : Semara123(Make This FS)
		  Face9000(IsPlayerInWater ----> got it on SAMP Scripting Help Section :D)
          MasonSFW(IsPlayerAiming ----> got is on SAMP Scripting Help Section :D)

I Hope This FS will be Useful and you can make this FS better

Sorry For My Bad English
				============NG FPS(First Person Shooter)========
*/
//#define FILTERSCRIPT

#include <a_samp>
//#include <limex>
// PRESSING(keyVariable, keys)
#define MPH_KMH 1.609344
#define PRESSING(%0,%1) \
	(%0 & (%1))
#define RELEASED(%0) \
	(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
#define PRESSED(%0) \
(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define HOLDING(%0) \
	((newkeys & (%0)) == (%0))
	new noclipdata[MAX_PLAYERS];
	new guyfps[MAX_PLAYERS];
//new vehfps[MAX_PLAYERS]; // not used :p
new jongkok[MAX_PLAYERS]; // jongkok means crouch in indonesia :v
new aim[MAX_PLAYERS]; //aim variable
new swim[MAX_PLAYERS];//swim variable
#if defined FILTERSCRIPT


public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Otong FPS EXPERIMENTAL by: Semara123");
	print("----------------LOADED------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
    print("\n--------------------------------------");
	print(" Otong FPS EXPERIMENTAL by: Semara123");
	print("----------------UNLOADED------------------\n");
	return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print(" Blank Gamemode by your name here");
	print("----------------------------------\n");
}

#endif

public OnGameModeInit()
{
	// Don't use these lines if it's a filterscript
//	SetGameModeText("Blank Script");
//	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
//	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
//	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
//	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
	guyfps[playerid] = 0;
	aim[playerid] = 0;
	jongkok[playerid] = 0;
	swim[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
    SetTimerEx("dcek", 1, true, "i", playerid); // timer check
	return 1;
}
forward dcek(playerid);
public dcek(playerid)
{
	if(!IsPlayerAiming(playerid) && aim[playerid] == 1 && guyfps[playerid] == 1)
	{
	    FPSMode(playerid);
	    aim[playerid] = 0;
	}
	if(guyfps[playerid] == 1 && GetPlayerSpecialAction(playerid)!= SPECIAL_ACTION_DUCK && !IsPlayerInAnyVehicle(playerid))
	{
	   // FlyMode(playerid);
		ResetFPSMode(playerid);
	}
	if(!IsPlayerInWater(playerid) && swim[playerid] == 1)
	{
		FPSMode(playerid);
		swim[playerid] = 0;
	}
	// well the vehicle FPS is on Experimental version :p not recomended
	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsPlayerInAnyVehicle(playerid) && GetVehicleSpeed(vehicleid) > 100.00000)
	{
	    ResetFPSMode2(playerid);
	}
	return 1;
}
stock IsPlayerInWater(playerid)
{
    new animlib[32],tmp[32];
    GetAnimationName(GetPlayerAnimationIndex(playerid),animlib,32,tmp,32);
    if( !strcmp(animlib, "SWIM") && !IsPlayerInAnyVehicle(playerid) ) return true;
    return false;
}
public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[]) // lazy using zcmd :v
{
	if (strcmp("/fps", cmdtext, true, 10) == 0)
	{
	    if(guyfps[playerid] == 0 && !IsPlayerInAnyVehicle(playerid))
	    {
	    	guyfps[playerid]=1;
			FPSMode(playerid);
		}
		return 1;
	}
	if (strcmp("/fpsoff", cmdtext, true, 10) == 0)
	{
	    if(guyfps[playerid] == 1)
		{
		    SetCameraBehindPlayer(playerid);
		    guyfps[playerid] = 0;
		}
		return 1;
	}
	if (strcmp("/weapon", cmdtext, true, 10) == 0)
	{
		GivePlayerWeapon(playerid,34, 999999);
        GivePlayerWeapon(playerid,30, 999999);
        GivePlayerWeapon(playerid,28, 999999);
        SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 1);
		return 1;
	}
	if (strcmp("/veh", cmdtext, true, 10) == 0)
	{
	    new Float:x,  Float:y, Float:z, Float:a;
	    GetPlayerFacingAngle(playerid, a);
	    GetPlayerPos(playerid, x, y, z);
		CreateVehicle(400, x, y, z+5.0, a, 1, 2, -1);
		return 1;
	}
	if (strcmp("/hydra", cmdtext, true, 10) == 0)
	{
	    new Float:x,  Float:y, Float:z, Float:a;
	    GetPlayerFacingAngle(playerid, a);
	    GetPlayerPos(playerid, x, y, z);
		CreateVehicle(520, x, y+3.0, z+5.0, a, 1, 2, -1);
		return 1;
	}
	if (strcmp("/fpsveh", cmdtext, true, 10) == 0)
	{
	    //vehfps[playerid] = 1;
     	FPSMode2(playerid); // this function currently in Experimental Version
		return 1;
	}
	if (strcmp("/jetpack", cmdtext, true, 10) == 0)
	{
     	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
		return 1;
	}
	return 0;
}

stock FPSMode(playerid)
{
	// Create an invisible object for the players camera to be attached to
	guyfps[playerid] = 1;
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	DestroyObject(noclipdata[playerid]);
	noclipdata[playerid] = CreateObject(19300, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
//	SetCameraBehindPlayer(playerid);
	// Place the player in spectating mode so objects will be streamed based on camera location
	//TogglePlayerSpectating(playerid, true);
	// Attach the players camera to the created object
	AttachObjectToPlayer(noclipdata[playerid], playerid, 0.0, 0.3, 0.75  , 0.0, 0.0, 0.0);
	//AttachPlayerObjectToPlayer(noclipdata[playerid], 19300, playerid, X, Y, Z, 0, 0, 0 );
	//AttachCameraToPlayerObject(playerid, noclipdata[playerid]);
 	AttachCameraToObject(playerid, noclipdata[playerid]);
//	SetPVarInt(playerid, "FlyMode", 1);
	return 1;
}

stock SwimMode(playerid)
{
	// Create an invisible object for the players camera to be attached to
	//guyfps[playerid] = 1;
	//new Float:X, Float:Y, Float:Z;
	//GetPlayerPos(playerid, X, Y, Z);
	//DestroyObject(noclipdata[playerid]);
	//noclipdata[playerid] = CreateObject(19300, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
	//SetCameraBehindPlayer(playerid);
	// Place the player in spectating mode so objects will be streamed based on camera location
	//TogglePlayerSpectating(playerid, true);
	// Attach the players camera to the created object
	AttachObjectToPlayer(noclipdata[playerid], playerid, 0.0, 0.7, 0.55  , 0.0, 0.0, 0.0);
	//AttachPlayerObjectToPlayer(noclipdata[playerid], 19300, playerid, X, Y, Z, 0, 0, 0 );
	//AttachCameraToPlayerObject(playerid, noclipdata[playerid]);
 	AttachCameraToObject(playerid, noclipdata[playerid]);
//	SetPVarInt(playerid, "FlyMode", 1);
	return 1;
}

stock CrouchMode(playerid)
{
    guyfps[playerid] = 1;
	// Create an invisible object for the players camera to be attached to
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	DestroyObject(noclipdata[playerid]);
	noclipdata[playerid] = CreateObject(19300, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
	//SetCameraBehindPlayer(playerid);
	// Place the player in spectating mode so objects will be streamed based on camera location
	//TogglePlayerSpectating(playerid, true);
	// Attach the players camera to the created object
	AttachObjectToPlayer(noclipdata[playerid], playerid,  0.0, 0.0, 0.20 , 0.0, 0.0, 0.0);
	//AttachPlayerObjectToPlayer(noclipdata[playerid], 19300, playerid, X, Y, Z, 0, 0, 0 );
	//AttachCameraToPlayerObject(playerid, noclipdata[playerid]);
 	AttachCameraToObject(playerid, noclipdata[playerid]);
//	SetPVarInt(playerid, "FlyMode", 1);
	return 1;
}

stock ResetFPSMode(playerid)
{
	// Create an invisible object for the players camera to be attached to

	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	//DestroyObject(noclipdata[playerid]);
	//noclipdata[playerid] = CreateObject(19300, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
	//SetCameraBehindPlayer(playerid);
	// Place the player in spectating mode so objects will be streamed based on camera location
	//TogglePlayerSpectating(playerid, true);
	// Attach the players camera to the created object
	//AttachObjectToPlayer(noclipdata[playerid], playerid, 0.0, 0.3, 0.75  , 0.0, 0.0, 0.0);
	//AttachPlayerObjectToPlayer(noclipdata[playerid], 19300, playerid, X, Y, Z, 0, 0, 0 );
	//AttachCameraToPlayerObject(playerid, noclipdata[playerid]);
 	AttachCameraToObject(playerid, noclipdata[playerid]);
//	SetPVarInt(playerid, "FlyMode", 1);
	return 1;
}

stock FPSMode2(playerid)
{
//veh
	// Create an invisible object for the players camera to be attached to
	//new noclipdata[MAX_PLAYERS];
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	DestroyObject(noclipdata[playerid]);
	noclipdata[playerid] = CreateObject(19300, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
	SetCameraBehindPlayer(playerid);
	// Place the player in spectating mode so objects will be streamed based on camera location
	//TogglePlayerSpectating(playerid, true);
	// Attach the players camera to the created object
	//new vehicleid = GetPlayerVehicleID(playerid);
	AttachObjectToPlayer(noclipdata[playerid], playerid,0.0, -0.2, 0.55 , 0.0, 0.0, 0.0);
	//AttachPlayerObjectToPlayer(noclipdata[playerid], 19300, playerid, X, Y, Z, 0, 0, 0 );
	//AttachCameraToPlayerObject(playerid, noclipdata[playerid]);
 	AttachCameraToObject(playerid, noclipdata[playerid]);
//	SetPVarInt(playerid, "FlyMode", 1);
	return 1;
}
stock ResetFPSMode2(playerid)
{
//veh
	// Create an invisible object for the players camera to be attached to
//	new noclipdata[MAX_PLAYERS];
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	//DestroyObject(noclipdata[playerid]);
	//noclipdata[playerid] = CreateObject(19300, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
	//SetCameraBehindPlayer(playerid);
	// Place the player in spectating mode so objects will be streamed based on camera location
	//TogglePlayerSpectating(playerid, true);
	// Attach the players camera to the created object
	AttachObjectToPlayer(noclipdata[playerid], playerid,0.0, -0.2, 0.55 , 0.0, 0.0, 0.0);
	//AttachPlayerObjectToPlayer(noclipdata[playerid], 19300, playerid, X, Y, Z, 0, 0, 0 );
	//AttachCameraToPlayerObject(playerid, noclipdata[playerid]);
 	AttachCameraToObject(playerid, noclipdata[playerid]);
//	SetPVarInt(playerid, "FlyMode", 1);
	return 1;
}

stock ResetGun(playerid)
{
//veh
	// Create an invisible object for the players camera to be attached to
//	new noclipdata[MAX_PLAYERS];
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	SetPlayerCameraPos(playerid, X, Y, Z);
	//DestroyObject(noclipdata[playerid]);
	//noclipdata[playerid] = CreateObject(19300, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
	//SetCameraBehindPlayer(playerid);
	// Place the player in spectating mode so objects will be streamed based on camera location
	//TogglePlayerSpectating(playerid, true);
	// Attach the players camera to the created object
	AttachObjectToPlayer(noclipdata[playerid], playerid,0.0, -0.1, 0.85 , 0.0, 0.0, 0.0);
	//AttachPlayerObjectToPlayer(noclipdata[playerid], 19300, playerid, X, Y, Z, 0, 0, 0 );
	//AttachCameraToPlayerObject(playerid, noclipdata[playerid]);
 	AttachCameraToObject(playerid, noclipdata[playerid]);
//	SetPVarInt(playerid, "FlyMode", 1);
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	guyfps[playerid] = 0;
    SetCameraBehindPlayer(playerid);
	//FPSMode2(playerid);
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	guyfps[playerid] = 1;
    FPSMode(playerid);
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}
stock crouch(playerid)
{
	    if(jongkok[playerid] == 0)
	    {
	        guyfps[playerid] = 0;
			CrouchMode(playerid);
			jongkok[playerid] = 1;
		}
		if(jongkok[playerid] == 1)
		{
		    guyfps[playerid] = 0;
		    FPSMode(playerid);
		    jongkok[playerid] = 0;
		}
  		return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (PRESSING(newkeys, KEY_LEFT | KEY_RIGHT) && IsPlayerInAnyVehicle(playerid))
	{
	    ResetFPSMode2(playerid);
	}
	if (PRESSING(newkeys, KEY_UP | KEY_DOWN) && IsPlayerInAnyVehicle(playerid))
	{
	    ResetFPSMode2(playerid);
	}
	if (PRESSING(newkeys, KEY_HANDBRAKE | KEY_FIRE))
	{
	    if(!IsPlayerInAnyVehicle(playerid))
	    {
	    if(GetPlayerCameraMode(playerid) == 46)
		{
	    	ResetFPSMode(playerid);
		}
	    //ResetGun(playerid);
	    //SendClientMessage(playerid, -1, "RightClick");
	    }
	}
	if( PRESSING(newkeys, KEY_SPRINT) && IsPlayerInWater(playerid) ) //swim
	{
	    swim[playerid] = 1;
		SwimMode(playerid);
//	    crouch(playerid);
	}
	if( PRESSING(newkeys, KEY_UP) && IsPlayerInWater(playerid) ) //swim
	{
	    swim[playerid] = 1;
		SwimMode(playerid);
//	    crouch(playerid);
	}
	if(RELEASED(KEY_SPRINT) && IsPlayerInWater(playerid))
	{
	    swim[playerid] = 0;
	    FPSMode(playerid);
	}
	if(RELEASED(KEY_UP) && IsPlayerInWater(playerid))
	{
	    swim[playerid] = 0;
	    FPSMode(playerid);
	}
	/*if (oldkeys == KEY_HANDBRAKE | KEY_FIRE)
	{
	    if(!IsPlayerInAnyVehicle(playerid))
	    {
	    ResetGun(playerid);
     	SendClientMessage(playerid, -1, "RightClick2");
	    }
	}
	if (RELEASED(KEY_HANDBRAKE | KEY_FIRE))
	{
	    if(!IsPlayerInAnyVehicle(playerid))
	    {
	    ResetFPSMode(playerid);
     	SendClientMessage(playerid, -1, "RightClickLepas");
	    }
	}*/
	return 1;
}

stock IsPlayerAiming(playerid)
{
	new anim = GetPlayerAnimationIndex(playerid);
	if (((anim >= 1160) && (anim <= 1163)) || (anim == 1167) || (anim == 1365) ||
	(anim == 1643) || (anim == 1453) || (anim == 220)) return 1;
 	return 0;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	if(guyfps[playerid] == 1 && GetPlayerSpecialAction(playerid)!= SPECIAL_ACTION_DUCK && jongkok[playerid] == 1)
	{
	    jongkok[playerid] = 0;
	    FPSMode(playerid);
		ResetFPSMode(playerid);
	}
	if(guyfps[playerid] == 1 && IsPlayerAiming(playerid) && GetPlayerSpecialAction(playerid)!= SPECIAL_ACTION_DUCK )
	{
	    ResetGun(playerid);
	}
	if (guyfps[playerid] == 1 && GetPlayerSpecialAction(playerid)== SPECIAL_ACTION_DUCK && jongkok[playerid] == 0)
	{
	    CrouchMode(playerid);
	    jongkok[playerid] = 1;
	}
	if(guyfps[playerid] == 1) ResetFPSMode(playerid);
	if(IsPlayerAiming(playerid) && GetPlayerSpecialAction(playerid)!= SPECIAL_ACTION_DUCK && guyfps[playerid] == 1)
	{
	    aim[playerid] = 1;
		ResetGun(playerid);
	}
	/*if(IsPlayerInAnyVehicle(playerid))
	{
	FPSMode2(playerid);
	}*/
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

stock GetVehicleSpeed( vehicleid )
{
	// Function: GetVehicleSpeed( vehicleid )

	new
	    Float:x,
	    Float:y,
	    Float:z,
		vel;

	GetVehicleVelocity( vehicleid, x, y, z );

	vel = floatround( floatsqroot( x*x + y*y + z*z ) * 180 );			// KM/H
//	vel = floatround( floatsqroot( x*x + y*y + z*z ) * 180 / MPH_KMH ); // MPH

	return vel;
}
