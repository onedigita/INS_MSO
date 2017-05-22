//Code that adds units to Headless Client by VCRPlayer
//Checking if Object is in ANY HC before adding it
_1sttime = diag_tickTime;
_objectadd = [];
{	
	_whatunit = _x;
	{
		if ( _whatunit in units group _x ) then {
			_hcinunitgroup = true;
		};
	} forEach HCIDList;
	if !( _hcinunitgroup ) then {
		_objectadd pushBack _x;
	};
} forEach allGroups;
_hcselect = 0;
{ //Actually adding units to HCS, and round robin-ing between different HCs
	if (HCIDList select _hcselect) == null ) then { _hcselect = 0; };
	_x setGroupOwner (HCIDList select _hcselect);
	_hcselect = _hcselect + 1;
	_x setVariable ["UnitCheck",true,true];
}; forEach _objectadd;
_finalcount = count _objectadd;
_finaltime = diag_tickTime - _1sttime;
if (HCDebug == 1) then {
hintSilent format ["New Units have been added to HC. \n%1 units added. Took %2 seconds", _finalcount, _finaltime];
};