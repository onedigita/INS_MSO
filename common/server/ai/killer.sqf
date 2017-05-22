if !(isServer)exitWith{};
/*_victim=_this select 0;
_killer=_this select 1; 
_victim removeAllMPEventHandlers "MPKilled";
_sound=selectRandom["kill1","kill2","kill3","kill4","kill5"];
[[_killer,_sound]remoteExec["say3D"]];