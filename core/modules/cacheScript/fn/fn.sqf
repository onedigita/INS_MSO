SL_cityAreas={
private["_locations","_cityTypes","_randLoc","_x","_i","_cities"];
_i=0;
_cities=[];
_locations=configFile>>"CfgWorlds">>worldName>>"Names";
_cityTypes=["FlatArea","FlatAreaCity","FlatAreaCitySmall","Hill","NameCity","NameCityCapital","NameLocal","NameMarine","NameVillage","StrongpointArea","VegetationFir"];
for "_x" from 0 to(count _locations-1)do{
_randLoc=_locations select _x;

//Get city info
private["_cityName","_cityPos","_cityRadA","_cityRadB","_cityType","_cityAngle"];
_cityName=getText(_randLoc>>"name");
_cityPos=getArray(_randLoc>>"position");
_cityRadA=getNumber(_randLoc>>"radiusA");
_cityRadB=getNumber(_randLoc>>"radiusB");
_cityType=getText(_randLoc>>"type");
_cityAngle=getNumber(_randLoc>>"angle");

if(_cityType in _cityTypes)then{
_cities set[_i,[_cityName,_cityPos,_cityRadA,_cityRadB,_cityType,_cityAngle]];
_i=_i+1;};
};
_cities;};
SL_mkrAreas={
private["_mkrsTotal","_mkrs","_mkr"];
_mkrs=[];
_mkrsTotal=[];
_mkrsTotal=AllMapMarkers;
{_mkr=[_x,3]call KRON_StrLeft;
if(_mkr=="mkr")then{
_mkrs=_mkrs+[_x];};}forEach _mkrsTotal;
_mkrs;};
SL_findHouses={
private["_center","_radius","_houses"];
_center=_this select 0;
_radius=_this select 1;
_cacheHouses=["Land_House_L_1_EP1","Land_House_L_3_EP1","Land_House_L_4_EP1","Land_House_L_6_EP1","Land_House_L_7_EP1","Land_House_L_8_EP1","Land_House_L_9_EP1","Land_House_K_1_EP1","Land_House_K_3_EP1","Land_House_K_5_EP1","Land_House_K_6_EP1","Land_House_K_7_EP1","Land_House_K_8_EP1","Land_House_C_1_EP1","Land_House_C_1_v2_EP1","Land_House_C_2_EP1","Land_House_C_3_EP1","Land_House_C_4_EP1","Land_House_C_5_EP1","Land_House_C_5_V1_EP1","Land_House_C_5_V2_EP1","Land_House_C_5_V3_EP1","Land_House_C_9_EP1","Land_House_C_10_EP1","Land_House_C_11_EP1","Land_House_C_12_EP1","Land_A_Villa_EP1","Land_A_Mosque_small_1_EP1","Land_A_Mosque_small_2_EP1","Land_A_Mosque_big_addon_EP1","Land_A_Mosque_big_hq_EP1","Land_Ind_FuelStation_Build_EP1","Land_Ind_Garage01_EP1","Land_Ind_Coltan_Main_EP1","Land_Ind_Oil_Tower_EP1"];
_houses=nearestObjects[_center,_cacheHouses,_radius];
_houses;};
SL_housePos={
private["_cbPos"];
_house=_this select 0;
_cbPos=0;
for "_x" from 1 to 100 do{
if(format["%1",(_house buildingPos _x)]!="[0,0,0]")then{_cbPos=_cbPos+1;};
};
_cbPos;};
SL_randHousePos={
private["_house","_count","_pos"];
_house=_this select 0;
_count=[_house]call SL_housePos;
if(_count==0)then{
_pos=getPos _house;}else{
_pos=random _count;
_pos=_house buildingPos _pos;};
if((_pos select 0)==0)then{
_pos=getPos _house;};
_pos};