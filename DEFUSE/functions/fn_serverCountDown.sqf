private _pos = getPosASL caseBomb;
Bear_timerServerHandler = [{
	params ["_pos"];
	_alive = alive caseBomb;
	_defused = missionNamespace getVariable ["BEAR_defused", false];
	_remaining = (missionNamespace getVariable ["BEAR_timer", 0]) - 1;
	missionNamespace setVariable ["BEAR_timer", _remaining, true];

	if (_defused) then {
		[Bear_timerServerHandler] call CBA_fnc_removePerFrameHandler;
	};

	if (_remaining < 0 && !_alive) then {
		createVehicle ["Bomb_03_F", _pos, [], 0, "NONE"];
	    [{createVehicle ["Bomb_03_F", getMarkerPos "bombExpl_1", [], 0, "NONE"];}, [], 2] call CBA_fnc_waitAndExecute;
		[{bomb_1 setDamage 1;}, [], 5] call CBA_fnc_waitAndExecute;
		[{createVehicle ["Bomb_03_F", getMarkerPos "bombExpl_1", [], 0, "NONE"];}, [], 2] call CBA_fnc_waitAndExecute;
		[{createVehicle ["Bomb_03_F", getMarkerPos "bombExpl_3", [], 0, "NONE"];}, [], 10] call CBA_fnc_waitAndExecute;
		[{createVehicle ["Bomb_03_F", getMarkerPos "bombExpl_4", [], 0, "NONE"];}, [], 12] call CBA_fnc_waitAndExecute;
		[{bomb_2 setDamage 1;}, [], 7] call CBA_fnc_waitAndExecute;
		{if (_x distance _pos <= 15) then {_x setDamage 1};} forEach allUnits;
		deleteVehicle caseBomb;
		deleteVehicle LAPTOP1;
		[Bear_timerServerHandler] call CBA_fnc_removePerFrameHandler;
	};
}, 1, _pos] call CBA_fnc_addPerFrameHandler;