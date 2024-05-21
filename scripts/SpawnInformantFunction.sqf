params["_informantClass", "_position", "_zRotation"];

//Spawn Informant.
_grp = createGroup civilian;
_informantUnit = _informantClass createUnit [_position, _grp];
[_informantUnit, [_zRotation,0,0]] call BIS_fnc_setObjectRotation;

//Setup AI.
_informantUnit disableAI 'all';   
_informantUnit enableAI 'ANIM'; 

//Animate?
if (_animationName != "") then [{[_informantUnit, _animationName, "NONE"] call BIS_fnc_ambientAnim;}];

_informantUnit addEventHandler ['Killed', {  
 params ['_unit', '_killer'];  
  removeAllActions _unit;
 }];

// _text;

//Return.
_informantUnit; 