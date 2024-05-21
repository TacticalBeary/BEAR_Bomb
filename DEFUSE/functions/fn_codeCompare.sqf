//Parameters
private ["_code", "_inputCode"];
_code      = [_this, 0, [], [[]]] call BIS_fnc_param;
_inputCode = [_this, 1, [], [[]]] call BIS_fnc_param;

//compare codes
private "_compare";
_compare = [_code, _inputCode] call BIS_fnc_areEqual;

if (isServer && (_compare)) then {
    cutText ["BOMB DEFUSED", "PLAIN DOWN"];
    caseBomb setVariable ["BEAR_DEFUSED", true, true];
    ["Task_Defuse", "Succeeded"] call BIS_fnc_taskSetState;
    casebomb removeAction caseBombActionID;
} else {
    cutText ["BOMB ARMED", "PLAIN DOWN"];
    // caseBomb setVariable ["BEAR_ARMED", true, true]; // not sure we need this var
    caseBomb setVariable ["BEAR_timer", serverTime + 5, true];
    playSound "button_wrong";
    casebomb removeAction caseBombActionID;
};

CODEINPUT = [];

//Return Value
_code