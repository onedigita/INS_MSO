private["_power","_color","_a2cc"];
params["_unit","_strength"];
if(!(_unit==player))exitWith{};
_a2cc=paramsArray select 9;
if(_unit getVariable "unit_is_unconscious")exitWith{};
if(vehicle _unit==_unit &&{cameraView in["INTERNAL","GUNNER"]})then{
if(_strength<0.2)then{_strength=0.2+(random 0.3)};
if(_strength>5)then{_strength=4+(random 1)};
_power=_strength+4;
addCamShake[_power,0.4,30];
_color=1-_strength;
if(_color<0.15)then{_color=0.15};
"colorCorrections" ppEffectEnable true;
if(_a2cc==1)then{"colorCorrections" ppEffectAdjust[1.0,1.0,0.0,[1.0,1.0,1.0,0.0],[1.0,1.0,0.9,_color],[0.3,0.3,0.3,-0.1]];}else{
"colorCorrections" ppEffectAdjust[1,1,0,[1,1,1,0.0],[1,1,1,_color],[1,1,1,0.0]];};
"colorCorrections" ppEffectCommit 0;
"dynamicBlur" ppEffectEnable true;
"dynamicBlur" ppEffectAdjust[1.8];
"dynamicBlur" ppEffectCommit 0;

if(_a2cc==1)then{"colorCorrections" ppEffectAdjust[0.9,1,0,[0.1,0.1,0.1,-0.1],[1,1,0.8,0.528],[1,0.2,0,0]];}else{
"colorCorrections" ppEffectAdjust[1,1,0,[1,1,1,0.0],[1,1,1,1],[1,1,1,0.0]];};
"colorCorrections" ppEffectCommit _strength;
"dynamicBlur" ppEffectAdjust[0];
"dynamicBlur" ppEffectCommit _strength;};
true