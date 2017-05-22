enableSentences false;player disableConversation true;player setVariable["BIS_noCoreConversations",true];player setSpeaker "NoVoice";player enableMimics false;
removeAllWeapons player;removeGoggles player;removeHeadgear player;removeVest player;removeUniform player;removeAllAssignedItems player;clearAllItemsFromBackpack player;removeBackpack player;
player setUnitLoadout(player getVariable["Saved_Loadout",[]]);
player addItem "FirstAidKit";setViewDistance(paramsArray select 6);
if(!isACE)then{execVM "common\client\strobe\strobe.sqf";
if((player isKindOf "B_medic_F")||(player isKindOf "B_recon_medic_F")&&{(!"Medikit" in items player)})then{player addItemToBackpack "Medikit";};};
if(vehicleVarName player in CASarray)then{[MaxD,Alock,num]execVM "common\client\CAS\addAction.sqf";};
BRS_cam cameraEffect["internal","back"];BRS_cam camCommit 0;