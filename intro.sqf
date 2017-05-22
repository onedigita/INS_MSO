if(isDedicated)exitWith{};
if(hasInterface)then{
private["_cam","_camX","_camY","_camZ","_object"];
titleText["T A K I S T A N   I N S U R G E N C Y","BLACK IN",9999];
waitUntil{!(isNull player)};
sleep .2;
playSound "intro";
_object=camObj;
_camX=getPosATL _object select 0;
_camY=getPosATL _object select 1;
_camZ=getPosATL _object select 2;
_cam="camera" camCreate[_camx-1,_camy+0,_camz+0];
_cam camSetTarget _object;
_cam cameraEffect["Internal","Back"];
_cam camCommit 0;
sleep 3.5;
titleText["Eliminate Taliban rebels and find intel to destroy caches in red grid squares.","BLACK IN",10];
sleep 10;
_cam cameraEffect["Terminate","Back"];
camDestroy _cam;};
if((!isACE)&&{(isAFAR==1)})then{
hintSilent parseText format[
"<t color='#f4c542'>WELCOME!</t><br/>
Head to the weapon racks in the warehouse for your loadout...<br/><br/>
______________<br/>
> 'H' key to holster weapon<br/>
> Set an in-game PUSH TO TALK key<br/>
> Raise your VON / Microphone volumes"];}else{
hintSilent parseText format["<t color='#f4c542'>WELCOME!</t><br/>
Head to the weapon racks in the warehouse for your loadout..."];};