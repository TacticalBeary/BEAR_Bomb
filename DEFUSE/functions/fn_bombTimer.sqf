private ["_bomb", "_time"];
_bomb = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_time = [_this, 1, 0, [0]] call BIS_fnc_param;

//Validate parameters
if (isNull _bomb) exitWith {"Object parameter must not be objNull. Accepted: OBJECT" call BIS_fnc_error};

BEAR_timer = 0 spawn { 
	while {
			(_time > 0)
		&& !(caseBomb getVariable ["DEFUSED", false])
	} do {
		_time = _time - 1;  
		hintSilent format["Bomb Detonation: \n %1", [((_time)/60)+.01,"HH:MM"] call BIS_fnc_timetostring];

		if (_time < 1) then {
			_blast = createVehicle ["Bomb_03_F", position _bomb, [], 0, "NONE"];
			{
				if (_x distance _bomb <= 15) then {_x setDamage 1};
			} forEach allUnits;
			deleteVehicle _bomb;
		};
		if (isServer && (caseBomb getVariable ["ARMED", false])) then {
			_time = 5; 
			caseBomb setVariable ["ARMED", false, true];
		};
		
		sleep 1;
	};
};

//Return Value
_bomb



