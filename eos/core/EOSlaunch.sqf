if(isServer)then{
private["_HPpatrols","_HPgrpProb","_CHgrpArr","_LVgrpArr","_HPgrpArr","_PAgrpArr","_CHgrpSize","_CHGrps","_SVGrps","_AVgrpSize","_AVGrps","_LVGrps","_LVgrpSize","_PAgrpSize","_PApatrols","_HPpatrols","_HPgrpSize"];
_JIPmkr=(_this select 0);
_HouseInf=(_this select 1);
_HPpatrols=_HouseInf select 0;
_HPgrpSize=_HouseInf select 1;
_HPgrpProb=if(count _houseInf>2)then{_houseInf select 2}else{100};

_inf=(_this select 2);
_PApatrols=_inf select 0;
_PAgrpSize=_inf select 1;
_PAgrpProb=if(count _inf>2)then{_inf select 2}else{100};

_LV=(_this select 3);
_LVgrps=_LV select 0;
_LVgrpSize=_LV select 1;
_LVgrpProb=if(count _LV>2)then{_LV select 2}else{100};

_AVgrp=(_this select 4);
_AVgrps=_AVgrp select 0;
_AVgrpProb=if(count _AVgrp>1)then{_AVgrp select 1}else{100};

_SVgrp=(_this select 5);
_SVgrps=_SVgrp select 0;
_SVgrpProb=if(count _SVgrp>1)then{_SVgrp select 1}else{100};

_CHGrp=(_this select 6);
_CHgrps=_CHGrp select 0;
_CHgrpSize=_CHGrp select 1;
_CHgrpProb=if(count _CHGrp>2)then{_CHGrp select 2}else{100};

_setup=(_this select 7);
if(_HPgrpProb>floor random 100)then{
if(_HPgrpSize==0)then{_HPgrpArr=[1,1]};
if(_HPgrpSize==1)then{_HPgrpArr=[2,4]};
if(_HPgrpSize==2)then{_HPgrpArr=[4,8]};
if(_HPgrpSize==3)then{_HPgrpArr=[8,12]};
if(_HPgrpSize==4)then{_HPgrpArr=[12,16]};
if(_HPgrpSize==5)then{_HPgrpArr=[16,20]};
}else{_HPpatrols=0;_HPgrpArr=[1,1];};

if(_PAgrpProb>floor random 100)then{	
if(_PAgrpSize==0)then{_PAgrpArr=[1,1]};
if(_PAgrpSize==1)then{_PAgrpArr=[2,4]};
if(_PAgrpSize==2)then{_PAgrpArr=[4,8]};
if(_PAgrpSize==3)then{_PAgrpArr=[8,12]};
if(_PAgrpSize==4)then{_PAgrpArr=[12,16]};
if(_PAgrpSize==5)then{_PAgrpArr=[16,20]};
}else{_PApatrols=0;_PAgrpArr=[1,1];};	

if(_LVgrpProb>floor random 100)then{	
if(_LVgrpSize==0)then{_LVgrpArr=[0,0]};
if(_LVgrpSize==1)then{_LVgrpArr=[2,4]};
if(_LVgrpSize==2)then{_LVgrpArr=[4,8]};
if(_LVgrpSize==3)then{_LVgrpArr=[8,12]};
if(_LVgrpSize==4)then{_LVgrpArr=[12,16]};
if(_LVgrpSize==5)then{_LVgrpArr=[16,20]};
}else{_LVgrps=0;_LVgrpArr=[0,0];};

if(_AVgrpProb>floor random 100)then{
}else{_AVgrps=0;};

if(_SVgrpProb>floor random 100)then{
}else{_SVgrps=0;};

if(_CHgrpProb>floor random 100)then{
if(_CHgrpSize==0)then{_CHgrpArr=[0,0]};
if(_CHgrpSize==1)then{_CHgrpArr=[2,4]};
if(_CHgrpSize==2)then{_CHgrpArr=[4,8]};
if(_CHgrpSize==3)then{_CHgrpArr=[8,12]};
if(_CHgrpSize==4)then{_CHgrpArr=[12,16]};
if(_CHgrpSize==5)then{_CHgrpArr=[16,20]};
}else{_CHgrps=0;_CHgrpArr=[0,0]};

{_EOSmkrs=server getVariable "EOSmkrs";
if(isNil "_EOSmkrs")then{_EOSmkrs=[];};
_EOSmkrs set[count _EOSmkrs,_x];
server setVariable["EOSmkrs",_EOSmkrs,true];
null=[_x,[_HPpatrols,_HPgrpArr],[_PApatrols,_PAgrpArr],[_LVgrps,_LVgrpArr],[_AVgrps,_SVgrps,_CHgrps,_CHgrpArr],_setup]execVM "eos\core\EOScore.sqf";}forEach _JIPmkr;};