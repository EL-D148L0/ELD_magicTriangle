#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * initializes the map of cover Classes and uv coords
 *
 * Arguments:
 * none
 *
 * Return Value:
 * triangle Classes and coords map <HASHMAP>
 *
 * Example:
 * call ELD_magicTriangle_scripts_fnc_getTriangleCoverClassMap;
 *
 * Public: No
 */








private _classes = "'ELD_cover_' in (configName _x)" configClasses (configFile >> "CfgVehicles");

private _points =_classes apply {
	[parseNumber ((((configName _x) regexFind ["(?<=ELD_cover_)[0-9P]+(?=_)",0])#0#0#0) regexreplace ["P","."]), parseNumber ((((configName _x) regexFind ["(?<=_)[0-9P]+",0])#1#0#0) regexreplace ["P","."])];
};

_points createHashMapFromArray (_classes apply {configName _x});


