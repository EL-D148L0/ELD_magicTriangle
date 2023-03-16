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






params ["_angle", "_roundUp"];
scopeName "getTriangleColliderModel";

private _files = addonFiles ["magicTriangle\colliderGen0\", ".p3d"];

private _angles = _files apply {
	parseNumber (_x regexFind ["[0-9]*",27]);
};
private _fileList = _angles createHashMapFromArray _files;
private _found = false;
private _return = "";
if (_roundUp) then {
	private _iteratingAngle = ceil _angle;
	while {_iteratingAngle < 90} do {
		if (_iteratingAngle in _fileList) then {
			(_fileList get _iteratingAngle) breakOut "getTriangleColliderModel";
		}; 
		_iteratingAngle = _iteratingAngle + 1;
	};
	
};

_iteratingAngle = floor _angle;
while {_iteratingAngle > 0} do {
	if (_iteratingAngle in _fileList) then {
		(_fileList get _iteratingAngle) breakOut "getTriangleColliderModel";
	}; 
	_iteratingAngle = _iteratingAngle - 1;
};


_iteratingAngle = ceil _angle;
while {_iteratingAngle < 90} do {
	if (_iteratingAngle in _fileList) then {
		(_fileList get _iteratingAngle) breakOut "getTriangleColliderModel";
	}; 
	_iteratingAngle = _iteratingAngle + 1;
};
throw "couldn't find any triangleColliderModel";