enableSaving[false,false];
if(isClass(configFile>>"CfgPatches">>"TPW_MODS"))then{endMission "END2";};
if(isClass(configFile>>"CfgPatches">>"task_force_radio"))then{isTFAR=true;}else{isTFAR=false;};
if(isClass(configFile>>"CfgPatches">>"acre_main"))then{isACRE=true;}else{isACRE=false;};
if(isClass(configFile>>"cfgPatches">>"ace_common"))then{isACE=true;}else{isACE=false;};
if(isClass(configFile>>"cfgPatches">>"Taliban_fighters"))then{isTalib=true;}else{isTalib=false;};
if(isClass(configFile>>"cfgPatches">>"CUP_Weapons_WeaponsCore"))then{isCUPW=true;}else{isCUPW=false;};
if(isClass(configFile>>"cfgPatches">>"CUP_Creatures_People_Core"))then{isCUPU=true;}else{isCUPU=false;};
if((isClass(configFile>>"cfgPatches">>"CUP_WheeledVehicles_Core"))&&{(isClass(configFile>>"cfgPatches">>"CUP_BaseConfigs"))})then{isCUPV=true;}else{isCUPV=false;};
if(isClass(configFile>>"cfgPatches">>"SFG_Tac_Beard"))then{isBeard=true;}else{isBeard=false;};
if(isClass(configFile>>"cfgPatches">>"rhs_t72"))then{isRHSRF=true;}else{isRHSRF=false;};
if(isClass(configFile>>"cfgPatches">>"rhsusf_vehicles"))then{isRHSUS=true;}else{isRHSUS=false;};
if(isServer)then{
if((!isTFAR)&&{(!isACRE)&&(paramsArray select 10==1)})then{
r_WS=getNumber(configFile>>"CfgWorlds">>worldName>>"mapSize");
publicVariable "r_WS";isAFAR=1;publicVariable "isAFAR";};};
#include "core\modules\cacheScript\fn\fn.sqf"
#include "core\modules\cacheScript\fn\cacheFn.sqf"
#include "core\modules\cacheScript\fn\KRON_Str.sqf"
#include "eos\fn\fn.sqf"
call compile preprocessFileLineNumbers "common\server\civ\traffic.sqf";
call compile preprocessFileLineNumbers "common\server\civ\dbugT.sqf";
call compile preprocessFileLineNumbers "common\server\civ\dbugC.sqf";
civs_SIDE=civilian;
civs_MINSKILL=0;
civs_MAXSKILL=0;
civs_MAXWAITINGTIME=300;
civs_RUNNINGCHANCE=0.05;
civs_BEHAVIOURS=[["CITIZEN",100]];
civs_INSTANCE_NO=0;
civTraffic_instanceIndex=-1;
civTraffic_areaMarkerNames=[];
civTraffic_roadSegments=[];
civTraffic_edgeTopLeftRoads=[];
civTraffic_edgeTopRightRoads=[];
civTraffic_edgeBottomRightRoads=[];
civTraffic_edgeBottomLeftRoads=[];
civTraffic_edgeRoadsUseful=[];
#ifndef execNow
#define execNow call compile preprocessFileLineNumbers
#endif
execNow "core\init.sqf";
ia_say=compileFinal "_this select 0 say3D(_this select 1);";
if(isServer)then{
null=[]execVM "eos\openMe.sqf";
call compile preprocessFileLineNumbers "common\server\civ\serverFN.sqf";call compile preprocessFileLineNumbers "common\server\civ\cCFG.sqf";
call compile preprocessFileLineNumbers "common\server\civ\fn.sqf";call compile preprocessFileLineNumbers "common\server\civ\tCFG.sqf";};
null=[]execVM "common\server\ied.sqf";
vIED1=[(getMarkerPos "NW"),2000,15,true,false,WEST]execVM "common\server\vIED.sqf";
vIED2=[(getMarkerPos "NE"),2000,15,true,false,WEST]execVM "common\server\vIED.sqf";
vIED3=[(getMarkerPos "SW"),2000,15,true,false,WEST]execVM "common\server\vIED.sqf";
vIED4=[(getMarkerPos "SE"),2000,15,true,false,WEST]execVM "common\server\vIED.sqf";
execVM "common\client\CAS\initCAS.sqf";
if(paramsArray select 3==1)then{0=[12,1000,300]execVM "common\server\civ\tpw_animals.sqf";};
null=[]execVM "common\server\veh.sqf";
execVM "common\server\safeZ.sqf";
execVM "common\server\ctp\ctp.sqf";
null=[[AIRBASE],WEST,true,75,false]execVM "common\client\BRS\BRS_launch.sqf";
player addMPEventHandler["MPKilled",{_me=_this select 0;_tk=_this select 1;
if((isPlayer _tk)&&{(_me!=_tk)})then{
diag_log format["%1 was teamkilled by %2... Killer's UID is: %3",name _me,name _killer,getPlayerUID _killer];};}];
null=[]execVM"common\server\gc.sqf";
[west,["vaTsk","blTsk"],["Enter the American warehouse and access the Virtual Arsenal via the weapon racks to customize your loadout.","Gear Up!","GearMkr"],GearBox,false,4,false,"Rifle",true]call BIS_fnc_taskCreate;
[west,["wvTsk","blTsk"],["Wheeled Vehicles located in the motor pool","Motorized Vehicles","MRAPmkr"],[8217.231,2099.559,0],false,4,false,"Truck",true]call BIS_fnc_taskCreate;
[west,["hTsk","blTsk"],["Transport helicopters located on the far side of the base, at the base of the mountain.","Rotory Wing Vehicles","helMkr"],[8215.742,1788.51,0],false,4,false,"Heli",true]call BIS_fnc_taskCreate;
[west,["jTsk","blTsk"],["Close-Air-Support fixed wing aircraft located under green hangar tents along runway.","Close-Air-Support","fxwMkr"],[8195.889,1961.423,0],false,4,false,"Plane",true]call BIS_fnc_taskCreate;
[west,["armTsk","blTsk"],["Light and heavy armored vehicles located South-West of tan hangars in base.","Armored Vehicles","armMkr"],[8098.501,2026.358,0],false,4,false,"Armor",true]call BIS_fnc_taskCreate;
[west,["rTsk","blTsk"],["Maintenance Area: Refuel, rearm, and repair vehicle on the medical helipad on the runway.","Vehicle Maintenance","rearmMkr"],[8211.026,2031.173,0],false,4,false,"Repair",true]call BIS_fnc_taskCreate;
[west,["blTsk"],["Points of interest in base, marked on your map.","Base Layout",""],objNull,false,4,false,"",true]call BIS_fnc_taskCreate;
null=[]execVM "common\server\Obj\init.sqf";
if(!isACE)then{
	#include "common\client\CRS\CRS_fn.sqf";null=[]execVM "common\client\CRS\CRS.sqf";
	inCap=compile preprocessFileLineNumbers "common\server\ai\inCap.sqf";_null=[false,true,true,70,0]execVM "common\server\ai\wound.sqf";
	null=[]execVM "common\client\repair.sqf";null=[]execVM "common\client\fastRope.sqf";
	null=[]execVM "common\client\strobe\strobe.sqf";
	if(!isServer&&isNull player)then{isJIP=true;}else{isJIP=false;};
	if(!isDedicated)then{waitUntil{!isNull player && isPlayer player};};
};

if(!isDedicated && hasInterface)then{
	waitUntil{time>1};
	execNow "intro.sqf";
};
call compile preprocessFile "tickets\init.sqf";
execVM "headless\HCInit.sqf"; HCDebug = 0;