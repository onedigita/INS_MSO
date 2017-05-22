private["_currentName","_marker"];
disableSerialization;
_display=uiNamespace getVariable "BRS_RespawnDialog";
if(!isNil("_display"))then{
(_display displayCtrl 42500)ctrlShow true;	
(_display displayCtrl 41000)ctrlShow true;	
(_display displayCtrl 41100)ctrlShow true;
(_display displayCtrl 41200)ctrlShow true;
(_display displayCtrl 39650)ctrlShow true;
(_display displayCtrl 42500)ctrlMapAnimAdd[0,0.16,getPos BRS_currentSpawn];
ctrlMapAnimCommit(_display displayCtrl 42500);};
BRS_mkr_array=[];
BRS_cam_offset=2.4;
BRS_cam attachTo[(vehicle BRS_currentSpawn),[BRS_cam_offset,-5.5,-0],"neck"];

while{!BRS_mapClose}do{
sleep 0.1;
{if(!(format["%1",_x]in BRS_mkr_array))then{
if(!(_x isKindOf "Man"))then{_currentName=format["%1",_x];}else{_currentName=format["%1",name _x];};
_marker=createMarkerLocal[format["%1",_X],position _x];
_marker setMarkerTextLocal _currentName;
switch(true)do{
case(_x isKindOf "Man"):{_marker setMarkerTypeLocal "respawn_inf";};
case(_x isKindOf "Car"):{_marker setMarkerTypeLocal "respawn_motor";};
case(_x isKindOf "Helicopter"):{_marker setMarkerTypeLocal "respawn_air";};
case(_x isKindOf "Tank"):{_marker setMarkerTypeLocal "respawn_armor";};
default{_marker setMarkerTypeLocal "respawn_unknown";};
};
_marker setMarkerAlphaLocal 1;
_marker setMarkerColorLocal "ColorBlufor";
BRS_mkr_array set[count BRS_mkr_array,_marker];}else{
_marker=(format["%1",_x]);
_marker setMarkerPosLocal(getPos _x);
//_marker setMarkerDirLOCAL getDir _x;
if(!alive _X or(_x distance hidePlayer < BRS_hideRadius))then{
deleteMarkerLocal _marker;
BRS_mkr_array=BRS_mkr_array-[_marker];};
};
}forEach BRS_spawnPoints;};
{deleteMarkerLocal format["%1",_x];}forEach BRS_mkr_array;
