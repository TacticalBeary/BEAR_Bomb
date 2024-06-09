/*
 * XEH_postInit.sqf
 * Code below will run afeter mission start, when other inits execute
 * Doc: https://community.bistudio.com/wiki/Arma_3:_Functions_Library#Pre_and_Post_Init
 */

private _laptops = [LAPTOP1, LAPTOP2, LAPTOP3, LAPTOP4];
CODE = [];
CODEINPUT = [];

if (isServer) then {
  private _laptop = (selectRandom _laptops);
  missionNamespace setVariable ["bear_code", [(round(random 9)), (round(random 9)), (round(random 9)), (round(random 9)), (round(random 9)), (round(random 9))], true]; //6 digit code can be more or less
	missionNamespace setVariable ["bear_codeHolder", _laptop, true];

  //Starting Objectives
  [west, "mainObjectives", ["These are the main objectives of the missions.", "Main Objectives", ""], objNull, "CREATED", 1, true] call BIS_fnc_taskCreate;
  [west, ["cbrnObjective_1", "mainObjectives"], ["Find out if any civilians are able to give intel on the location of the CBRN weapons inside Lybor. The town of Mayson Park and Leno are our best bet on gathering intel.", "Gather Intelligence", ""], objNull, "CREATED", 2, true, "search"] call BIS_fnc_taskCreate;
};

{
  _x addAction [
    ("Search for a code"), 
    { 
      params ["_target", "_caller", "_actionId", "_arguments"];
      [_target, _caller, _actionId] execVM "DEFUSE\searchAction.sqf"
    } 
  ];
} forEach _laptops;

caseBombActionID = caseBomb addAction [
  ("Defuse the bomb"), 
  {createDialog "KeypadDefuse";}, 
  "", 
  1.5, 
  true, 
  true, 
  "", 
  "0 call COB_fnc_checkBomb",
  2
];