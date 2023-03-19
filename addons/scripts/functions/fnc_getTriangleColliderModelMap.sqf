#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * initializes the map of collider models and angles
 *
 * Arguments:
 * none
 *
 * Return Value:
 * triangle collider models and angles map <HASHMAP>
 *
 * Example:
 * call ELD_magicTriangle_scripts_fnc_getTriangleColliderModelMap;
 *
 * Public: No
 */







private _files = addonFiles ["magicTriangleCollider\", ".p3d"];

private _colliderModels = [];
{
	if (_x regexMatch ".*collidergen4\\c[0-9,]+\..*") then {
		_colliderModels pushBack _x;
	};
} forEach _files;
private _angles = _colliderModels apply {
	parseNumber (((_x regexFind ["(?<=c)[0-9,]+(?=\.)",0])# 0#0#0) regexreplace [",","."]);
};

_angles createHashMapFromArray _colliderModels;


