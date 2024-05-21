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
	_class = (_this select 0);
	_trigger = (_this select 1);
	_zRot = (_this select 2);
	_animationName = (_this select 3);
	_text = (_this select 4);

	//Spawn agent.
	_pos = getPosATL _trigger;
	_informant = createAgent [_class, _pos, [], 0, "NONE"];
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

CODEINPUT = [];

// Server decides the code and correct laptop
if(isServer) then {
    CODE = floor (random 10);
    publicVariable "CODE";

    codeHolder = selectRandom [LAPTOP1, LAPTOP2, LAPTOP3, LAPTOP4];
    publicVariable "codeHolder";
};

// Waiting for server to decide which laptop is holder
0 spawn {
    waitUntil {sleep 1; !isNil"codeHolder"};
    codeHolder addAction [("Search for a code"),"DEFUSE\searchAction.sqf","",1,true,true,"","(_target distance _this) < 3"];
};

caseBombActionID = caseBomb addAction [("Defuse the bomb"),{createDialog "KeypadDefuse";},"",1,true,true,"","(_target distance _this) < 5"];

// wait before trigger activated
waitUntil {sleep 1; triggerActivated bombTimer};

if (isServer) then
{
    caseBomb setVariable ["BEAR_timer", serverTime + 300, true];
	[ west, ["Task_Defuse"], ["Find the code and defuse the bomb before it explodes.", "Defuse the bomb", "DEFUSE"], objNull, FALSE ] call BIS_fnc_taskCreate;  
  	[ west, ["Task_Secure"], ["Secure the SCUD launcher and bring it back to FOB Sentinel Ridge for proper disposal", "Secure CBRN SCUD Vehicle", "SECURE"], objNull, FALSE ] call BIS_fnc_taskCreate;

    // Create separate thread, store it's handle
    BEAR_serverCountDownThread = 0 spawn
    {
        private _alive = true;
        private _defused = false;
        private _remaining = 1;

        while {_alive && !_defused} do
        {
            sleep 0.5;

            _alive = alive caseBomb;
            _defused = caseBomb getVariable ["BEAR_defused", false];
            _remaining = (caseBomb getVariable ["BEAR_timer", 0]) - serverTime;

            if (_remaining < 0) exitWith
            {
                // Detonate and kill everyone in range
                createVehicle ["Bomb_03_F", getPos caseBomb, [], 0, "NONE"];
                {if (_x distance caseBomb <= 15) then {_x setDamage 1};} forEach allUnits;
                deleteVehicle caseBomb; // caseBomb is not alive anymore
            };
        };
    };
};

// make sure the variable is successfully broadcasted over the network
waitUntil {sleep 0.5; (caseBomb getVariable ["BEAR_timer", 0] != -1)};

if (hasInterface) then {
	0 spawn
	{
    private _remaining = 1;
    while {(_remaining > 0) && !(caseBomb getVariable ["BEAR_DEFUSED", false])} do
		{
			sleep 1;
			_remaining = (caseBomb getVariable ["BEAR_timer", 0]) - serverTime;
			hintSilent format["Bomb Detonation: \n %1", [(_remaining/60), "HH:MM"] call BIS_fnc_timetostring];	
			if (_remaining < 0) then
            {
                hintSilent "";
            };
		};
	};
}; 