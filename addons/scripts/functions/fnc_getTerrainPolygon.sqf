#include "script_component.hpp"

/*
 * Author: EL_D148L0
 * returns the polygon that marks the outline of the hole in the terrain specified by the points of terrain locations.
 * behaviour currently undefined for unconnected terrain holes.
 *
 * Arguments:
 *	0: array of positions in format position2d or 3d <ARRAY>
 * 		lowered terrain points
 *	1: array in format position2d or 3d <ARRAY> (optional, defaults to one of the eastmost points)
 * 		position to start looking at
 *	2: number in 0-5 <NUMBER> (optional, default 1)
 * 		direction to start looking in. an empty point has to be in that direction. 
 * 		directions as follows: 
 *  		0: NORTH
 *  		1: EAST
 *  		2: SOUTHEAST
 *  		3: SOUTH
 *  		4: WEST
 *  		5: NORTHWEST
 * 
 *
 * Return Value:
 * array of corner positions in format position2d <ARRAY>
 *		
 *
 * Example:
 * [[_pos1, _pos2], _pos1, 0] call ELD_magicTriangle_scripts_fnc_getTerrainPolygon;
 *
 * Public: No
 */


scopename "getTerrainPolygon";

params ["_positions", ["_currentPoint", "DEFAULT"], ["_currentDir", 1]];


// N, E, SE, S, W, NW
private _directions = [[0,GVAR(cellSize)], [GVAR(cellSize), 0], [GVAR(cellSize),-GVAR(cellSize)], [0,-GVAR(cellSize)],[-GVAR(cellSize),0],[-GVAR(cellSize),GVAR(cellSize)]];


private _polygon = [];

if (!(_currentPoint isEqualType [])) then { // find eastmost point
	_currentPoint = _positions#0;
	{
		if (_currentPoint#0 < _x#0) then {
			_currentPoint = _x;
		};
	} forEach _positions;
};
private _startPoint = _currentPoint;

private _currentCheckedPos = _currentPoint vectorAdd _directions#_currentDir;
if ([_currentCheckedPos, _positions] call FUNC(pointInList2d)) throw "an empty point yhould be in the starting direction";
_polygon pushBack _currentCheckedPos;


private _iteratingDir = _currentDir;

// iterate backwards
while {true} do {
	_iteratingDir = (_iteratingDir + 5) % 6; // dir - 1 , but i do +5 to not get negative indices
	if (_iteratingDir == _currentDir) then {	
		(_polygon apply {[_x # 0, _x # 1]}) breakOut "getTerrainPolygon"; // if there's no neighboring points and a full loop has been completed
	};
	_currentCheckedPos = _currentPoint vectorAdd _directions#_iteratingDir;
	if ([_currentCheckedPos, _positions] call FUNC(pointInList2d)) then {
		break;
	} else {
		_polygon insert [0, [_currentCheckedPos], false];
	};
};

private _startDir = (_iteratingDir + 1) % 6;

_iteratingDir = _currentDir;
// iterate forwards
while {true} do {
	_iteratingDir = (_iteratingDir + 1) % 6; // iterate 
	_currentCheckedPos = _currentPoint vectorAdd _directions#_iteratingDir;
	if ([_currentCheckedPos, _positions] call FUNC(pointInList2d)) then {
		_currentPoint = _currentCheckedPos;
		_currentDir = (_iteratingDir + 4) % 6; // set the starting dir
		_iteratingDir = _currentDir;
		if (([_currentPoint, [_startPoint]] call FUNC(pointInList2d))&& _iteratingDir == _startdir) then {
			break;
		};
	} else {
		_polygon pushBack _currentCheckedPos;
	};
};




_polygon apply {[_x # 0, _x # 1]}; // return as 2d positions

