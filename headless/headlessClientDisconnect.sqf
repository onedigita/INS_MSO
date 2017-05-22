//Headless Client Disconnect Handler by VCRPlayer
["hcDisconnect","onPlayerDisconnected", {
	_headlessdc = false;
	{
		if (_x == _id) then {
			 _headlessdc = true;
			 _newHCIDList = [];
			 if (HCDebug == 1) then {
			 hintSilent format ["Headless Client Disconnected! ID %1", _x];
			 };
			 };
	} forEach HCIDList;
	if (_headlessdc) then {
		{ _hcselection = 0;
			if ( _x != objNull ) then {
				_x = _newHCIDList select _hcselection;
				_hcselection = _hcselection + 1;
			};
		} forEach HCIDList;
		publicVariable "HCIDList";
	};
}] call BIS_fnc_addStackedEventHandler;
		