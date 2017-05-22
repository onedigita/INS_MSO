/*Script by Mphillips'Hazey' + Sacha Ligthert + Phronk

Special Thanks:
ArmA Tactical Combat Applications Group - Tactical Realism http://www.ATCAG.com
Tangodown - Tactical Gaming Community http://www.tangodown.nl/
Whiskey Company - Tactical Realism http://www.TheWhiskeyCo.com/
*/
private["_mkrs","_intelItems","_unit","_pos","_selectedItem","_intel","_cacheHouses","_cities","_multi","_iCount","_tarHouse","_iPos","_i","_m","_j"];
intel=[];publicVariable "intel";
_intelItems=["Land_Laptop_unfolded_F","SatPhone","Land_Suitcase_F","EvMoscow","EvMap","Land_PortableLongRangeRadio_F","Land_MobilePhone_old_F","Land_HandyCam_F","CUP_radio_b"];
_cities=call SL_cityAreas;

_j=0;
{_j=_j+1;
_cityName=_x select 0;
_cityPos=_x select 1;
_cityRadA=_x select 2;
_cityRadB=_x select 3;
_cityType=_x select 4;
_cityAngle=_x select 5;
if(_cityRadB>_cityRadA)then{_cityRadA=_cityRadB;};
_cacheHouses=[_cityPos,_cityRadA]call SL_findHouses;
diag_log format["%4 City: %1,%2,%3",_cityName,_cityRadA,count _cacheHouses,_j];

for "_i" from 0 to(random(paramsArray select 2))step 1 do{
if(count _cacheHouses>0)then{
_selectedItem=selectRandom _intelItems;
_tarHouse=_cacheHouses select(random((count _cacheHouses)-1));
_iPos=[_tarHouse]call SL_randHousePos;
_intel=createVehicle[_selectedItem,[(_iPos select 0),(_iPos select 1),(_iPos select 2+0.07)],[],0,"None"];
[[_intel,"<t color='#FF0000'>Gather INTEL</t>"],"addActionMP",true,true]spawn BIS_fnc_MP;
_intel setPos _iPos;
intel set[count intel,_intel];publicVariable "intel";

if(!isMultiplayer)then{
_m=createMarker[format["box%1",random 1000],getPosATL _intel];
_m setMarkerShape "ICON";_m setMarkerType "mil_dot";_m setMarkerColor "ColorGreen";};
};};}forEach _cities;