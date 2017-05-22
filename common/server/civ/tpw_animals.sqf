/*TPW ANIMALS - Spawn ambient animals around player.
Author: tpw
Date: 20140630
Version: 1.33
Requires: CBA A3, tpw_core.sqf
Compatibility: SP, MP client

Disclaimer: Feel free to use and modify this code, on the proviso that you post back changes and improvements so that everyone can benefit from them, and acknowledge the original author (tpw) in any derivative works.

To use:
0=[15,200,75,60]execVM "tpw_animals.sqf";  >>  15=max animals near player, 200=animals will be removed beyond this distance, 75=min distance from player to spawn an animal
*/
//if(isDedicated)exitWith{};
if(_this select 1==0)exitWith{};
waitUntil{!isNull FindDisplay 46};

//READ IN CONFIGURATION VALUES
tpw_animal_version="1.33";//Version string
tpw_animal_max=_this select 0;//max animals near player
tpw_animal_maxRadius=_this select 1;//distance beyond which animals will be removed
tpw_animal_minRadius=_this select 2;//min distance from player to spawn animals

//DEFAULT VALUES FOR MP
if(isMultiplayer)then{
tpw_animal_max=12;
tpw_animal_maxRadius=1000;
tpw_animal_minRadius=300;};

//VARIABLES
tpw_animal_array=[];
tpw_animal_exclude=false;//player near exlusion object
tpw_animal_active=true;//global activate/deactivate

tpw_animals=//array of animals and their min / max flock sizes
[["Hen_random_F",2,4,"(1 - meadow) * (1 + houses) * (1 - forest) * (1 + trees) * (1 - sea) * (1 - hills)"],//chicken
["Hen_random_F",2,4,"(1 - meadow) * (1 + houses) * (1 - forest) * (1 + trees) * (1 - sea) * (1 - hills)"],
["Sheep_random_F",3,6,"(1 + meadow) * (1 - houses) * (1 - forest) * (1 + trees) * (1 - sea) * (1 - hills)"],//sheep
["Sheep_random_F",3,6,"(1 + meadow) * (1 - houses) * (1 - forest) * (1 + trees) * (1 - sea) * (1 - hills)"],
["Goat_random_F",3,6,"(1 + meadow) * (1 + houses) * (1 + forest) * (1 + trees) * (1 - sea) * (1 + hills)"],//goat
["Goat_random_F",3,6,"(1 + meadow) * (1 + houses) * (1 + forest) * (1 + trees) * (1 - sea) * (1 + hills)"],
["Alsatian_random_F",1,2,"(1 - meadow) * (1 + houses) * (1 - forest) * (1 - trees) * (1 - sea) * (1 - hills)"],//alsation
["Fin_random_F",1,2,"(1 - meadow) * (1 + houses) * (1 - forest) * (1 - trees) * (1 - sea) * (1 - hills)"]];//mutt

//DELAY
sleep 10;

//CONDITIONS FOR SPAWNING A NEW ANIMAL
tpw_animal_fnc_nearAnimal={
private["_owner","_spawnFlag","_deadPlayer","_animalArray","_animal","_exc","_i"];
_spawnFlag=true;//only spawn animal if this is true

//Check if any players have been killed and disown their animals - MP
if(isMultiplayer)then{
	{if((isPlayer _x)&& !(alive _x))then{
	_deadPlayer=_x;
	_animalArray=_x getVariable["tpw_animalArray"];
	for "_i" from 0 to(count _animalArray-1)do{
	_animal setVariable["tpw_animal_owner",(_animal getVariable "tpw_animal_owner")-[_deadPlayer],true];};};}forEach allUnits;

//Any nearby animals owned by other players - MP
_nearAnimals=(position player)nearEntities[["Fowl_Base_F","Dog_Base_F","Goat_Base_F","Sheep_Random_F"],tpw_animal_maxRadius]; 
for "_i" from 0 to(count _nearAnimals - 1)do{
_animal=_nearAnimals select _i;
_owner=_animal getVariable["tpw_animal_owner",[]];

//Animals with owners who are not this player
if((count _owner>0)&& !(player in _owner))exitwith{
_spawnFlag=false;
_owner set[count _owner,player];//add player as another owner of this animal
_animal setVariable["tpw_animal_owner",_owner,true];//update ownership
tpw_animal_array set[count tpw_animal_array,_animal];};};};//add this animal to array of animals for this player

//Refresh array of exclusion objects
tpw_animal_excArray=[];
tpw_animal_exclude=false;	
if !(isNil "tpwAnimExc")then{tpw_animal_excArray set[count tpw_animal_excArray,tpwAnimExc]};
if !(isNil "tpwAnimExc_1")then{tpw_animal_excArray set[count tpw_animal_excArray,tpwAnimExc_1]};	
if !(isNil "tpwAnimExc_2")then{tpw_animal_excArray set[count tpw_animal_excArray,tpwAnimExc_2]};
if !(isNil "tpwAnimExc_3")then{tpw_animal_excArray set[count tpw_animal_excArray,tpwAnimExc_3]};
if !(isNil "tpwAnimExc_4")then{tpw_animal_excArray set[count tpw_animal_excArray,tpwAnimExc_4]};
if !(isNil "tpwAnimExc_5")then{tpw_animal_excArray set[count tpw_animal_excArray,tpwAnimExc_5]};
if !(isNil "tpwAnimExc_6")then{tpw_animal_excArray set[count tpw_animal_excArray,tpwAnimExc_6]};
if !(isNil "tpwAnimExc_7")then{tpw_animal_excArray set[count tpw_animal_excArray,tpwAnimExc_7]};
if !(isNil "tpwAnimExc_8")then{tpw_animal_excArray set[count tpw_animal_excArray,tpwAnimExc_8]};
if !(isNil "tpwAnimExc_9")then{tpw_animal_excArray set[count tpw_animal_excArray,tpwAnimExc_9]};	

//If player near exclusion object then spawn no animals
for "_i" from 0 to(count tpw_animal_excArray-1)do{
_exc=tpw_animal_excArray select _i;
if(_exc distance vehicle player < tpw_animal_maxRadius)exitWith{_spawnFlag=false;tpw_animal_exclude=true;};}forEach tpw_animal_excArray;	

//Otherwise, spawn a new animal
if(_spawnFlag)then{[]spawn tpw_animal_fnc_spawn;};};

//SPAWN ANIMALS INTO APPROPRIATE SPOTS
tpw_animal_fnc_spawn={
private["_group","_pos","_dir","_posx","_posy","_randPos","_type","_animal","_typeArray","_type","_flock","_minFlock","_maxFlock","_diff","_i","_exp","_placeArray","_place"];
_typeArray=tpw_animals select(floor(random(count tpw_animals)));//select animal/flocksize
_type=_typeArray select 0;//animal type
_minFlock=_typeArray select 1;//min flock size
_maxFlock=_typeArray select 2;//max flock size
_exp=_typeArray select 3;//expression for selecting best places
_diff=round(random(_maxFlock-_minFlock));//how many animals more than minimum flock size
_flock=_minFlock+_diff;//flock size
_pos=getPosASL player;
_placeArray=selectBestPlaces[_pos,tpw_animal_maxRadius,_exp,50,5];
_place=_placeArray select(floor(random(count _placeArray)));
_randPos=_place select 0;
if(!(isNil "_randPos")&& _randPos distance player>tpw_animal_minRadius)then{
//Spawn flock
for "_i" from 1 to _flock do{
sleep random 3;
_animal=createAgent[_type,_randPos,[],0,"NONE"];
_animal setDir random 360;
_animal setBehaviour "CARELESS";
_animal setVariable["tpw_animal_owner",[player],true];//mark it as owned by this player
tpw_animal_array set[count tpw_animal_array,_animal];//add to player's animal array
player setVariable["tpw_animalArray",tpw_animal_array,true];};};};//broadcast it

//DISPERSE
tpw_animal_disperse={
private["_obj","_animal","_aDir","_pDir","_dir","_pos","_posx","_posy"];
_obj=_this select 0;
_animal=_this select 1;
if(_animal getVariable["tpw_animal_disperse",0]==0)then{
sleep random 2;
_animal setVariable["tpw_animal_disperse",1];
_aDir=[_obj,_animal]call bis_fnc_dirTo;
_pDir=direction _obj;
_dir=0;
if(_aDir<_pDir)then{_dir=_pDir-45-random 20;}else{_dir=_pDir+45+random 20;};
_animal setDir _dir;	
for "_i" from 1 to(50+random 100)do{
_pos=position _animal;
_posx=(_pos select 0)+(0.05*sin _dir);
_posy=(_pos select 1)+(0.05*cos _dir);
_animal setPosATL[_posx,_posy,0];
sleep random 0.1;};
_animal setVariable["tpw_animal_disperse",0];};};

//MAIN LOOP
tpw_animal_fnc_mainLoop={while{true}do{
if(tpw_animal_active)then{
private["_deleteRadius","_animal","_i"];

//hintSilent format["Animals: %1",count tpw_animal_array];//Debug

//Shrink deletion radius if near an exclusion zone, to get rid of animals quicker
if(tpw_animal_exclude)then{_deleteRadius=tpw_animal_minRadius;}else{_deleteRadius=tpw_animal_maxRadius;};		

//Spawn animals if there are less than the specified maximum
if(count tpw_animal_array<tpw_animal_max)then{[]call tpw_animal_fnc_nearAnimal;};

//Remove ownership of distant or dead animals
tpw_animal_removeArray=[];//array of animals to remove
for "_i" from 0 to(count tpw_animal_array-1)do{
_animal=tpw_animal_array select _i;
_animal forceSpeed 0.0001;//stop the bloody animal from running around constantly via BIS default FSM
if(_animal distance player>_deleteRadius || !(alive _animal))then{
_animal setVariable["tpw_animal_owner",(_animal getVariable "tpw_animal_owner")-[player],true];
tpw_animal_removeArray set[count tpw_animal_removeArray,_animal];};

//Delete live animals with no owners
if((count(_animal getVariable["tpw_animal_owner",[]])==0)&&(alive _animal))then{deleteVehicle _animal;};
	
//Animals move away from vehicles
_near=(position _animal)nearEntities[["LandVehicle"],20];
if(count _near>0)then{
[(_near select 0),_animal]spawn tpw_animal_disperse;};}; 

//Update player's animal array	
tpw_animal_array=tpw_animal_array-tpw_animal_removeArray;
player setVariable["tpw_animalArray",tpw_animal_array,true];};sleep 10;};};

[]spawn tpw_animal_fnc_mainLoop;
while{true}do{sleep 10;};