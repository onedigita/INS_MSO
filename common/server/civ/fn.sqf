waitUntil{count allPlayers>0};
if(!isNil "civTraffic_functionsInitialized")exitWith{};
civTraffic_FindEdgeRoads={
private["_minTopLeftDistances","_minTopRightDistances","_minBottomRightDistances","_minBottomLeftDistances"];
private["_worldTrigger","_worldSize","_mapTopLeftPos","_mapTopRightPos","_mapBottomRightPos","_mapBottomLeftPos","_i","_nextStartPos","_segmentsCount"];

if(!isNil "civTraffic_edgeRoadsInitializing")exitWith{};
civTraffic_edgeRoadsInitializing=true;
sleep 2;
_worldTrigger=call BIS_fnc_worldArea;
_worldSize=triggerArea _worldTrigger;
_mapTopLeftPos=[0,2*(_worldSize select 1)];
_mapTopRightPos=[2*(_worldSize select 0),2*(_worldSize select 1)];
_mapBottomRightPos=[2*(_worldSize select 0),0];
_mapBottomLeftPos=[0,0];
_minTopLeftDistances=[];
_minTopRightDistances=[];
_minBottomRightDistances=[];
_minBottomLeftDistances=[];
for "_i" from 0 to civTraffic_instanceIndex do{
_minTopLeftDistances pushBack 1000000;
_minTopRightDistances pushBack 1000000;
_minBottomRightDistances pushBack 1000000;
_minBottomLeftDistances pushBack 1000000;};

civTraffic_allRoadSegments=[0,0,0]nearRoads 1000000;
sleep 0.01;
_segmentsCount=count civTraffic_allRoadSegments;

//Find all edge road segments
_i=0;
_nextStartPos=1;
while{_i<_segmentsCount}do{
private["_index","_road","_roadPos","_markerName","_insideMarker","_roads"];

_road=civTraffic_allRoadSegments select _i;
_roadPos=getPos _road;
_index=0;

// Top left
while{_index<=civTraffic_instanceIndex}do{
_markerName=civTraffic_areaMarkerNames select _index;//Get the marker name for the current instance
_insideMarker=true;
if(_markerName!="")then{_insideMarker=[_roadPos,_markerName]call civTraffic_PositionIsInsideMarker;};
if(_insideMarker)then{_roads=civTraffic_roadSegments select _index;_roads pushBack _road;
	//Top left
	if(_roadPos distance _mapTopLeftPos<(_minTopLeftDistances select _index))then{
	_minTopLeftDistances set[_index,_roadPos distance _mapTopLeftPos];
	civTraffic_edgeTopLeftRoads set[_index,_road];};

	//Top right
	if(_roadPos distance _mapTopRightPos<(_minTopRightDistances select _index))then{
	_minTopRightDistances set[_index,_roadPos distance _mapTopRightPos];
	civTraffic_edgeTopRightRoads set[_index,_road];};

	//Bottom right
	if(_roadPos distance _mapBottomRightPos<(_minBottomRightDistances select _index))then{
	_minBottomRightDistances set[_index,_roadPos distance _mapBottomRightPos];
	civTraffic_edgeBottomRightRoads set[_index, _road];};

	//Bottom left
	if(_roadPos distance _mapBottomLeftPos<(_minBottomLeftDistances select _index))then{
	_minBottomLeftDistances set[_index,_roadPos distance _mapBottomLeftPos];
	civTraffic_edgeBottomLeftRoads set[_index,_road];};

	if(!(civTraffic_edgeRoadsUseful select _index))then{
	civTraffic_edgeRoadsUseful set[_index, true];};
sleep 0.01;};
_index=_index+1;};

sleep 0.01;
_i=_i+50;
if(_i>=_segmentsCount)then{_i=_nextStartPos;_nextStartPos=_nextStartPos+1;
	if(_nextStartPos==50)then{_i=_segmentsCount;};};};
civTraffic_edgeRoadsInitialized=true;};

civTraffic_MoveVehicle={
private["_currentInstanceIndex","_car","_firstDestinationPos","_debug"];
private["_speed","_roadSegments","_destinationSegment"];
private["_destinationPos"];
private["_waypoint","_fuel"];

_currentInstanceIndex=_this select 0;
_car=_this select 1;
if(count _this>2)then{_firstDestinationPos=_this select 2;}else{_firstDestinationPos=[];};
if(count _this>3)then{_debug=_this select 3;}else{_debug=false;};

// Set fuel to something in between 0.3 and 0.9.
_fuel=0.3+random(0.9-0.3);
_car setFuel _fuel;

if(count _firstDestinationPos>0)then{_destinationPos = + _firstDestinationPos;}else{
_roadSegments=civTraffic_roadSegments select _currentInstanceIndex;
_destinationSegment=_roadSegments select floor random count _roadSegments;
_destinationPos=getPos _destinationSegment;};
_speed="LIMITED";
if(_car distance _destinationPos<500)then{_speed="LIMITED";};
_waypoint=group _car addWaypoint[_destinationPos,10];
_waypoint setWaypointBehaviour "SAFE";
_waypoint setWaypointSpeed _speed;
_waypoint setWaypointCompletionRadius 10;
_waypoint setWaypointStatements ["true","_nil=[" + str _currentInstanceIndex + ", " + vehicleVarName _car + ", [], " + str _debug + "] spawn civTraffic_MoveVehicle;"];
};

civTraffic_StartTraffic={
if(!isServer)exitWith{};

private["_side","_carCount","_minSpawnDistance","_maxSpawnDistance","_minSkill","_maxSkill","_areaMarkerName","_hideAreaMarker","_debug"];
private["_allPlayerPositions","_allPlayerPositionsTemp","_activecarsAndGroup","_carsGroup","_spawnSegment","_car","_group","_result","_carList","_carType","_carsCrew","_skill","_minDistance","_tries","_trafficLocation"];
private["_currentEntityNo","_carVarName","_tempcarsAndGroup","_deletedcarsCount","_firstIteration","_roadSegments","_destinationSegment","_destinationPos","_direction"];
private["_roadSegmentDirection","_testDirection","_facingAway","_posX","_posY","_pos","_currentInstanceIndex"];
private["_fnc_OnSpawnVehicle","_fnc_OnRemoveVehicle","_fnc_FindSpawnSegment"];
private["_debugMarkerName"];

_side=[_this,"SIDE",civilian]call civTraffic_GetParamValue;
_carList=[];
switch(true)do{
case(isCUPU):{_carList=[
_this,"cars",["CUP_C_Datsun_Tubeframe","CUP_C_Datsun","CUP_C_Datsun_Plain","CUP_C_Datsun_Covered","CUP_C_Datsun_4seat","CUP_C_Skoda_White_CIV",
"CUP_C_Skoda_Blue_CIV","CUP_C_Skoda_Red_CIV","CUP_C_Skoda_Green_CIV","CUP_C_Golf4_black_Civ","CUP_C_Golf4_white_Civ","CUP_C_UAZ_Unarmed_TK_CIV",
"CUP_C_LR_Transport_CTK","CUP_C_Ural_Civ_01","CUP_C_Ural_Open_Civ_01"]]call civTraffic_GetParamValue;};
default{_carList=[
_this,"cars",["C_Offroad_01_F","C_Offroad_01_repair_F","C_Offroad_02_unarmed_F","C_Hatchback_01_F","C_SUV_01_F","C_Van_01_transport_F",
"C_Van_01_box_F","C_Van_01_fuel_F","C_Truck_02_fuel_F","C_Truck_02_covered_F","C_Truck_02_box_F","C_Truck_02_transport_F","C_Quadbike_01_F"]]call civTraffic_GetParamValue;};};
_carCount=[_this,"cars_COUNT",6]call civTraffic_GetParamValue;
_minSpawnDistance=[_this,"MIN_SPAWN_DISTANCE",1000]call civTraffic_GetParamValue;
_maxSpawnDistance=[_this,"MAX_SPAWN_DISTANCE",1800]call civTraffic_GetParamValue;
_minSkill=[_this,"MIN_SKILL",0]call civTraffic_GetParamValue;
_maxSkill=[_this,"MAX_SKILL",0]call civTraffic_GetParamValue;
_areaMarkerName=[_this,"AREA_MARKER",""]call civTraffic_GetParamValue;
_hideAreaMarker=[_this,"HIDE_AREA_MARKER",true]call civTraffic_GetParamValue;
_fnc_OnSpawnVehicle=[_this,"ON_SPAWN_CALLBACK",{}]call civTraffic_GetParamValue;
_fnc_OnRemoveVehicle=[_this,"ON_REMOVE_CALLBACK",{}]call civTraffic_GetParamValue;
_debug=[_this,"DEBUG",false]call civTraffic_GetParamValue;

if(_areaMarkerName!="" && _hideAreaMarker)then{_areaMarkerName setMarkerAlpha 0;};

sleep random 1;
civTraffic_instanceIndex=civTraffic_instanceIndex+1;
_currentInstanceIndex=civTraffic_instanceIndex;

civTraffic_areaMarkerNames set[_currentInstanceIndex,_areaMarkerName];
civTraffic_edgeRoadsUseful set[_currentInstanceIndex,false];
civTraffic_roadSegments set[_currentInstanceIndex,[]];

_activecarsAndGroup=[];
_fnc_FindSpawnSegment={
private["_currentInstanceIndex","_allPlayerPositions","_minSpawnDistance","_maxSpawnDistance","_activecarsAndGroup"];
private["_insideMarker","_areaMarkerName","_refPlayerPos","_roadSegments","_roadSegment","_isOk","_tries","_result","_spawnDistanceDiff","_refPosX","_refPosY","_dir","_tooFarAwayFromAll","_tooClose","_tooCloseToAnotherVehicle"];

_currentInstanceIndex=_this select 0;
_allPlayerPositions=_this select 1;
_minSpawnDistance=_this select 2;
_maxSpawnDistance=_this select 3;
_activecarsAndGroup=_this select 4;
_spawnDistanceDiff=_maxSpawnDistance-_minSpawnDistance;
_roadSegment="NULL";
_refPlayerPos=(_allPlayerPositions select floor random count _allPlayerPositions);
_areaMarkerName=civTraffic_areaMarkerNames select _currentInstanceIndex;

_isOk=false;
_tries=0;
while{!_isOk&&_tries<10}do{
_isOk=true;
_dir=random 360;
_refPosX=(_refPlayerPos select 0)+(_minSpawnDistance+_spawnDistanceDiff/2)*sin _dir;
_refPosY=(_refPlayerPos select 1)+(_minSpawnDistance+_spawnDistanceDiff/2)*cos _dir;
_roadSegments=[_refPosX,_refPosY]nearRoads(_spawnDistanceDiff/2);
if(count _roadSegments>0)then{
_roadSegment=_roadSegments select floor random count _roadSegments;

// Check if road segment is ok
_tooFarAwayFromAll=true;
_tooClose=false;
_insideMarker=true;
_tooCloseToAnotherVehicle=false;
if(_areaMarkerName != "" && !([getPos _roadSegment,_areaMarkerName]call civTraffic_PositionIsInsideMarker))then{_insideMarker=false;};
if(_insideMarker)then{{
private["_tooFarAway"];
_tooFarAway=false;
if(_x distance(getPos _roadSegment)<_minSpawnDistance)then{_tooClose=true;};
if(_x distance(getPos _roadSegment)>_maxSpawnDistance)then{_tooFarAway=true;};
if(!_tooFarAway)then{_tooFarAwayFromAll=false;};
sleep 0.01;}forEach _allPlayerPositions;

{private["_car"];
_car=_x select 0;
if((getPos _roadSegment)distance _car<100)then{_tooCloseToAnotherVehicle=true;};
sleep 0.01;}forEach _activecarsAndGroup;};
_isOk=true;

if(_tooClose || _tooFarAwayFromAll || _tooCloseToAnotherVehicle || !_insideMarker)then{_isOk=false;_tries=_tries+1;};}else{_isOk = false;_tries=_tries+1;};
sleep 0.1;};

if(!_isOk)then{_result="NULL";}else{_result=_roadSegment;};
_result
};

_firstIteration=true;

[]spawn civTraffic_FindEdgeRoads;
waitUntil{sleep 1;(civTraffic_edgeRoadsUseful select _currentInstanceIndex)};
sleep 5;

while{true}do{
scopeName "mainScope";
private["_sleepSeconds","_correctedVehicleCount","_markerSize","_avgMarkerRadius","_coveredShare","_restDistance","_coveredAreaShare"];
_allPlayerPositionsTemp=[];
if(isMultiplayer)then{
{if(isPlayer _x)then{_allPlayerPositionsTemp=_allPlayerPositionsTemp+[position vehicle _x];};
}forEach(playableUnits);}else{_allPlayerPositionsTemp=[position vehicle player];};

if(count _allPlayerPositionsTemp>0)then{_allPlayerPositions=_allPlayerPositionsTemp;};

// If there are few cars, add a vehicle
if(_areaMarkerName=="")then{_correctedVehicleCount=_carCount;}else{
_markerSize=getMarkerSize _areaMarkerName;
_avgMarkerRadius=((_markerSize select 0)+(_markerSize select 1))/2;
	if(_avgMarkerRadius>_maxSpawnDistance)then{
	_correctedVehicleCount=floor(_carCount/2);
    _coveredShare=0;
	{_restDistance=_maxSpawnDistance-((_x distance getMarkerPos _areaMarkerName)-_avgMarkerRadius);
	_coveredAreaShare=_restDistance/(_maxSpawnDistance*2);
	    if(_coveredAreaShare>_coveredShare)then{_coveredShare=_coveredAreaShare;};
	    sleep 0.01;}forEach(_allPlayerPositions);

	_correctedVehicleCount=floor(_carCount*_coveredShare);}else{_correctedVehicleCount=_carCount;};};
_tries=0;
while{count _activecarsAndGroup<_correctedVehicleCount&&_tries<1}do{
sleep 0.1;
// Get all spawn positions within range
if(_firstIteration)then{_minDistance=300;
	if(_minDistance>_maxSpawnDistance)then{_minDistance=0;};}else{_minDistance=_minSpawnDistance;};

_spawnSegment=[_currentInstanceIndex,_allPlayerPositions,_minDistance,_maxSpawnDistance,_activecarsAndGroup]call _fnc_FindSpawnSegment;

//If there were spawn positions
if(str _spawnSegment!="""NULL""")then{
// Get first destination
_trafficLocation=floor random 5;
switch(_trafficLocation)do{
case 0:{_roadSegments=(getPos(civTraffic_edgeBottomLeftRoads select _currentInstanceIndex))nearRoads 100;};
case 1:{_roadSegments=(getPos(civTraffic_edgeTopLeftRoads select _currentInstanceIndex))nearRoads 100;};
case 2:{_roadSegments=(getPos(civTraffic_edgeTopRightRoads select _currentInstanceIndex))nearRoads 100;};
case 3:{_roadSegments=(getPos(civTraffic_edgeBottomRightRoads select _currentInstanceIndex))nearRoads 100;};
default{_roadSegments=civTraffic_roadSegments select _currentInstanceIndex};};//;}

_destinationSegment=_roadSegments select floor random count _roadSegments;
_destinationPos=getPos _destinationSegment;
_direction=((_destinationPos select 0)-(getPos _spawnSegment select 0))atan2((_destinationPos select 1)-(getpos _spawnSegment select 1));
_roadSegmentDirection=getDir _spawnSegment;
while{_roadSegmentDirection<0}do{_roadSegmentDirection=_roadSegmentDirection+360;};
while{_roadSegmentDirection>360}do{_roadSegmentDirection=_roadSegmentDirection-360;};
while{_direction<0}do{_direction=_direction+360;};
while{_direction>360}do{_direction=_direction-360;};

_testDirection=_direction-_roadSegmentDirection;
while{_testDirection<0}do{_testDirection=_testDirection+360;};
while{_testDirection>360}do{_testDirection=_testDirection-360;};

_facingAway=false;
if(_testDirection>90 && _testDirection<270)then{_facingAway=true;};
if(_facingAway)then{_direction=_roadSegmentDirection+180;}else{_direction=_roadSegmentDirection;};            

_posX=(getPos _spawnSegment)select 0;
_posY=(getPos _spawnSegment)select 1;
_posX=_posX+2.5*sin(_direction+90);
_posY=_posY+2.5*cos(_direction+90);
_pos=[_posX,_posY,0];

// Create vehicle
_carType=_carList select floor(random count _carList);
_result=[_pos,_direction,_carType,_side]call BIS_fnc_spawnVehicle;
_car=_result select 0;
_carsCrew=_result select 1;
_carsGroup=_result select 2;

// Name vehicle
sleep random 0.1;
if(isNil "dre_MilitaryTraffic_CurrentEntityNo")then{dre_MilitaryTraffic_CurrentEntityNo=0};

_currentEntityNo=dre_MilitaryTraffic_CurrentEntityNo;
dre_MilitaryTraffic_CurrentEntityNo=dre_MilitaryTraffic_CurrentEntityNo+1;

_carVarName="dre_MilitaryTraffic_Entity_" + str _currentEntityNo;
_car setVehicleVarName _carVarName;
_car call compile format["%1=_this;",_carVarName];
clearItemCargoGlobal _car;_car lock 3;_car allowCrewInImmobile true;
sleep 0.01;
{_x enableSimulation false;_x disableAI "ALL";_x hideObjectGlobal true;[_x]execVM "eos\fn\randOP4.sqf";_x forceSpeed 8;
sleep 0.01;}forEach _carsCrew;

_debugMarkerName="dre_MilitaryTraffic_DebugMarker" + str _currentEntityNo;

// Start vehicle
[_currentInstanceIndex,_car,_destinationPos,_debug]spawn civTraffic_MoveVehicle;
_activecarsAndGroup pushBack[_car,_carsGroup,_carsCrew,_debugMarkerName];
sleep 0.01;

// Run spawn script and attach handle to vehicle
_car setVariable["dre_scriptHandle",_result spawn _fnc_OnSpawnVehicle];};
_tries=_tries+1;};

_firstIteration=false;

//If any vehicle is too far away, delete it
_tempcarsAndGroup=[];
_deletedcarsCount=0;
{private["_closestUnitDistance","_distance","_crewUnits"];
private["_scriptHandle"];
_car=_x select 0;
_group=_x select 1;
_crewUnits=_x select 2;
_debugMarkerName=_x select 3;
_closestUnitDistance=1000000;

{_distance=(_x distance _car);
if(_distance<_closestUnitDistance)then{_closestUnitDistance=_distance;};
sleep 0.01;}forEach _allPlayerPositions;

if(_closestUnitDistance<_maxSpawnDistance)then{_tempcarsAndGroup pushBack _x;}else{
//Run callback before deleting
_car call _fnc_OnRemoveVehicle;

//Delete crew
{deleteVehicle _x;}forEach _crewUnits;

//Terminate script before deleting the vehicle
_scriptHandle=_car getVariable "dre_scriptHandle";
if(!(scriptDone _scriptHandle))then{terminate _scriptHandle;};
deleteVehicle _car;deleteGroup _group;

[_debugMarkerName]call civTraffic_DeleteDebugMarkerAllClients;
_deletedcarsCount=_deletedcarsCount+1;};
sleep 0.01;}forEach _activecarsAndGroup;
_activecarsAndGroup=_tempcarsAndGroup;

//Do nothing but update debug markers for X seconds
_sleepSeconds=5;
if(_debug)then{
for "_i" from 1 to _sleepSeconds do{
{private["_debugMarkerColor"];
_car=_x select 0;
_group=_x select 1;
_debugMarkerName=_x select 3;
_side=side _group;
_debugMarkerColor="Default";
if(_side==west)then{_debugMarkerColor="ColorBlue";};
if(_side==east)then{_debugMarkerColor="ColorRed";};
if(_side==civilian)then{_debugMarkerColor="ColorYellow";};
if(_side==resistance)then{_debugMarkerColor="ColorGreen";};

[_debugMarkerName,getPos(_car),"mil_dot",_debugMarkerColor,"Traffic"]call civTraffic_SetDebugMarkerAllClients;}forEach _activecarsAndGroup;
sleep 1;};}else{sleep _sleepSeconds;};};};
civTraffic_functionsInitialized=true;