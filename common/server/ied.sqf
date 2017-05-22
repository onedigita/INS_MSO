iedMkr=["SW","NW","iedSE","NE"];
iedBlast=["Bo_Mk82","Rocket_03_HE_F","M_Mo_82mm_AT_LG","Bo_GBU12_LGB","Bo_GBU12_LGB_MI10","HelicopterExploSmall"];
iedList=["IEDLandBig_F","IEDLandSmall_F","IEDUrbanBig_F","IEDUrbanSmall_F"];
iedJunk=["Land_Garbage_square3_F","Land_Garbage_square5_F","Land_Garbage_line_F"];
iedNum=5;
{_x setMarkerAlpha 0;}forEach iedMkr;
if(!isServer)exitWith{};

iedAct={_iedObj=_this;
waitUntil{sleep 1;player distance _iedObj<=10&&speed player>4};
if(mineActive _iedObj)then{
_iedBlast=selectRandom iedBlast;
createVehicle[_iedBlast,(getPosATL _iedObj),[],0,""];
_iedDel=nearestObjects[getPosATL _iedObj,["IEDLandBig_F","IEDLandSmall_F","IEDUrbanBig_F","IEDUrbanSmall_F","Land_Garbage_square3_F","Land_Garbage_square5_F","Land_Garbage_line_F"],4];{deleteVehicle _x}forEach _iedDel;};};

{private["_ieds"];_ieds=[];_iedArea=getMarkerSize _x select 0;_iedRoad=(getMarkerPos _x)nearRoads _iedArea;
	for "_i" from 1 to iedNum do{
	if(count _ieds==iedNum*4)exitWith{};
	_iedR=selectRandom _iedRoad;
	_ied=selectRandom iedList;_junk=selectRandom iedJunk;
	_ied=createMine[_ied,getPosATL _iedR,[],8];_ied setPosATL(getPosATL _ied select 2+1);_ied setDir(random 359);
	if(round(random 2)==1)then{_iedJunk=createVehicle[_junk,getPosATL _ied,[],0,""];_iedJunk setPosATL(getPosATL _iedJunk select 2+1);_iedJunk enableSimulation false;};
	_jnkR=selectRandom _iedRoad;_junk=createVehicle[_junk,getPosATL _jnkR,[],8,""];_junk setPosATL(getPosATL _junk select 2+1);
	_junk enableSimulation false;[_ied,iedAct]remoteExec["spawn",0,true];
	_ieds set[count _ieds,_ied];
		/*iedMkrs=[];
		_mkrID=format["m %1",getPosATL _ied];
		_mkr=createMarker[_mkrID,getPosATL _ied];
		_mkr setMarkerShape "ICON";_mkr setMarkerType "mil_dot";_mkr setMarkerBrush "Solid";_mkr setMarkerAlpha 1;_mkr setMarkerColor "ColorEast";
		iedMkrs set[count iedMkrs,_mkr];*/
	};
}forEach iedMkr;
sleep 5;
{civilian revealMine _x;east revealMine _x;}forEach allMines;