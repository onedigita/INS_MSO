//Checking for new Spawned units by VCRPlayer
["NewUnitCheck","onEachFrame", {
	{
		if (_x getVariable "UnitCheck") then {}
		else { execVM "headless\addUnitsToHC.sqf" };
		if (HCDebug == 1) then {
		hintSilent "Units not under HC have been found. \nThey are being added.";
		};
	} forEach allGroups;
}] call BIS_fnc_addStackedEventHandler;