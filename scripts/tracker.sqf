bearTracker = 0 spawn { 
    _trackDevice = ["ChemicalDetector_01_watch_F", "ACE_Cellphone"];
    while {true} do { 
        _items = items player;
        if ( _trackDevice findIf { _x in _items } > -1 ) then {
            _pPlayer = getPosASL player; 
            _pTarget = getPosASL caseBomb; 
            _offset = vectorMagnitude ( 
                _pPlayer vectorFromTo _pTarget 
            ) / 20; 
            playSound3D [ 
                "a3\sounds_f\sfx\Beep_Target.wss",  
                player,  
                false,  
                _pPlayer,  
                0.5 + _offset,  
                0.8 + _offset,  
                0 
            ]; 
            sleep (( 
                sqrt (_pPlayer vectorDistance _pTarget) / 5 - _offset 
            ) max 0.05); 
        } else { 
            sleep 1; 
        };   
    }; 
}; 