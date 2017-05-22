if !(isServer)exitWith{};
private["_unit","_gun","_gunArr","_gunMag","_skills","_civPos","_nearCiv","_nearCivLive","_grp","_prevGrp","_victim"];
sleep 45;
_unit=_this select 0;
[_unit,"FiredNear"]remoteExec["removeAllEventHandlers",0,true];

_gun="";
switch(true)do{
case(isCUPW):{_gunArr=["CUP_hgun_SA61","CUP_8Rnd_9x18_Makarov_M","CUP_hgun_MicroUzi","CUP_8Rnd_9x18_Makarov_M"];};
default{_gunArr=["hgun_Pistol_01_F","hgun_PDW2000_F"];};};

_gunMag="";
if(_gun=="")then{_gun=selectRandom _gunArr;};
_gunMag=(getArray(configFile>>"CfgWeapons">>_gun>>"magazines"))select 0;

_civPos=[];_nearCiv=[];_nearCivLive=[];_victim="";_prevGrp=group _unit;_grp=createGroup EAST;
_unit allowFleeing 0;
_skill=.2+random .2;
_skills=[.3,.5,.8,1,.7,1,.8,1,1];
{_skillValue=(_skills select _forEachIndex)+(random _skill)-(random _skill);_unit setSkill[_x,_skillValue];
}forEach['aimingAccuracy','aimingShake','aimingSpeed','spotDistance','spotTime','courage','reloadSpeed','commanding','general'];


while{alive _unit}do{
_civPos=getPos _unit;
_nearCiv=nearestObjects[_civPos,["SoldierWB"],9];
	{if((isPlayer _x)&&{(alive _x)})then{_nearCivLive set[(count _nearCivLive),_x];};}forEach _nearCiv;
	if(count _nearCivLive>0)then{_victim=selectRandom _nearCivLive;
	if(typeName _victim=="OBJECT")then{

sleep 1+(round random 7);
doStop _unit;
[_unit]joinSilent grpNull;
[_unit,"MPKilled"]remoteExec["removeAllMPEventHandlers",0,true];_unit remoteExec["removeAllActions",0,true];
sleep 1;
[_unit]joinSilent _grp;deleteGroup _prevGrp;
if(_unit knowsAbout _victim<2)then{_unit reveal[_victim,2.5]};
_unit setBehaviour "AWARE";_unit setCombatMode "YELLOW";_unit disableAI "cover";_unit disableAI "suppression";
_unit forceSpeed 3;_unit lookAt _victim;
if((animationState _unit=="ApanPercMstpSnonWnonDnon_G01")||{
(animationState _unit=="ApanPknlMstpSnonWnonDnon_G01")||
(animationState _unit=="ApanPpneMstpSnonWnonDnon_G01")})then{[_unit,""]remoteExec["switchMove",0];};
doStop _unit;
sleep .5;
_unit addMagazines[_gunMag,4];_unit addWeaponGlobal _gun;_unit selectWeapon _gun;sleep .5;
while{alive _unit && alive _victim}do{_unit doTarget _victim;_unit doFire _victim;sleep .5;
if(count magazines _unit==0&&_unit ammo currentWeapon _unit==0)then{sleep 2;_unit action["switchWeapon",_unit,_unit,-1];};
};
sleep 2;};};sleep 5;};
if(!alive _unit)exitWith{deleteGroup _grp;};