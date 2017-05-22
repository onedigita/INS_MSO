//HOLSTER WEAPON:	TO DO: Change keybind to an inputAction
CRS_Holster={if(!alive player)exitWith{};
if((primaryWeapon player!="")||{(handgunWeapon player!="")})then{player action["switchWeapon",player,player,-1];};};
CRS_HolsterInit={waitUntil{!(isNull(findDisplay 46))};
CRS_HolsterEH=(findDisplay 46)displayAddEventHandler["KeyDown","if(_this select 1==35)then{[player]call CRS_Holster}"];};