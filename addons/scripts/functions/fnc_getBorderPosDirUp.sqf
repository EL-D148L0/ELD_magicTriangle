#include "script_component.hpp"

/*
 * Author: EL_D148L0
 * returns the position and vectorDir and vectorUp of the border
 *
 * Arguments:
 *	0: trench <OBJECT>
 *	1: side number to get positions for <NUMBER>
 *	2: use object space <BOOLEAN> (optional, default false)
 * 
 *
 * Return Value:
 * array:
 * 	0: position3d
 *  1: vectorDir
 *  2: vectorUp
 *		
 *
 * Example:
 * [_trench, 2] call ELD_magicTriangle_scripts_fnc_getBorderPosDirUp;
 *
 * Public: No
 */



params ["_trench", "_side", ["_objectSpace", false]];


if (((getArray ((configOf _trench) >> "trench_sides_open")) # _side) == 0) throw "tried to read the position of a side that's not open";//maybe revise both this and the config to allow lookup of diggable sides, would probably be useful for joining out of editor

private _name = ((getArray ((configOf _trench) >> "trench_sides_open_positions")) # _side);

private _pos = _trench selectionPosition (_name + "_pos");
private _dir = _trench selectionPosition (_name + "_dir");
private _up =  _trench selectionPosition (_name + "_up");

private _vecDir = vectorNormalized (_dir vectorDiff _pos);
private _vecUp =  vectorNormalized (_up vectorDiff _pos);


if (_objectSpace) exitWith {
	[_pos, _vecDir, _vecUp];
};

[_trench modelToWorldWorld _pos, _trench vectorModelToWorld _vecDir, _trench vectorModelToWorld _vecUp];