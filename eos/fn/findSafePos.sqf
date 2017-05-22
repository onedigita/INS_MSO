_mrk=(_this select 0);
_radveh=(_this select 1);
_pos=[_mkr,true]call SHKpos;
for "_counter" from 0 to 20 do{
_newPos=[_pos,0,_radveh,5,1,20,0]call BIS_fnc_findSafePos;
if((_pos distance _newPos)<(_radveh+5)) 
exitWith{_pos=_newPos;};};
_newPos