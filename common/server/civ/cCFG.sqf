private["_parameters"];
_parameters=[
["UNIT_CLASSES",["C_man_1"]],
["UNITS_PER_BUILDING",0.1],
["MAX_GROUPS_COUNT",12],
["MIN_SPAWN_DISTANCE",300],
["MAX_SPAWN_DISTANCE",700],
["BLACKLIST_MARKERS",["BL_Mkr0","BL_Mkr1"]],
["HIDE_BLACKLIST_MARKERS",true],
["ON_UNIT_SPAWNED_CALLBACK",{}],
["ON_UNIT_REMOVE_CALLBACK",{true}],
["DEBUG",false]];
_parameters spawn civs_StartCivilians;