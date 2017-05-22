_t0=["t0"]call BIS_fnc_taskCompleted;
if(_t0)exitWith{sleep 1;
switch(floor(random 4))do{
case 0:{[]execVM "common\server\Obj\killAAA.sqf";};
case 1:{[]execVM "common\server\Obj\killMan.sqf";};
case 2:{[]execVM "common\server\Obj\killVeh.sqf";};
case 3:{[]execVM "common\server\Obj\killVehs.sqf";};
case 4:{[]execVM "common\server\Obj\capIED.sqf";};
};};
objMen=[];
objState=true;
publicVariable "objState";
sleep 3;
_objvPos=[[6218,6282,1],random 1000,3500,1,0,60*(pi/180),0,[]]call BIS_fnc_findSafePos;
objTar=createVehicle["Land_Vysilac_FM",_objvPos,[],0,"CAN_COLLIDE"];
publicVariable "objTar";
clearMagazineCargoGlobal objTar;
objMen=objMen+[objTar];
objTar setDir random 360;

_random=(round(random 2)+1);
for "_i" from 0 to _random do{
_nObjPos=[_objvPos,random 50,300,1,0,60*(pi/180),0,[]]call BIS_fnc_findSafePos;
_spawnGroup=[_nObjPos,EAST,(configFile>>"CfgGroups">>"East">>"OPF_F">>"Infantry">>"OIA_InfTeam")]call BIS_fnc_spawnGroup;
[_spawnGroup,getPos objTar,100+random 300]call BIS_fnc_taskPatrol;
objMen=objMen+(units _spawnGroup);
[_spawnGroup]call objSkill;
sleep 1;};

[round(random 2)+1]call objST;
_nObjPos=[_objvPos,random 10,50,1,0,60*(pi/180),0,[]]call BIS_fnc_findSafePos;
_spawnGroup=[_nObjPos,EAST,(configFile>>"CfgGroups">>"East">>"OPF_F">>"Infantry">>"OIA_InfTeam")]call BIS_fnc_spawnGroup;
[_spawnGroup,getPos objTar]call BIS_fnc_taskDefend;
[_spawnGroup]call objSkill;
objMen=objMen+(units _spawnGroup);
{_x enableSimulationGlobal false;_x hideObjectGlobal true;_x disableAI "ALL";_x setSpeaker "NoVoice";_x setBehaviour "CARELESS";_x disableConversation true;_x unlinkItem "NVGoggles_OPFOR";removeUniform _x;removeHeadgear _x;removeVest _x;removeBackpack _x;removeAllWeapons _x;_x enableMimics false;_x addEventHandler["HandleDamage",{_damage=(_this select 2)*1.7;_damage}];}forEach objMen-[objTar];
sleep 1;
{[_x]execVM "eos\fn\randOP4.sqf";}forEach objMen-[objTar];
"objMkr" setMarkerPos(getPos objTar);
"objMkr" setMarkerText "";
"objMkr" setMarkerColor "ColorWhite";
"objMkr" setMarkerAlpha 0;
"objMkr" setMarkerType "loc_Transmitter";
[west,["t0"],["Intel reports the Taliban have setup their own communications tower and are operating around it.  Destroying the tower will disturb their operations in Takistan.","Destroy Tower","objMkr"],getMarkerPos "objMkr",true,9,true,"Destroy",true]call BIS_fnc_taskCreate;
["t0","Destroy"]call BIS_fnc_taskSetType;

waitUntil{!alive objTar};
"objMkr" setMarkerPos[0,0,0];
"objMkr" setMarkerText "";
"objMkr" setMarkerAlpha 0;
["t0","SUCCEEDED",true]spawn BIS_fnc_taskSetState;
//_rw=selectRandom rw1;
//_newRW=createVehicle[_rw,getMarkerPos "rwMkr",[],8,"CAN_COLLIDE"];_newRW setDir 331;
sleep 300;
//["t0",west]call BIS_fnc_deleteTask;
{deleteVehicle _x}forEach objMen;
sleep 1;
objMen=[];
sleep 4;
objState=false;
publicVariable "objState";
sleep 4;
switch(floor(random 4))do{
case 0:{[]execVM "common\server\Obj\killMan.sqf";};
case 1:{[]execVM "common\server\Obj\killVeh.sqf";};
case 2:{[]execVM "common\server\Obj\killVehs.sqf";};
case 3:{[]execVM "common\server\Obj\killAAA.sqf";};
case 4:{[]execVM "common\server\Obj\capIED.sqf";};
};