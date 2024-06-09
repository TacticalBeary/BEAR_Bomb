 params ["_target", "_caller", "_id"];
_target removeAction _id;
 
_caller playMove "AmovPercMstpSrasWrflDnon_AinvPercMstpSrasWrflDnon_Putdown";
if ( _target isEqualTo (missionNamespace getVariable ["bear_codeHolder", objNull])) then {
   cutText [format ["Code: %1\n", missionNamespace getVariable ["bear_code", 0], 10], "PLAIN DOWN"];
} else {
   cutText [format ["No code on this device, need to find another one", 10], "PLAIN DOWN"];
}
