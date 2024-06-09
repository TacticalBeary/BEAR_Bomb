/*
 * XEH_preInit.sqf
 * Code below will run on server and on each player before loading mission objects
 */

["mission_bombDefusal", {
  if (isServer) then {
    missionNamespace setVariable ["BEAR_timer", 300, true];
    [ west, ["Task_Defuse"], ["Find the code and defuse the bomb before it explodes.", "Defuse the bomb", "DEFUSE"], objNull, FALSE ] call BIS_fnc_taskCreate;  
    [ west, ["Task_Secure"], ["Secure the SCUD launcher and bring it back to FOB Sentinel Ridge for proper disposal", "Secure CBRN SCUD Vehicle", "SECURE"], objNull, FALSE ] call BIS_fnc_taskCreate;
    0 spawn COB_fnc_serverCountDown;
  };

  if (hasInterface) then {
    private _remaining = 1;
    Bear_timerHandler = [{
      params ["_remaining"];
      _remaining = (missionNamespace getVariable ["BEAR_timer", 0]);
      if ((_remaining >= 0) && {!(missionNamespace getVariable ["BEAR_DEFUSED", false])}) then {
        hintSilent format["Bomb Detonation: \n %1", [(_remaining/60), "HH:MM"] call BIS_fnc_timetostring];	
      } else {
        hintSilent "";
        [Bear_timerHandler] call CBA_fnc_removePerFrameHandler;
      }
    }, 1, _remaining] call CBA_fnc_addPerFrameHandler;
  };
}] call CBA_fnc_addEventHandler;
