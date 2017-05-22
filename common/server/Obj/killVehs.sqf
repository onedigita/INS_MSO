_t4=["t4"]call BIS_fnc_taskCompleted;
if(_t4)exitWith{sleep 1;
switch(floor(random 4))do{
case 0:{[]execVM "common\server\Obj\killTow.sqf";};
case 1:{[]execVM "common\server\Obj\killMan.sqf";};
case 2:{[]execVM "common\server\Obj\killAAA.sqf";};
case 3:{[]execVM "common\server\Obj\killVeh.sqf";};
case 4:{[]execVM "common\server\Obj\capIED.sqf";};
};};
objMen=[];
objState=true;
publicVariable "objState";
sleep 3;
_objvPos=[[9000,9000,1],random 2750,2750,1,0,60*(pi/180),0,[]]call BIS_fnc_findSafePos;
switch(true)do{
case(isClass(configFile>>"cfgPatches">>"rhs_t72")):{objTar=[_objvPos,EAST,(configFile>>"CfgGroups">>"East">>"rhs_faction_tv">>"rhs_group_rus_tv_72">>"RHS_T72BAPlatoon")]call BIS_fnc_spawnGroup;};
case(isClass(configFile>>"cfgPatches">>"CUP_TrackedVehicles_Core")):{objTar=[_objvPos,EAST,(configFile>>"CfgGroups">>"East">>"CUP_O_TK">>"Armored">>"CUP_O_TK_T55Platoon")]call BIS_fnc_spawnGroup;};
default{objTar=[_objvPos,EAST,(configFile>>"CfgGroups">>"East">>"OPF_F">>"Armored">>"OIA_TankPlatoon")]call BIS_fnc_spawnGroup;};};
_objTarGrp=units objTar;
publicVariable "objTar";
[objTar]call objSkill;
{if(!isAbleToBreathe _x)then{clearItemCargoGlobal _x;_x lock 3;_x setFuel .5;_x allowCrewInImmobile true;}else{[_x]execVM "eos\fn\randOP4.sqf";_x allowFleeing 0;};}forEach _objTarGrp;
[objTar,_objvPos]call BIS_fnc_taskDefend;
sleep 3;
_random=(round(random 1)+1);
for "_i" from 0 to _random do{
_nObjPos=[_objvPos,random 50,1000,1,0,60*(pi/180),0,[]]call BIS_fnc_findSafePos;
_spawnGroup=[_nObjPos,EAST,(configFile>>"CfgGroups">>"East">>"OPF_F">>"Infantry">>"OIA_InfTeam")]call BIS_fnc_spawnGroup;
[_spawnGroup,_objvPos,500+random 1000]call BIS_fnc_taskPatrol;
objMen=objMen+(units _spawnGroup);
[_spawnGroup]call objSkill;
sleep 1;};

[floor(random 2)]call objST;
_nObjPos=[_objvPos,random 200,200,1,0,60*(pi/180),0,[]]call BIS_fnc_findSafePos;
_spawnGroup=[_nObjPos,EAST,(configFile>>"CfgGroups">>"East">>"OPF_F">>"Infantry">>"OIA_InfTeam")]call BIS_fnc_spawnGroup;
[_spawnGroup,_objvPos]call BIS_fnc_taskDefend;
[_spawnGroup]call objSkill;
objMen=objMen+(units _spawnGroup);
{_x enableSimulationGlobal false;_x hideObjectGlobal true;_x disableAI "ALL";_x setSpeaker "NoVoice";_x setBehaviour "CARELESS";_x unlinkItem "NVGoggles_OPFOR";removeUniform _x;removeHeadgear _x;removeVest _x;removeBackpack _x;removeAllWeapons _x;_x disableConversation true;_x enableMimics false;}forEach objMen-[objTar];
sleep 1;
{[_x]execVM "eos\fn\randOP4.sqf";}forEach objMen;
"objMkr" setMarkerPos(_objvPos);
"objMkr" setMarkerText "";
"objMkr" setMarkerAlpha 0;
"objMkr" setMarkerType "mil_dot";
[west,["t4"],["A hostile tank platoon is contesting an area and must be destroyed.","Destroy Tank Platoon","objMkr"],getMarkerPos "objMkr",true,9,true,"Destroy",true]call BIS_fnc_taskCreate;
["t4","Destroy"]call BIS_fnc_taskSetType;

waitUntil{{!alive _x}forEach units objTar;};
"objMkr" setMarkerPos[0,0,0];
["t4","SUCCEEDED",true]spawn BIS_fnc_taskSetState;
//_rw=selectRandom rw1;
//_newRW=createVehicle[_rw,getMarkerPos "rwMkr",[],8,"CAN_COLLIDE"];_newRW setDir 331;
sleep 300;
//["t4",west]call BIS_fnc_deleteTask;
{deleteVehicle _x}forEach objMen+[objTar];
sleep 1;
objMen=[];
sleep 5;
objState=false;
publicVariable "objState";
switch(floor(random 4))do{
case 0:{[]execVM "common\server\Obj\killTow.sqf";};
case 1:{[]execVM "common\server\Obj\killMan.sqf";};
case 2:{[]execVM "common\server\Obj\killVeh.sqf";};
case 3:{[]execVM "common\server\Obj\killVehs.sqf";};
case 4:{[]execVM "common\server\Obj\capIED.sqf";};
};