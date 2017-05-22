//MUTE ME
enableSentences false;player disableConversation true;player setVariable["BIS_noCoreConversations",true];player setSpeaker "NoVoice";


//COMBAT DEAFNESS
player addEventHandler["Explosion",{
_unit=_this select 0;
_dmg=damage _unit;
_newDmg=_this select 1;
if(_newDmg>.04)then{
playSound "deaf";
1 fadeSound 0;1 fadeRadio 0;8 fadeSound 1;8 fadeRadio 1;
[]spawn{
_blur=ppEffectCreate["DynamicBlur",474];
_blur ppEffectEnable true;
_blur ppEffectAdjust[0];
_blur ppEffectCommit 0;
waitUntil{ppEffectCommitted _blur};
_blur ppEffectAdjust[10];
_blur ppEffectCommit 0;
_blur ppEffectAdjust[0];
_blur ppEffectCommit 5;
waitUntil{ppEffectCommitted _blur};
_blur ppEffectEnable false;
ppEffectDestroy _blur;};};}];