#include "script_component.hpp"

/*
 * Author: EL_D148L0
 * returns the polygon that marks the outline of the hole in the terrain specified by the points of terrain locations.
 * behaviour currently undefined for unconnected terrain holes.
 *
 * Arguments:
 *	0: array of positions in format position2d or 3d <ARRAY>
 * 		lowered terrain points
 *	1: array in format position2d or 3d <ARRAY> 
 * 		output of getTerrainPolygon with default arguments
 * 
 *
 * Return Value:
 * array of arrays: <ARRAY>
 *	0: array of positions in format position2d <ARRAY>
 * 		positions that mark islands in the hole
 *	0: array of positions in format position2d <ARRAY>
 * 		positions that are outside of the passed border but in the passed list of positions
 *		
 *
 * Example:
 * [[_pos1, _pos2], _poslist] call ELD_magicTriangle_scripts_fnc_getTerrainHoleIslands;
 *
 * Public: No
 */



params ["_positions", "_outlinePolygon"];


_positions sort true;
//islands cannot have holes

_outlinePolygon = _outlinePolygon apply {[_x # 0, _x # 1, 0]};

// N, E, SE, S, W, NW
private _directions = [[0,GVAR(cellSize)], [GVAR(cellSize), 0], [GVAR(cellSize),-GVAR(cellSize)], [0,-GVAR(cellSize)],[-GVAR(cellSize),0],[-GVAR(cellSize),GVAR(cellSize)]];

private _maxX = _positions#0#0;
private _maxY = _positions#0#1;
private _minX = _positions#0#0;
private _minY = _positions#0#1;
{
	_maxX = _maxX max _x#0;
	_maxY = _maxY max _x#1;
	_minX = _minX min _x#0;
	_minY = _minY min _x#1;
} forEach _positions;

private _IslandPositions = [];
private _outOfBorderPositions = [];

private _inside = [_minX, _minY, 0] inPolygon _outlinePolygon;
private _currentindex = 0;
for [{_posX = _minX}, {_posX <= _maxX + 0.01}, {_posX = _posX + GVAR(cellSize)}] do {
	for [{_posY = _minY}, {_posY <= _maxY + 0.01}, {_posY = _posY + GVAR(cellSize)}] do {
		_inside = [_posX, _posY, 0] inPolygon _outlinePolygon;
		if ([_positions # _currentindex, [[_posX, _posY]]] call FUNC(pointInList2d)) then {
			if (!_inside) then {
				_outOfBorderPositions pushback (_positions # _currentindex);
			};
			_currentindex = _currentindex + 1;
		} else {
			if ((!([[_posX, _posY], _outlinePolygon] call FUNC(pointInList2d))&& _inside)) then {
				_IslandPositions pushBack [_posX, _posY];
			};
		};

	};
};


[ _IslandPositions, _outOfBorderPositions];