#define SAFEZONES [["safeMkr",30.8],["respawn_west",34]]
if(isDedicated)exitWith{};
waitUntil{!isNull player};
player addEventHandler["Fired",{if((_this select 2 isKindOf["Rifle",configFile>>"CfgWeapons"])||(_this select 2 isKindOf["Pistol",configFile>>"CfgWeapons"])||(_this select 2 isKindOf["LauncherCore",configFile>>"CfgWeapons"])||(_this select 2 isKindOf["MGun",configFile>>"CfgWeapons"])||(_this select 2 isKindOf["CannonCore",configFile>>"CfgWeapons"])||(_this select 2=="HandGrenadeMuzzle"))then{
if({(_this select 0)distance getMarkerPos(_x select 0)<_x select 1}count SAFEZONES>0)then{
deleteVehicle(_this select 6);};};}];