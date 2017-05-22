//CONFIGURATIONS:
/////////////////
//CHANNELS:			Channel# enableChannel [CHAT,VOICE]
//GLOBAL: 0 | SIDE: 1 | COMMAND: 2 | GROUP: 3 | VEHICLE: 4 | DIRECT: 5 | 6-15 = Custom Channels
r_CH=[1,2,3,4];//Channels for radio effects 			>> Default: [1,2,3,4]
r_glCH=[FALSE,FALSE];//Global Channel Chat/Voice Allow  >> Default: [FALSE,FALSE]
r_sCH=[TRUE,TRUE];//Side Channel Chat/Voice Allow  		>> Default: [FALSE,TRUE]
r_cCH=[TRUE,TRUE];//Command Channel Chat/Voice Allow  	>> Default: [TRUE,TRUE]
r_grCH=[FALSE,TRUE];//Group Channel Chat/Voice Allow  	>> Default: [FALSE,TRUE]
r_vCH=[TRUE,TRUE];//Vehicle Channel Chat/Voice Allow  	>> Default: [TRUE,TRUE]
r_dCH=[FALSE,TRUE];//Direct Channel Chat/Voice Allow  	>> Default: [FALSE,TRUE]



//THE SCRIPT: (Do not edit below!)
//////////////////////
AFAR_sfx=[["in1"],["in2"],["out1"],["fuz1"],["fuz2"],["fuz3"],["fuz4"],["fuz5"],["fuz6"],["fuz7"],["fuz8"]];
r_rEH=[];//ARRAY: Handle list of radio eventHandlers to remove
Fuzz={//FUNCTION: Global radio noise based on distance between sender/closest receiver
if(player==_this select 0)exitWith{};//<-- CREDIT: rob223344
if("ItemRadio" in assignedItems player&&isAbleToBreathe player)then{
private["_plAFAR","_dlAFAR","_dAFAR","_c","_cN","_f","_d0"];
_plAFAR=[];_dlAFAR=[];
{if(player distance _x<r_WS)then{_plAFAR set[(count _plAFAR),_x];};}forEach allPlayers-[player];
{_dAFAR=player distance _x;_dlAFAR set[(count _dlAFAR),_dAFAR];}forEach _plAFAR;_cN=0;_cN=count _plAFAR;_c=[];_f="";
if(_cN==0)exitWith{};
{if((alive _x)&&(side player==side _x))then{_c set[(count _c),_x];};}forEach _plAFAR;
_c=_c select 0;
//if(currentChannel==4&&isNull objectParent player)exitWith{};//Vehicle Channel Check
//if(currentChannel==3&&group player!=group _this select 0)exitWith{};//Group Channel Check
//if(currentChannel==2&&leader player!=leader group player)exitWith{};//Command Channel Check
if(currentChannel in r_CH)then{
_d0=player distance _c;
if(surfaceIsWater getPos player)then{
if(!isNull objectParent player)then{
_f="Land_HelipadEmpty_F" createVehicleLocal getPosASLW vehicle player;_f attachTo[vehicle player,[0,0,0.5]];}else{
_f="Land_HelipadEmpty_F" createVehicleLocal getPosASLW player;_f attachTo[player,[-0.08,0.35,0.005],"Neck"];};}else{
if(!isNull objectParent player)then{
_f="Land_HelipadEmpty_F" createVehicleLocal getPosATL vehicle player;_f attachTo[vehicle player,[0,0,0.5]];}else{
_f="Land_HelipadEmpty_F" createVehicleLocal getPosATL player;_f attachTo[player,[-0.08,0.35,0.005],"Neck"];};};

switch(true)do{
case(_d0>=0&&{_d0<150}):{playSound "in1";while{!isNull _f}do{_f say2D "fuz1";sleep 5;};};
case(_d0>150&&{_d0<300}):{playSound "in1";while{!isNull _f}do{_f say2D "fuz2";sleep 5;};};
case(_d0>300&&{_d0<450}):{playSound "in1";while{!isNull _f}do{_f say2D "fuz3";sleep 5;};};
case(_d0>450&&{_d0<600}):{playSound "in1";while{!isNull _f}do{_f say2D "fuz4";sleep 5;};};
case(_d0>600&&{_d0<750}):{playSound "in1";while{!isNull _f}do{_f say2D "fuz5";sleep 5;};};
case(_d0>750&&{_d0<900}):{playSound "in1";while{!isNull _f}do{_f say2D "fuz6";sleep 5;};};
case(_d0>900&&{_d0<1050}):{playSound "in1";while{!isNull _f}do{_f say2D "fuz7";sleep 5;};};
case(_d0>1050&&{_d0<2000}):{playSound "in1";while{!isNull _f}do{_f say2D "fuz8";sleep 5;};};
};};};};



//FUNCTION: Silence global radio noise + remove getInMan/OutMan eventHandlers
Hush={if(!isNull objectParent player)then{
{if(_x isKindOf "Land_HelipadEmpty_F")then{detach _x;deleteVehicle _x;};}forEach attachedObjects vehicle player;}else{
{if(_x isKindOf "Land_HelipadEmpty_F")then{detach _x;deleteVehicle _x;};}forEach attachedObjects player;};hintSilent"";
{player removeEventHandler["GetInMan",_x];vehicle player removeEventHandler["GetInMan",_x];
player removeEventHandler["GetOutMan",_x];vehicle player removeEventHandler["GetOutMan",_x];}forEach r_rEH;r_rEH resize 0;};



//FUNCTION: Sender client-side effects for pressing radio key
rIn={
if!(currentChannel in r_CH)exitWith{};if(playersNumber playerSide<2)exitWith{0 enableChannel false;1 enableChannel r_sCH;2 enableChannel false;3 enableChannel false;};
if("ItemRadio" in assignedItems player)then{
if(!isAbleToBreathe player&&surfaceIsWater getPos player)then{0 enableChannel false;1 enableChannel false;2 enableChannel false;3 enableChannel false;5 enableChannel false;};
if(alive player&&isAbleToBreathe player&&incapacitatedState player=="")then{
_plAFAR=[];_dlAFAR=[];
{if((alive _x)&&(side player==side _x)&&(player distance _x<=2000))then{_plAFAR set[(count _plAFAR),_x];};}forEach allPlayers-[player];
{_dAFAR=player distance _x;_dlAFAR set[(count _dlAFAR),_dAFAR];}forEach _plAFAR;
if(count _plAFAR>0)then{_c=_plAFAR select 0;_d1=player distance _c;
0 enableChannel r_glCH;1 enableChannel r_sCH;2 enableChannel r_cCH;3 enableChannel r_grCH;5 enableChannel r_dCH;
switch(true)do{
case(_d1>=0&&{_d1<150}):{hintSilent"Transmitting...";playSound "in1";};
case(_d1>150&&{_d1<300}):{hintSilent"Transmitting...";playSound "in1";};
case(_d1>300&&{_d1<450}):{hintSilent"Transmitting...";playSound "in1";};
case(_d1>450&&{_d1<600}):{hintSilent"Transmitting...";playSound "in1";};
case(_d1>600&&{_d1<750}):{hintSilent"Transmitting...";playSound "in1";};
case(_d1>750&&{_d1<900}):{hintSilent"Transmitting...";playSound "in1";};
case(_d1>900&&{_d1<1050}):{hintSilent"Transmitting...";playSound "in1";};
case(_d1>1050&&{_d1<2000}):{0 enableChannel false;1 enableChannel r_sCH;2 enableChannel false;3 enableChannel false;hintSilent"v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^";playSound "in1";};
case(_d1>=2000):{0 enableChannel false;1 enableChannel r_sCH;2 enableChannel false;3 enableChannel false;hintSilent"-----------------------------------------------------";playSound "in2";};
default{0 enableChannel false;1 enableChannel r_sCH;2 enableChannel false;3 enableChannel false;4 enableChannel r_vCH;hintSilent"-----------------------------------------------------";playSound "in2";};};
_plAFAR=[];_dlAFAR=[];_dAFAR=[];_c="";_d1=0;};
}else{0 enableChannel false;1 enableChannel r_sCH;2 enableChannel false;3 enableChannel false;4 enableChannel r_vCH;hintSilent"-----------------------------------------------------";playSound "in2";};
if(!isNull objectParent player)then{
_r="Land_PortableLongRangeRadio_F" createVehicleLocal getPos vehicle player;_r attachTo[vehicle player,[0,0,0.5]];_r setVectorUp[0,0,0.005];}else{
_r="Land_PortableLongRangeRadio_F" createVehicleLocal getPos player;_r attachTo[player,[-0.08,0.35,0.005],"Neck"];_r setVectorUp[0,-1,0.005];};
_rEH=player addEventHandler["GetInMan",{
if(surfaceIsWater getPos player)then{
if(!isNull objectParent player)then{
_r=nearestObjects[getPosASLW vehicle player,["Land_PortableLongRangeRadio_F","Land_HelipadEmpty_F"],9];{detach _x;_x attachTo[vehicle player,[-0.08,0.35,0.005],"Neck"];_x setVectorUp[0,-1,0.005];}forEach _r;}else{
_r=nearestObjects[getPosASLW player,["Land_PortableLongRangeRadio_F","Land_HelipadEmpty_F"],9];{detach _x;_x attachTo[player,[-0.08,0.35,0.005],"Neck"];_x setVectorUp[0,-1,0.005];}forEach _r;};};
if(!isNull objectParent player)then{
_r=nearestObjects[getPosATL vehicle player,["Land_PortableLongRangeRadio_F","Land_HelipadEmpty_F"],9];{detach _x;_x attachTo[vehicle player,[0,0,0.5]];_x setVectorUp[0,-1,0.005];}forEach _r;}else{
_r=nearestObjects[getPosATL player,["Land_PortableLongRangeRadio_F","Land_HelipadEmpty_F"],9];{detach _x;_x attachTo[player,[-0.08,0.35,0.005],"Neck"];_x setVectorUp[0,-1,0.005];}forEach _r;};}];

_rEH=player addEventHandler["GetOutMan",{
if(surfaceIsWater getPos player)then{
if(!isNull objectParent player)then{
_r=nearestObjects[getPosASLW vehicle player,["Land_PortableLongRangeRadio_F","Land_HelipadEmpty_F"],9];{detach _x;_x attachTo[vehicle player,[0,0,0.5]];_x setVectorUp[0,-1,0.005];}forEach _r;}else{
_r=nearestObjects[getPosASLW player,["Land_PortableLongRangeRadio_F","Land_HelipadEmpty_F"],9];{detach _x;_x attachTo[player,[-0.08,0.35,0.005],"Neck"];_x setVectorUp[0,-1,0.005];}forEach _r;};};
if(!isNull objectParent player)then{
_r=nearestObjects[getPosATL vehicle player,["Land_PortableLongRangeRadio_F","Land_HelipadEmpty_F"],9];{detach _x;_x attachTo[vehicle player,[0,0,0.5]];_x setVectorUp[0,-1,0.005];}forEach _r;}else{
_r=nearestObjects[getPosATL player,["Land_PortableLongRangeRadio_F","Land_HelipadEmpty_F"],9];{detach _x;_x attachTo[player,[-0.08,0.35,0.005],"Neck"];_x setVectorUp[0,-1,0.005];}forEach _r;};}];
r_rEH set[count r_rEH,_rEH];[player]remoteExec["Fuzz",0];
waitUntil{!(isNull(findDisplay 46))};
(findDisplay 46)DisplayRemoveEventHandler["KeyUp",kpOut];
(findDisplay 46)DisplayRemoveEventHandler["KeyDown",kpIn];
kpOut=(findDisplay 46)displayAddEventHandler["KeyUp","if((inputAction""PushToTalk""<2)&&{(inputAction""PushToTalkGroup""<2)&&(inputAction""PushToTalkSide""<2)&&(inputAction""PushToTalkVehicle""<2)})then{[player]call rOut;}"];};};



//FUNCTION: Ends radio transmission with a bleep
rOut={
if!(currentChannel in r_CH)exitWith{};if(playersNumber playerSide<2)exitWith{0 enableChannel false;1 enableChannel r_sCH;2 enableChannel false;3 enableChannel false;};
if("ItemRadio" in assignedItems player&&alive player&&isAbleToBreathe player&&incapacitatedState player=="")then{
private["_plAFAR","_dlAFAR","_dAFAR","_cN"];
_plAFAR=[];_dlAFAR=[];
{if((alive _x)&&(side player==side _x)&&(player distance _x<=2000))then{_plAFAR set[(count _plAFAR),_x];};}forEach allPlayers-[player];
{_dAFAR=player distance _x;_dlAFAR set[(count _dlAFAR),_dAFAR];}forEach _plAFAR;//To Do: Only players in range hear out1
"out1"remoteExec["playSound",0];[player]remoteExec["Hush",0];
if(!isNull objectParent player)then{
{if(_x isKindOf "Land_PortableLongRangeRadio_F")then{detach _x;deleteVehicle _x;};}forEach attachedObjects vehicle player;}else{
{if(_x isKindOf "Land_PortableLongRangeRadio_F")then{detach _x;deleteVehicle _x;};}forEach attachedObjects player;};
waitUntil{!(isNull(findDisplay 46))};
(findDisplay 46)DisplayRemoveEventHandler["KeyUp",kpOut];
(findDisplay 46)DisplayRemoveEventHandler["KeyDown",kpIn];
kpIn=(findDisplay 46)displayAddEventHandler["KeyDown","if((inputAction""PushToTalk"">0)||(inputAction""PushToTalkGroup"">0)||(inputAction""PushToTalkSide"">0)||(inputAction""PushToTalkVehicle"">0))then{[player]call rIn;};"];};};



//INIT FUNCTION: Initializes AFAR script functions
initAFAR={
//Sets up channels
0 enableChannel r_glCH;1 enableChannel r_sCH;2 enableChannel r_cCH;3 enableChannel r_grCH;4 enableChannel r_vCH;5 enableChannel r_dCH;6 enableChannel true;setCurrentChannel 5;

//EVENTHANDLER: If player gets rid of radio, he cannot send/recieve transmissions
player addEventHandler["Put",{if((_this select 2=="ItemRadio")&&{!("ItemRadio" in assignedItems player)})then{
0 enableChannel false;1 enableChannel false;2 enableChannel false;3 enableChannel false;}else{
0 enableChannel r_glCH;1 enableChannel r_sCH;2 enableChannel r_cCH;3 enableChannel r_grCH;5 enableChannel r_dCH;};}];

//EVENTHANDLERS: Adds inputAction eventHandler to call rIn and rOut functions upon keyPress/keyRelease
waitUntil{!(isNull(findDisplay 46))};
kpIn=(findDisplay 46)displayAddEventHandler["KeyDown","if((inputAction""PushToTalk"">0)||(inputAction""PushToTalkGroup"">0)||(inputAction""PushToTalkSide"">0)||(inputAction""PushToTalkVehicle"">0))then{[player]call rIn;};"];
kpOut=(findDisplay 46)displayAddEventHandler["KeyUp","if((inputAction""PushToTalk""<2)&&{(inputAction""PushToTalkGroup""<2)&&(inputAction""PushToTalkSide""<2)&&(inputAction""PushToTalkVehicle""<2)})then{[player]call rOut;};"];//add semicolon at end

//BRIEFING: Helpful information / instructions for AFAR
player createDiarySubject["Arma Radio","ArmA Radio"];
player createDiaryRecord["Arma Radio",["Instructions Manual","
<font face='PuristaMedium' size=30 shadow='5' color='#808000'>ADDON-FREE ARMA RADIO</font></size><b/><br/>Created by Phronk<br/>
<font face='PuristaMedium' size=12 color='#8E8E8E'>__________________________________</font></size><br/><br/>
<font face='PuristaMedium' size=20 color='#808000'>RADIO SETUP</font></size><br/>
    • PUSH TO TALK key to chat via radio comms<br/><br/>
     1. Open the in-game menu and go into 'Configure/Controls/Multiplayer'<br/><br/>
     2. Set your PUSH TO TALK or TALK ON GROUP CHANNEL key<br/><br/>
     3. Set your TALK ON DIRECT CHANNEL key to whatever you prefer<br/><br/>
    • WHISPER/SHOUT:  Adjust MICROPHONE volume slider in AUDIO settings<br/>
    • LISTEN VOLUME:  Adjust VON volume slider in AUDIO settings<br/><br/>

<font face='PuristaMedium' size=20 color='#808000'>OPERATING RADIO</font></size><br/>
• PUSH TO TALK key(s) is the radio comms key<br/><br/>
• Radio comms channels are <font color='#fffaa3'>COMMAND</font>, <font color='#b6f442'>GROUP</font>, and <font color='#f4c542'>VEHICLE</font><br/><br/>
• Radio must be equipped to send/recieve transmissions<br/><br/>
• You must be within 1050m of another friendly soldier with a radio<br/><br/>
• Radio static intensifies every 150m away from closest recieving soldier<br/><br/>
• Only squad leaders can communicate via <font color='#fffaa3'>Command Channel</font><br/><br/>
• Only squadmates can communicate via <font color='#b6f442'>Group Channel</font><br/><br/>
• Only vehicle passengers can communicate via <font color='#f4c542'>Vehicle Channel</font><br/><br/>
• Cannot speak via <font color='#ffffff'>Direct Channel</font> while underwater<br/><br/>
• Cannot communicate via radio if underwater without rebreather<br/><br/>
• Cannot communicate via radio if incapacitated or dead<br/><br/>
• Cannot communicate via radio comms channels if outside radio range<br/><br/><br/>

<font face='PuristaMedium' size=20 color='#808000'>CREDITS</font></size><br/>
    • RADIO SCRIPT:  Phronk<br/>
    • RADIO MODEL:  Bohemia Interactive<br/>
    • RADIO AUDIO:  Bohemia Interactive"]];};

/*	Script Version: 0.3
	SCRIPT BY: Phronk
	CONTRIBUTIONS:
1. rob223344 fixed sender hearing his own radio noise
2. Killzone_Kid fixed server globally distribute AFAR variable, in init.sqf
3. Larrow helped improve radio keybind detection (inputAction)
*/