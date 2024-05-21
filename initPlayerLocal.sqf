
call compile preprocessFileLineNumbers "BEAR_Arsenal.sqf";

private _action = [
    "BEAR_arsenalInteraction",
    localize "STR_A3_Arsenal",
    "",
    {
        params ["_target", "_player"];

        [_target, BEAR_my_arsenal_whitelist, false] call ace_arsenal_fnc_initBox;
        [_target, _player] call ace_arsenal_fnc_openBox;

        BEAR_openedArsenal = _target;
    },
    {
        params ["_target", "_player"];

        [_player, _target] call ace_common_fnc_canInteractWith
    }
] call ace_interact_menu_fnc_createAction;
["VirtualReammoBox_camonet_F", 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;

["ace_arsenal_displayClosed", {
    [BEAR_openedArsenal, false] call ace_arsenal_fnc_removeBox;
}] call CBA_fnc_addEventHandler;

player enableStamina false;

execVM "Briefing.sqf";

//Riever 3rdPerson allowance.
//thirdPersonAllowed = false;
/*if (isNil "Riever") then {
	[] spawn {
		while {(true)} do { 
			if (cameraView == "EXTERNAL") then 
			{ 
				if ((vehicle player) == player) then 
				{ 
					//hintSilent "Hey Cheater!";
					player switchCamera "INTERNAL"; 
				}; 
			}; 
			sleep 0.5; 
		}; 
	};
} else {
	[] spawn {
			while {(player != Riever)} do { 
				if (cameraView == "EXTERNAL") then 
				{ 
					if ((vehicle player) == player) then 
					{ 
						//hintSilent "Hey Cheater!";
						player switchCamera "INTERNAL"; 
					}; 
				}; 
				sleep 0.5; 
			}; 
		};
};