objSkill={_grp=_this select 0;_leader=leader _grp;_leader setSkill random 1;
{_x setSkill["aimingAccuracy",0.3];_x setSkill["aimingShake",0.5];_x setSkill["aimingSpeed",0.6];
_x setSkill["spotDistance",0.7];_x setSkill["spotTime",0.5];_x setSkill["courage",0.7];_x setSkill["commanding",1];}forEach units _grp;};
//rw1=["Box_NATO_Ammo_F","Box_NATO_Equip_F","B_Slingload_01_Fuel_F","B_Slingload_01_Repair_F","B_Slingload_01_Medevac_F","B_Slingload_01_Cargo_F","B_Slingload_01_Ammo_F","B_LSV_01_armed_F"];
objST={
_amount=random 4;_stType="";
for "_i" from 0 to _amount do{
switch(true)do{
case(isClass(configFile>>"cfgPatches">>"rhs_weapons")):{_stType=["rhs_KORD_MSV","rhs_KORD_high_MSV","rhs_SPG9M_MSV","RHS_ZU23_MSV"];_stType=selectRandom _stType;};
case(isClass(configFile>>"cfgPatches">>"CUP_TrackedVehicles_Core")):{_stType=["CUP_O_2b14_82mm_TK_INS","CUP_O_DSHKM_TK_INS","CUP_O_DSHKM_MiniTriPod_TK_INS","CUP_O_AGS_TK_INS","CUP_O_SPG9_TK_INS","CUP_O_ZU23_TK_INS","CUP_O_D30_AT_TK_INS","CUP_O_D30_TK_INS"];_stType=selectRandom _stType;};
default{_stType=["O_HMG_01_high_F","O_GMG_01_high_F","O_static_AT_F","O_static_AA_F"];_stType=selectRandom _stType;};};
_posSt=[_objvPos,200,200,1,0,60*(pi/180),0,[]]call BIS_fnc_findSafePos;
_st=createVehicle[_stType,_posSt,[],0,"CAN_COLLIDE"];_st disableTIEquipment true;_st disableNVGEquipment true;_st lock 3;
_stGrp=createGroup EAST;
_stMan=_stGrp createUnit["O_Survivor_F",getPos _st,[],0,"CAN_COLLIDE"];
_stMan enableSimulationGlobal false;_stMan hideObjectGlobal true;_stMan disableAI "ALL";_stMan setSpeaker "NoVoice";_stMan setBehaviour "CARELESS";
_stMan unlinkItem "NVGoggles_OPFOR";_stMan enableMimics false;
sleep 1;
[_stMan]execVM "eos\fn\randOP4.sqf";
_stMan assignAsGunner _st;[_stMan]orderGetIn true;_stMan moveInTurret[_st,[0]];};
};
if(isNil{missionNamespace getVariable "objState"})then{
switch(floor(random 5))do{
case 0:{null=[]execVM "common\server\Obj\killTow.sqf";};
case 1:{null=[]execVM "common\server\Obj\killVeh.sqf";};
case 2:{null=[]execVM "common\server\Obj\killVehs.sqf";};
case 3:{null=[]execVM "common\server\Obj\killAAA.sqf";};
case 4:{null=[]execVM "common\server\Obj\killMan.sqf";};
case 5:{null=[]execVM "common\server\Obj\capIED.sqf";};
};};