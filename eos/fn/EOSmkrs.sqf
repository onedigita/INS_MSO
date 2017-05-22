_EOSmkrs=server getVariable "EOSmkrs";
{_x setMarkerAlpha(markerAlpha _x);_x setMarkercolor(getMarkerColor _x);}forEach _EOSmkrs;