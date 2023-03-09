#include "script_component.hpp"

/*
 * Author: EL_D148L0
 * returns the polygon that marks the outline of the hole in the terrain specified by the points of terrain locations.
 * behaviour currently undefined for unconnected terrain holes.
 *
 * Arguments:
 *	0: array of positions in format position2d or 3d <ARRAY>
 * 		lowered terrain points
 *
 * Return Value:
 * array of corner positions in format position2d <ARRAY>
 *		
 *
 * Example:
 * [[_pos1, _pos2]] call ELD_magicTriangle_scripts_fnc_getTerrainPolygon;
 *
 * Public: No
 */



params ["_positions"];



private _cellsize = getTerrainInfo#2;

private _polygon = [];

_positions = _positions apply {[_x # 0, _x # 1]}; //TODO rework this, its probably inefficient af
_positions sort false;


private _currentindex = 0;

/*
#define P_NORTH(var) [(var # 0), (var # 1) + _cellsize] 
#define P_EAST(var) [(var # 0) + _cellsize, (var # 1)] 
#define P_SOUTH(var) [(var # 0), (var # 1) - _cellsize] 
#define P_WEST(var) [(var # 0) - _cellsize, (var # 1)] 
#define POINTS_MATCH(var1, var2) ((((var1 # 0) - (var2 # 0)) ^ 2) + (((var1 # 1) - (var2 # 1)) ^ 2)) < 0.001
*/

//_polygon pushBack P_EAST(_positions # _currentindex);
_polygon pushBack [_positions # _currentindex # 0 + _cellsize, _positions # _currentindex # 1];

// N, E, SE, S, W, NW
private _directions = [[0,1], [1, 0], [1,-1], [0,-1],[-1,0],[-1,1]];
private _lastdir = 2;
private _lastpoint = _polygon # 0;

while {true} do {
	_nextdir = (_lastdir + 4) % 6;
	while {true} do {
		_nextpoint = [_lastpoint # 0 + (_directions # _nextdir # 0) * _cellsize, _lastpoint # 1 + (_directions # _nextdir # 1) * _cellsize];
		private _inList = false;
		{
			if (((((_x # 0) - (_nextpoint # 0)) ^ 2) + (((_x # 1) - (_nextpoint # 1)) ^ 2)) < 0.001) then {
				_inList = true;
				break; // this can probably be done better
			};
		} forEach _positions;
		if (_inList) then {
			_nextdir = (_nextdir + 5) % 6;// dir - 1 , but i do +5 to not get negative indices
			break;
		} else {
			_nextdir = (_nextdir + 1) % 6;
		};
		if (_nextdir == ((_lastdir + 3) % 6)) throw "something went wrong";// if the pointer points back at where it came from
	};
	_lastpoint = [_lastpoint # 0 + (_directions # _nextdir # 0) * _cellsize, _lastpoint # 1 + (_directions # _nextdir # 1) * _cellsize];
	if (((((_polygon # 0 # 0) - (_lastpoint # 0)) ^ 2) + (((_polygon # 0 # 1) - (_lastpoint # 1)) ^ 2)) < 0.001) then {
		break;
	};
	_polygon pushBack _lastpoint;
	_lastdir = _nextdir;
};

_polygon;
