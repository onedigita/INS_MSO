while{(true)}do{
{if((_x isKindOf "SoldierEB")||(_x isKindOf "SoldierGB"))then{
_x removeAllEventHandlers "Fired";
_x addEventHandler["Fired",{if(_this select 1!="THROW"&&_this select 1!="PUT")then{_this execVM "common\server\ai\fireSound.sqf"};}];};
}forEach allUnits-allPlayers;sleep 10;};