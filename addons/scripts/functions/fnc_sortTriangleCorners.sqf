#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * returns corners in clockwise order
 *
 * Arguments:
 * 0: Position of corner in format PositionASL <ARRAY>
 * 1: Position of corner in format PositionASL <ARRAY>
 * 2: Position of corner in format PositionASL <ARRAY>
 *
 * Return Value:
 * 0: Position of corner in format PositionASL <ARRAY>
 * 1: Position of corner in format PositionASL <ARRAY>
 * 2: Position of corner in format PositionASL <ARRAY>
 *
 * Example:
 * [[1991.94,5567.88,6.89202],[1994.63,5571.75,6.89802],[1995.49,5567,6.89769]] call ELD_magicTriangle_scripts_fnc_sortTriangleCorners;
 *
 * Public: No
 */




params ["_pos1", "_pos2", "_pos3"];

private _posAVG = ((_pos1) vectorAdd ((_pos2) vectorAdd (_pos3))) vectorMultiply (1/3);



([[_pos1, _pos2, _pos3], [_posAVG], {
	private _diff = _x vectorDiff _input0;
	_diff # 1 atan2 _diff # 0
}, "DESCEND"] call BIS_fnc_sortBy)

//TODO use this function