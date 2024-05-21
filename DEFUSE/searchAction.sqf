 _host = _this select 0;
 _caller = _this select 1;
 _id = _this select 2;
 
 _host removeAction _id;
 
 _caller playMove "AmovPercMstpSrasWrflDnon_AinvPercMstpSrasWrflDnon_Putdown";
 cutText [format ["Code: %1\n", CODE, 10], "PLAIN DOWN"];
