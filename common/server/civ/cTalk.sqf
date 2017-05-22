private["_civ","_civKind","_civs","_civNum"];
_civ=_this select 0;_civs=[];_civNum=0;
if(round(random 8)==1)then{
	while{_civNum<1}do{_civs=nearEntities[_civ,["C_man_1"],3];_civNum=count _civs;};
	waitUntil{(alive _civ && _civNum>1)};
{if(_civNum>1)then{_nCiv=_civs select 1;
doStop _civ;doStop _nCiv;_civ disableAI "move";_civ disableAI "path";_nCiv disableAI "move";_nCiv disableAI "path";
_cDir=getDir _civ;_ncDir=getDir _nCiv;
_civ setDir(_ncDir-180);_nCiv setDir(_cDir-180);
[_civ,"Acts_StandingSpeakingUnarmed"]remoteExec["switchMove",0];
sleep(random 8);
[_nCiv,"Acts_StandingSpeakingUnarmed"]remoteExec["switchMove",0];
}else{if(_civNum<=1)exitWith{};};}forEach allUnits-playableUnits;};
//////////////////////////////////
//////////////////////////////////
//////////////////////////////////

{if(side _x==civilian)then{
pew=_x addEventHandler["FiredNear",{
_civ=_this select 0;
_nH=_civ nearObjects[["Land_House_K_1_EP1","Land_House_K_3_EP1","Land_House_K_5_EP1","Land_House_K_6_EP1","Land_House_K_7_EP1","Land_House_K_8_EP1","Land_House_L_1_EP1","Land_House_L_2_EP1","Land_House_L_3_EP1","Land_House_L_4_EP1","Land_House_L_6_EP1","Land_House_L_7_EP1","Land_House_L_8_EP1","Land_House_L_9_EP1","Land_House_C_1_EP1","Land_House_C_1_v2_EP1","Land_House_C_2_EP1","Land_House_C_3_EP1","Land_House_C_4_EP1","Land_House_C_5_EP1","Land_House_C_5_V1_EP1","Land_House_C_5_V2_EP1","Land_House_C_5_V3_EP1","Land_House_C_10_EP1","Land_House_C_11_EP1","Land_House_C_12_EP1","Land_A_Mosque_small_1_EP1","Land_A_Mosque_small_2_EP1","Land_A_Mosque_big_addon_EP1","Land_A_Mosque_big_hq_EP1"],100];
_H=selectRandom _nH;

switch(true)do{
case(_H isKindOf "Land_House_K_1_EP1"):{_HP=_H buildingPos 5;_civ doMove _HP;};
case(_H isKindOf "Land_House_K_3_EP1"):{_HP=_H buildingPos 2;_civ doMove _HP;};
case(_H isKindOf "Land_House_K_5_EP1"):{_HP=_H buildingPos 3;_civ doMove _HP;};
case(_H isKindOf "Land_House_K_6_EP1"):{_HP=_H buildingPos 6;_civ doMove _HP;};
case(_H isKindOf "Land_House_K_7_EP1"):{_HP=_H buildingPos 2;_civ doMove _HP;};
case(_H isKindOf "Land_House_K_8_EP1"):{_HP=_H buildingPos 4;_civ doMove _HP;};
case(_H isKindOf "Land_House_L_1_EP1"):{_HP=_H buildingPos 3;_civ doMove _HP;};
case(_H isKindOf "Land_House_L_2_EP1"):{_HP=_H buildingPos 3;_civ doMove _HP;};
case(_H isKindOf "Land_House_L_3_EP1"):{_HP=_H buildingPos 1;_civ doMove _HP;};
case(_H isKindOf "Land_House_L_4_EP1"):{_HP=_H buildingPos 7;_civ doMove _HP;};
case(_H isKindOf "Land_House_L_6_EP1"):{_HP=_H buildingPos 1;_civ doMove _HP;};
case(_H isKindOf "Land_House_L_7_EP1"):{_HP=_H buildingPos 6;_civ doMove _HP;};
case(_H isKindOf "Land_House_L_8_EP1"):{_HP=_H buildingPos 4;_civ doMove _HP;};
case(_H isKindOf "Land_House_L_9_EP1"):{_HP=_H buildingPos 2;_civ doMove _HP;};
case(_H isKindOf "Land_House_C_1_EP1"):{_HP=_H buildingPos 5;_civ doMove _HP;};
case(_H isKindOf "Land_House_C_1_v2_EP1"):{_HP=_H buildingPos 2;_civ doMove _HP;};
case(_H isKindOf "Land_House_C_2_EP1"):{_HP=_H buildingPos 9;_civ doMove _HP;};
case(_H isKindOf "Land_House_C_3_EP1"):{_HP=_H buildingPos 14;_civ doMove _HP;};
case(_H isKindOf "Land_House_C_4_EP1"):{_HP=_H buildingPos 11;_civ doMove _HP;};
case(_H isKindOf "Land_House_C_5_EP1"):{_HP=_H buildingPos 5;_civ doMove _HP;};//NOT DONE
case(_H isKindOf "Land_House_C_5_V1_EP1"):{_HP=_H buildingPos 11;_civ doMove _HP;};
case(_H isKindOf "Land_House_C_5_V2_EP1"):{_HP=_H buildingPos 11;_civ doMove _HP;};
case(_H isKindOf "Land_House_C_5_V3_EP1"):{_HP=_H buildingPos 11;_civ doMove _HP;};
case(_H isKindOf "Land_House_C_10_EP1"):{_HP=_H buildingPos 12;_civ doMove _HP;};
case(_H isKindOf "Land_House_C_11_EP1"):{_HP=_H buildingPos 5;_civ doMove _HP;};//NOT DONE
case(_H isKindOf "Land_House_C_12_EP1"):{_HP=_H buildingPos 7;_civ doMove _HP;};
case(_H isKindOf "Land_A_Mosque_small_1_EP1"):{_HP=_H buildingPos 6;_civ doMove _HP;};//4,5,6
case(_H isKindOf "Land_A_Mosque_small_2_EP1"):{_HP=_H buildingPos 2;_civ doMove _HP;};
case(_H isKindOf "Land_A_Mosque_big_addon_EP1"):{_HP=_H buildingPos 1;_civ doMove _HP;};
case(_H isKindOf "Land_A_Mosque_big_hq_EP1"):{_HP=_H buildingPos 1;_civ doMove _HP;};//1,2
//case(_H isKindOf "Land_A_Villa_EP1"):{_HP=_H buildingPos 9;_civ doMove _HP;};//Prime Minister
//case(_H isKindOf "Land_House_C_9_EP1"):{_HP=_H buildingPos 14;_civ doMove _HP;};// House has bad AI navMesh
};
if(round(random 2)==1)then{_civ switchMove "ApanPercMstpSnonWnonDnon_G01";_civ setSpeedMode "FULL";}else{_civ setUnitPos "DOWN";_civ setSpeedMode "FULL";};
_civ removeEventHandler["FiredNear",pew];}];};
}forEach allUnits-playableUnits;