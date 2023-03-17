#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * finds the closest triangle collider in the specified direction
 *
 * Arguments:
 * 0: Position of corner in format PositionASL <NUMBER>
 * 1: round up? <BOOLEAN>
 *
 * Return Value:
 * triangle collider model path <STRING>
 *
 * Example:
 * [3, true] call ELD_magicTriangle_scripts_fnc_getTriangleColliderModel;
 *
 * Public: No
 */






params ["_angle"];
scopeName "getTriangleColliderModel";

private _files = addonFiles ["magicTriangle\", ".p3d"];

private _colliderModels = [];
{
	if (_x regexMatch ".*collidergen3\\c[0-9,]+\..*") then {
		_colliderModels pushBack _x;
	};
} forEach _files;
private _angles = _colliderModels apply {
	parseNumber (((_x regexFind ["(?<=c)[0-9,]+(?=\.)",0])# 0#0#0) regexreplace [",","."]);
};
private _fileList = _angles createHashMapFromArray _colliderModels;
private _found = false;
private _return = "";
private _searchNumber = (round (_angle * 100))/100;


if (_searchNumber < 0.01) then {
	_searchNumber = 0.01;
};
if (_searchNumber > 89) then {
	_searchNumber = 89;
};


if (_searchNumber in _fileList) then {
	(_fileList get _searchNumber) breakOut "getTriangleColliderModel";
}; 


throw "couldn't find any triangleColliderModel";