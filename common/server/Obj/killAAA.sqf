_t5=["t5"]call BIS_fnc_taskCompleted;
if(_t5)exitWith{sleep 1;
switch(floor(random 4))do{
case 0:{[]execVM "common\server\Obj\killTow.sqf";};
case 1:{[]execVM "common\server\Obj\killMan.sqf";};
case 2:{[]execVM "common\server\Obj\killVeh.sqf";};
case 3:{[]execVM "common\server\Obj\killVehs.sqf";};
case 4:{[]execVM "common\server\Obj\capIED.sqf";};
};};
objMen=[];
objState=true;
publicVariable "objState";
sleep 3;
_objvPos=[[6218,6282,1],random 2750,2750,1,0,60*(pi/180),0,[]]call BIS_fnc_findSafePos;
switch(true)do{
case(isClass(configFile>>"cfgPatches">>"rhsusf_vehicles")):{objTar=createVehicle["rhs_gaz66_zu23_vdv",_objvPos,[],0,"CAN_COLLIDE"];};
case(isClass(configFile>>"cfgPatches">>"CUP_TrackedVehicles_Core")):{objTar=createVehicle["CUP_O_Ural_ZU23_TKM",_objvPos,[],0,"CAN_COLLIDE"];};
default{objTar=createVehicle["O_APC_Tracked_02_AA_F",_objvPos,[],0,"CAN_COLLIDE"];};};
sleep 1;
_objTar=createVehicleCrew objTar;_objTar=fullCrew objTar;clearItemCargoGlobal objTar;objTar lock 3;objTar setFuel .5;

publicVariable "objTar";
//[_objTar]call objSkill;
{[_x]execVM "eos\fn\randOP4.sqf";}forEach crew objTar;
sleep 3;
_random=(round(random 2)+1);
for "_i" from 0 to _random do{
_nObjPos=[_objvPos,random 200,200,1,0,60*(pi/180),0,[]]call BIS_fnc_findSafePos;
_spawnGroup=[_nObjPos,EAST,(configFile>>"CfgGroups">>"East">>"OPF_F">>"Infantry">>"OIA_InfTeam")]call BIS_fnc_spawnGroup;
[_spawnGroup,_objvPos,500+random 1000]call BIS_fnc_taskPatrol;
objMen=objMen+(units _spawnGroup);
[_spawnGroup]call objSkill;
sleep 1;};

[floor(random 4)]call objST;
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
[west,["t5"],["Insurgent-manned anti-aircraft vehicles are threatening our airspace.  Neutralize the AA threat.","Neutralize AA","objMkr"],getMarkerPos "objMkr",true,9,true,"Destroy",true]call BIS_fnc_taskCreate;
["t5","Destroy"]call BIS_fnc_taskSetType;

waitUntil{{!alive _x}forEach crew objTar;};
"objMkr" setMarkerPos[0,0,0];
["t5","SUCCEEDED",true]spawn BIS_fnc_taskSetState;
//_rw=selectRandom rw1;
//_newRW=createVehicle[_rw,getMarkerPos "rwMkr",[],8,"CAN_COLLIDE"];_newRW setDir 331;
sleep 300;
//["t5",west]call BIS_fnc_deleteTask;
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