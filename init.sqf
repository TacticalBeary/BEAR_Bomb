if ((!isServer) && (player != player)) then {waitUntil {player == player};};

if (hasInterface) then {
    ["ace_arsenal_displayClosed", {
        player setVariable ["BEAR_ACESavedLoadout", getUnitLoadout player];
        hint "Respawn Loadout Saved";
    }] call CBA_fnc_addEventHandler;
};

forceRotorLibSimulation = 0;
// addactions - local

call compile preprocessFileLineNumbers "scripts\tracker.sqf";

BIS_fnc_endMission = compileFinal "";

["ACRE_PRC152", "default", 1, "description", "NOTUSED"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "default", 2, "description", "PLATOON-COMS"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "default", 3, "description", "COMMAND"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "default", 4, "description", "AIR-REQUESTS"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "default", 5, "description", "ZEUS"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "default", 6, "description", "X1-1"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "default", 7, "description", "X1-2"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "default", 8, "description", "X1-3"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "default", 9, "description", "X1-6"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "default", 10, "description", "BK"] call acre_api_fnc_setPresetChannelField;


["ACRE_PRC148", "default", 1, "label", "NOTUSED"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC148", "default", 2, "label", "PLATOON-COMS"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC148", "default", 3, "label", "COMMAND"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC148", "default", 4, "label", "AIR-REQUESTS"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC148", "default", 5, "label", "ZEUS"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC148", "default", 6, "label", "X1-1"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC148", "default", 7, "label", "X1-2"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC148", "default", 8, "label", "X1-3"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC148", "default", 9, "label", "X1-6"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "default", 9, "description", "BK"] call acre_api_fnc_setPresetChannelField;


["ACRE_PRC117F", "default", 1, "name", "NOTUSED"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", "default", 2, "name", "PLATOON-COMS"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", "default", 3, "name", "COMMAND"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", "default", 4, "name", "AIR-REQUESTS"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", "default", 5, "name", "ZEUS"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", "default", 6, "name", "X1-1"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", "default", 7, "name", "X1-2"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", "default", 8, "name", "X1-3"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", "default", 9, "name", "X1-6"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "default", 9, "description", "BK"] call acre_api_fnc_setPresetChannelField;

SpawnInformantFNC =
{	
	params ["_class", "_trigger", "_zRot", "_animationName", "_text"];

	//Spawn agent.
	private _pos = getPosATL _trigger;
	private _informant = createAgent [_class, _pos, [], 0, "NONE"];
	_informant setPosATL _pos;
	
	//Rotate.
	[_informant, [_zRot,0,0]] call BIS_fnc_setObjectRotation;
	
	//Add action.
	[
		_informant,														// Object the action is attached to
		"Converse",													// Title of the action
		'a3\missions_f_oldman\data\img\holdactions\holdaction_talk_ca.paa',	// Idle icon shown on screen
		'a3\missions_f_oldman\data\img\holdactions\holdaction_talk_ca.paa',	// Progress icon shown on screen
		"_this distance _target < 3",									// Condition for the action to be shown
		"_caller distance _target < 3",									// Condition for the action to progress
		{},																// Code executed when action starts
		{},																// Code executed on every progress tick
		{ hint ((_this select 3) select 0); },							// Code executed on completion
		{},																// Code executed on interrupted
		[_text],																// Arguments passed to the scripts as _this select 3
		3,																// Action duration in seconds
		0,																// Priority
		false,															// Remove on completion
		false															// Show in unconscious state
	] remoteExec ["BIS_fnc_holdActionAdd", 0, _informant];	


	//Animate.
	if (isServer && _animationName != "") then { [_informant, _animationName, "NONE"] remoteExecCall ["BIS_fnc_ambientAnim"]};
	
	//Remove action if dead.
	_informant addEventHandler ['Killed', {  
		params ['_unit', '_killer'];  
		removeAllActions _unit;
		if (!isNull _killer) then {
		_message = format ["%1 has killed a civilian informant. Intel has been lost.", name _killer];
		_message remoteExec ["hint", 0];
		};
	}];	
	
	
	//return.
	_informant;
};
