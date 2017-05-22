//Headless Client Auto-Detection and Initialization by VCRPlayer
_1stnum = diag_tickTime;
if (!isServer && !hasInterface) then {
waitUntil {!isNull player};
if (HCIDList == null) then {
	HCIDList = [];
	HCIDList pushBack player;
	publicVariable "HCIDList";
}
else { HCIDList pushBack player;
publicVariable "HCIDList";
}; };
execVM "headless\newUnitCheck.sqf";
execVM "headless\headlessClientDisconnect.sqf";
_finaltime = diag_tickTime - _1stnum;
if (HCDebug == 1 ) then {
hintSilent format ["Headless-Init Completed. \ntook %1 seconds", _finaltime];
};