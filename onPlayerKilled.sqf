player setVariable["Saved_Loadout",getUnitLoadout player];
if(vehicleVarName player in CASarray)then{removeAllActions player;};
if(!isNull objectParent player)then{
{if(_x isKindOf "Land_HelipadEmpty_F")then{detach _x;deleteVehicle _x;};}forEach attachedObjects vehicle player;}else{
{if(_x isKindOf "Land_HelipadEmpty_F")then{detach _x;deleteVehicle _x;};}forEach attachedObjects player;};hintSilent"";