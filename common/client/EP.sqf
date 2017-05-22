sepa=["<t color='#ffff33'>Put in earplugs</t>",{
_u=_this select 1;
_i=_this select 2;
if(soundVolume==1)then{
1 fadeSound 0.25;1 fadeSpeech 0.25;
_u setUserActionText[_i,"<t color='#ffff33'>Take out earplugs</t>"]}else{
1 fadeSound 1;1 fadeSpeech 1;
_u setUserActionText[_i,"<t color='#ffff33'>Put in earplugs</t>"]}
},[],-90,false,true,"","_target==vehicle player"];
player addAction sepa;
player addEventHandler["Respawn",{1 fadeSound 1;1 fadeSpeech 1;(_this select 0)addAction sepa;}];