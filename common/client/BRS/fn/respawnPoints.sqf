//IF SPAWN POINT IS ALIVE AND IS NOT CURRENTLY IN SPAWN POINTS
{if(alive _x && !(_x in BRS_spawnPoints)&&(_x!=player)&&(_x distance hidePlayer>BRS_hideRadius))then{
BRS_spawnPoints set[count BRS_spawnPoints,_x];};}forEach BRS_backUp;

//IF SPAWN POINT IS IN BRS THEN REMOVE
{if(_x distance hidePlayer<BRS_hideRadius)then{BRS_spawnPoints=BRS_spawnPoints-[_x];
if(_x==BRS_currentSpawn)then{_nil=[true]call findSpawn;};};

//IF SPAWN POINTS ARE DEAD REMOVE FROM ARRAY
if(!alive _x)then{BRS_spawnPoints=BRS_spawnPoints-[_x];

//IF CURRENT SPAWN IS KILLED THEN FIND NEXT SPAWN
if(_x==BRS_currentSpawn)then{_nil=[true]call findSpawn;};
};}forEach BRS_spawnPoints;