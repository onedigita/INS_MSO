/*Creates empty vehicles at set positions and some can have IEDs
V1.8.4- By: Ghost ~ Modified by Phronk
vbIEDs=[_locselpos,_rad,_maxcars,_ieds,_showmarks,_side]execVM "common\server\vbIEDs.sqf";
vbIEDs=[(getMarkerPos "center"),350,14,true,false,WEST]execVM "common\server\vbIEDs.sqf";
*/
if(!isServer)exitWith{};
_centerPosition=_this select 0;//position
_rad=_this select 1;//radius for vehicles to spawn
_maxCars=_this select 2;//max number of cars
_ieds=_this select 3;//true = random vbIEDs | false = no vbIEDs
_showMarks=_this select 4;//show vbIED markers
_side=_this select 5;//side for mines to be known

_vehCivList=[];
switch(true)do{
case(isCUPV):{_vehCivList=["CUP_C_Datsun_Tubeframe","CUP_C_Datsun","CUP_C_Datsun_Plain","CUP_C_Datsun_Covered","CUP_C_Datsun_4seat","CUP_C_Skoda_White_CIV","CUP_C_Skoda_Blue_CIV","CUP_C_Skoda_Red_CIV","CUP_C_Skoda_Green_CIV","CUP_C_UAZ_Unarmed_TK_CIV","CUP_C_LR_Transport_CTK","CUP_C_Ural_Civ_01","CUP_C_Ural_Open_Civ_01"];};
case(isRHSRF):{_vehCivList=["RHS_Ural_Open_Civ_01","RHS_Ural_Civ_01","RHS_Ural_Open_Civ_02","RHS_Ural_Civ_02","RHS_Ural_Open_Civ_03","RHS_Ural_Civ_03","C_Offroad_02_unarmed_F","C_Hatchback_01_F","C_SUV_01_F"];};
default{_vehCivList=["C_Offroad_01_F","C_Offroad_01_repair_F","C_Offroad_02_unarmed_F","C_Hatchback_01_F","C_SUV_01_F","C_Van_01_transport_F","C_Van_01_box_F","C_Van_01_fuel_F","C_Truck_02_fuel_F","C_Truck_02_covered_F","C_Truck_02_box_F","C_Truck_02_transport_F","C_Quadbike_01_F"];};};
_iedList=["Bo_Mk82","Bo_GBU12_LGB"];

//Get array of roads in area
_roads=(_centerPosition nearRoads _rad);
_cars=floor(count _roads/10);
if(_cars>_maxCars)then{_cars=_maxCars;};

private["_direction"];
for "_x" from 0 to(_cars)do{
_roadsSel=selectRandom _roads;
_roadConto=roadsConnectedTo _roadsSel;
_direction=[_roadsSel,_roadConto select 0]call BIS_fnc_DirTo;
_roads=_roads-[_roadsSel];
_pos=[(getPosATL _roadsSel select 0)-5*sin(random 359),(getPosATL _roadsSel select 1)-5*cos(random 359)]; 
_vehCivSel=selectRandom _vehCivList;
_veh=createVehicle[_vehCivSel,_pos,[],0,"NONE"];
clearItemCargoGlobal _veh;_veh setFuel(0.2+random 0.5);_veh lock 3;
if(isNil "_direction")then{
_veh setDir(random 360);}else{_veh setDir _direction;};
_veh setPosATL[getPosATL _veh select 0,getPosATL _veh select 1,0];
_veh setVelocity[0,0,0];

//create ied
if(_ieds and(round(random 10)==2))then{

//create loop to detect side and blow up
[_veh,_iedList,_side]spawn{
_iedVeh=_this select 0;
_iedList=_this select 1;
_side=_this select 2;
_iedSel=selectRandom _iedList;

while{!(isNil "_iedVeh")or(alive _iedVeh)}do{
sleep 4;
if(damage _iedVeh>0.5)exitWith{};
_near=(getPos _iedVeh)nearObjects["Man",13];
{if(side _x==_side)then{
createVehicle[_iedSel,(getPos _iedVeh),[],0,""];_iedVeh setDamage 1;};}forEach _near;};
};};
sleep 1;};