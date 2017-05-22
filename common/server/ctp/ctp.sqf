ctp={
//ARRAYS: Lists of all minaret / mosque classnames
_minarets=nearestObjects[server,["Land_A_Minaret_EP1","Land_A_Minaret_Porto_EP1","Land_R_Minaret","Land_A_Mosque_big_minaret_1_EP1","Land_A_Mosque_big_minaret_2_EP1"],8000];
_mosque=nearestObjects[server,["Land_A_Mosque_big_hq_EP1"],8000];_mosque=_mosque select 0;

//Play on all undestroyed minarets
{if(alive _x)then{[_x]spawn ctpAudio;};}forEach _minarets+[_mosque];

//Delete sound from destroyed minaret
{if(alive _x)then{
	_x addMPEventHandler["MPKilled",{
	_ctpSnd=nearestObjects[getPosATL(_this select 0),["Land_ClutterCutter_small_F"],6];
	if(count _ctpSnd>0)then{
		_ctpSnd=_ctpSnd select 0;
		deleteVehicle _ctpSnd;};
		(_this select 0)removeAllMPEventHandlers"MPKilled";}];};
}forEach _minarets+[_mosque];
};

//FUNCTION: Play the Call to Prayer audio file and delete object playing it, for synchronized end of sound
ctpAudio={
_ctpSFX=createVehicle["Land_ClutterCutter_small_F",[getPosATL(_this select 0)select 0,getPosATL(_this select 0)select 1,(getPosATL(_this select 0)select 2)+5],[],0,""];
[_ctpSFX,"adhan"]remoteExec["say3D",0];
sleep 205;
deleteVehicle _ctpSFX;};

//Schedules Call to Prayer every two hours
if(isServer)then{[]spawn ctp;sleep 7200;[]spawn ctp;sleep 7200;[]spawn ctp;sleep 7200;[]spawn ctp;sleep 7200;[]spawn ctp;};


//Prayer times taken from Kandahar, Afghanistan (CODE DOESN'T WORK!)
/*if(isServer||isDedicated)then{
if(dayTime!=5.4)then{waitUntil{dayTime==5.4};[]spawn ctp;};//5:26
if(dayTime!=6.9)then{waitUntil{dayTime==6.9};[]spawn ctp;};//6:52
if(dayTime!=11.9)then{waitUntil{dayTime==11.9};[]spawn ctp;};//11:58
if(dayTime!=14.6)then{waitUntil{dayTime==14.6};[]spawn ctp;};//14:45
if(dayTime!=17)then{waitUntil{dayTime==17};[]spawn ctp;};//17:03
if(dayTime!=18.5)then{waitUntil{dayTime==18.5};[]spawn ctp;};//18:30
};