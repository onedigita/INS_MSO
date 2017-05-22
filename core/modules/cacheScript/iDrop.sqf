private["_case","_iPos","_unit"];
_unit=(_this select 0)select 0;
_iPos=[(getPos _unit select 0)+1,(getPos _unit select 1),getPosATL _unit select 2];
_case=createVehicle["Land_PortableLongRangeRadio_F",_iPos,[],0,"None"];
[[_case,"<t color='#FF0000'>Gather INTEL</t>"],"addActionMP",true,true]spawn BIS_fnc_MP;
_case setPos _iPos;