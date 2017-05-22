private["_target"];
_jihad=_this select 0;_nearGuys=[];_target="";
sleep 40;
[_jihad,"FiredNear"]remoteExec["removeAllEventHandlers",0,true];[_jihad,"MPKilled"]remoteExec["removeAllMPEventHandlers",0,true];_jihad remoteExec["removeAllActions",0,true];
removeVest _jihad;_jihad addVest "V_RebreatherB";_jihad enableFatigue false;_jihad enableStamina false;_jihad setDamage 0;_jihad forceSpeed 8;
_jihad setUnitPos "UP";_jihad setBehaviour "AWARE";_jihad setSpeedMode "FULL";_jihad setCombatMode "RED";
_jihad disableAI "suppression";_jihad disableAI "cover";_jihad disableAI "fsm";_jihad disableAI "autoCombat";_jihad setAnimSpeedCoef 1;
if((animationState _jihad=="ApanPercMstpSnonWnonDnon_G01")||{(animationState _jihad=="ApanPknlMstpSnonWnonDnon_G01")||(animationState _jihad=="ApanPpneMstpSnonWnonDnon_G01")})then{[_jihad,""]remoteExec["switchMove",0];};

while{alive _jihad}do{_nearGuys=nearestObjects[_jihad,["SoldierWB"],150];
{if(!(isPlayer _x))then{_nearGuys=_nearGuys-[_x];};}forEach _nearGuys;
if(count _nearGuys>0)then{_target=_nearGuys select(floor random count _nearGuys);_pos=getPosATL _target;_jihad doMove _pos;

if(_jihad distance _pos>150)then{_pos=getPosATL _target;_jihad doMove _pos;};

if(_jihad distance _pos<150)then{_pos=getPosATL _target;_jihad doMove _pos;_jihad forceSpeed 8;_jihad setUnitPos "UP";_jihad setSpeedMode "FULL";_jihad forceSpeed 8;};

if(_jihad distance _target<3)exitWith{[[_jihad,"shout"],"ia_say"]call BIS_fnc_MP;
sleep(1+random 2);
if(alive _jihad)then{createVehicle["Bo_GBU12_LGB",getPosATL _jihad,[],0,""];_jihad setDamage 1;};};};
sleep 3;};