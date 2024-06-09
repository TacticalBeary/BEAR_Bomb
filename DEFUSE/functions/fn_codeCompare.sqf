params ["_inputCode"];
private _code = missionNamespace getVariable ["bear_code", [0, 0, 0, 0, 0, 0]];

if (_code isEqualTo _inputCode) then {
    cutText ["BOMB DEFUSED", "PLAIN DOWN"];
    missionNamespace setVariable ["BEAR_DEFUSED", true, true];
    ["Task_Defuse", "Succeeded"] call BIS_fnc_taskSetState;
} else {
    cutText ["BOMB ARMED", "PLAIN DOWN"];
    missionNamespace setVariable ["BEAR_timer", 5, true];
    playSound "button_wrong";
    [{deleteVehicle caseBomb}, [], 5] call CBA_fnc_waitAndExecute;
};

_code