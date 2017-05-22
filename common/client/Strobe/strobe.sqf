waitUntil{!(isNull player)};
waitUntil{time>0};
player addEventHandler["Killed",{strobe=false}];
Strobe=false;
StrobeON={
Strobe=true;
hint "Strobe ON";
_strobeGear=["H_HelmetB_light","H_HelmetB_light_black","H_HelmetB_light_desert","H_HelmetB_light_grass","H_HelmetB_light_sand","H_HelmetB_light_snakeskin"];
while{Strobe}do{
if(vehicle player!=player)then{StrobeOFF}else{
if((headgear player in _strobeGear)||("B_IR_Grenade" in magazines player))then{
sleep 0.9;
IRST="NVG_TargetC" createVehicle getPos player;
IRST attachTo[player,[0,0,0.19],"neck"];
sleep 0.5;
detach IRST;
IRST setPosATL[-10000,-10000,100000];
Sleep 0.5;
IRST attachTo[player,[0,0,0.19],"neck"];
sleep 0.5;
detach IRST;
IRST setPosATL[-10000,-10000,100000];
deleteVehicle IRST;
Sleep 0.1;};};};};
StrobeOFF={
Strobe=false;
hint "Strobe OFF";
detach IRST;
IRST setPosATL[-10000,-10000,100000];
deleteVehicle IRST;};
StrobeMenu={
if(Strobe)exitWith{_handle=createDialog "MS2000_DIALOGON";};
_handle=createDialog "MS2000_DIALOG";};
player addAction["<t shadow='1.5' color=""#e5b348"">IR Strobe</t>",StrobeMenu,1,0,false,false,"","player==_target"];
if(!isServer)exitWith{};