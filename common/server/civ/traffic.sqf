civTraffic_GetParamValue={
private["_params","_key"];
private["_value"];
_params=_this select 0;
_key=_this select 1;
_value=if(count _this>2)then{_this select 2}else{objNull};
{if(_x select 0==_key)then{_value=_x select 1;};}forEach(_params);
_value
};

civTraffic_MarkerExists={
private["_exists","_marker"];
_marker=_this select 0;
_exists=false;
if(((getMarkerPos _marker)select 0)!=0 || ((getMarkerPos _marker)select 1!=0))then{_exists=true;};
_exists
};

civTraffic_PositionIsInsideMarker={
private["_markerName","_pos"];
private["_isInside","_px","_py","_mpx","_mpy","_msx","_msy","_ma","_xmin","_xmax","_ymin","_ymax","_rpx","_rpy","_res"];

_pos=_this select 0;
_markerName=_this select 1;
_px=_pos select 0;
_py=_pos select 1;
_mpx=(getMarkerPos _markerName)select 0;
_mpy=(getMarkerPos _markerName)select 1;
_msx=(getMarkerSize _markerName)select 0;
_msy=(getMarkerSize _markerName)select 1;
_ma= -(markerDir _markerName);
_xmin=_mpx-_msx;
_xmax=_mpx+_msx;
_ymin=_mpy-_msy;
_ymax=_mpy+_msy;

//Now, rotate point to investigate around markers center in order to check against a nonrotated marker
_rpx=((_px-_mpx)*cos(_ma))+((_py-_mpy)*sin(_ma))+_mpx;
_rpy=(-(_px-_mpx)*sin(_ma))+((_py-_mpy)*cos(_ma))+_mpy;
_isInside=false;

if(markerShape _markerName=="RECTANGLE")then{
if(((_rpx>_xmin)&&(_rpx<_xmax))&&((_rpy>_ymin)&&(_rpy<_ymax)))then{_isInside=true;};
};

if(markerShape _markerName=="ELLIPSE")then{
_res=(((_rpx-_mpx)^2)/(_msx^2))+(((_rpy-_mpy)^2)/(_msy^2));
if(_res<1)then{_isInside=true;};
};
_isInside
};