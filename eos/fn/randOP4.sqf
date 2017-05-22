waitUntil{!isNil "bis_fnc_init"};
_unit=_this select 0;
if(side _unit==East)then{
sleep 7.5;
[_unit]call InsH;
sleep 3;
[_unit]call InsU;[_unit]call InsV;[_unit]call InsG;
sleep 1;
[_unit]call InsW;
sleep 1;
[_unit]call InsAI;
sleep 1;
_unit disableConversation false;
if(round(random 2)==1)then{_unit addPrimaryWeaponItem "acc_flashlight";};
_unit hideObjectGlobal false;_unit setBehaviour "SAFE";
_nearH=_unit nearObjects["House_EP1",10];
_Haus=[];
{_Haus=_Haus+[_x];}forEach _nearH;
_Hauss=count _Haus;
if(_Hauss>0)then{if(round(random 3)==1)then{_unit playAction "SitDown";};};};

if(side _unit==Independent)then{
sleep 7.5;
removeAllAssignedItems _unit;removeHeadgear _unit;_unit addHeadgear "H_HelmetO_ocamo";
sleep 3;
removeUniform _unit;_unit forceAddUniform "U_O_CombatUniform_ocamo";
sleep 1;
[_unit]call InsAI;
sleep 1;
_unit disableConversation false;
_unit linkItem "ItemRadio";_unit addPrimaryWeaponItem "acc_flashlight";_unit hideObjectGlobal false;_unit setBehaviour "SAFE";};

_unit addItem "itemMap";

if(side _unit==Civilian)then{
_unit setSkill 0;_unit setVariable["NOAI",1,false];
sleep 1;
removeAllAssignedItems _unit;removeGoggles _unit;
[_unit]call InsH;[_unit]call InsF;
sleep 3;
[_unit]call InsU;[_unit]call InsG;
sleep 1;
[_unit]call CivV;
sleep 8;
_unit enableSimulationGlobal true;
sleep 3;
_unit enableAI "teamSwitch";
sleep 1;
_unit enableAI "anim";
sleep 5;
_unit enableAI "fsm";
sleep 5;
_unit enableAI "move";null=[_unit]execVM "eos\fn\ask.sqf";
sleep 1.5;
_unit enableAI "path";
sleep 1.5;
_unit enableAI "suppression";_unit enableAI "cover";
sleep 1.5;
_unit enableAI "checkVisible";_unit enableAI "target";_unit enableAI "autoTarget";
sleep 1.5;
_unit enableAI "autoCombat";_unit allowDamage true;
sleep 1.5;
_unit hideObjectGlobal false;_unit setBehaviour "SAFE";_unit setAnimSpeedCoef .8;
if(_unit!=_unit)exitWith{};
_unit addEventHandler["FiredNear",{
_civ=_this select 0;_civ removeAllEventHandlers "FiredNear";
switch(floor(random 2))do{
case 0:{_civ switchMove "ApanPercMstpSnonWnonDnon_G01";};
case 1:{_civ playMoveNow "ApanPknlMstpSnonWnonDnon_G01";};
case 2:{_civ playMoveNow "ApanPpneMstpSnonWnonDnon_G01";};
default{_civ playMoveNow "ApanPknlMstpSnonWnonDnon_G01";};};
_civ setSpeedMode "FULL";
_nH=nearestObjects[_civ,["Land_House_K_1_EP1","Land_House_K_3_EP1","Land_House_K_5_EP1","Land_House_K_6_EP1","Land_House_K_7_EP1","Land_House_K_8_EP1","Land_House_L_1_EP1","Land_House_L_2_EP1","Land_House_L_3_EP1","Land_House_L_4_EP1","Land_House_L_6_EP1","Land_House_L_7_EP1","Land_House_L_8_EP1","Land_House_L_9_EP1","Land_House_C_1_EP1","Land_House_C_1_v2_EP1","Land_House_C_2_EP1","Land_House_C_3_EP1","Land_House_C_4_EP1","Land_House_C_5_EP1","Land_House_C_5_V1_EP1","Land_House_C_5_V2_EP1","Land_House_C_5_V3_EP1","Land_House_C_10_EP1","Land_House_C_11_EP1","Land_House_C_12_EP1","Land_A_Mosque_small_1_EP1","Land_A_Mosque_small_2_EP1","Land_A_Mosque_big_addon_EP1","Land_A_Mosque_big_hq_EP1"],100];
_H=selectRandom _nH;_HP=_H buildingPos -1;_HP=selectRandom _HP;_civ doMove _HP;}];
_unit addMPEventHandler["MPKilled",{if(side(_this select 1)==West)then{systemChat format["%1 inflicted a civilian casualty!",name(_this select 1)];};(_this select 0)removeAllMPEventHandlers "MPKilled";}];
_nearH=_unit nearObjects["House_EP1",10];
_Haus=[];{_Haus=_Haus+[_x];}forEach _nearH;_Hauss=count _Haus;
if(_Hauss>0)then{_unit playAction "SitDown";};};