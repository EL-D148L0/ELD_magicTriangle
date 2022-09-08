
params ["_points"];
// points come in as 2d points

_pointsComp = + _points;
for "_i" from 0 to ((count _pointsComp) - 1) do {(_pointsComp # _i) deleteAt 2;};

_cellsize = getTerrainInfo#2;

_borderpoints = [];
{	
	_tests = [[_x # 0, _x # 1 + _cellsize], [_x # 0 + _cellsize, _x # 1], [_x # 0 + _cellsize, _x # 1 - _cellsize], [_x # 0, _x # 1 - _cellsize], [_x # 0 - _cellsize, _x # 1], [_x # 0 - _cellsize, _x # 1 + _cellsize]];
	{
		//{
		//	
		//} foreach _points;
		if (!(_x in _pointsComp)) then {
			_borderpoints pushbackunique _x;
		};
	} foreach _tests;
	
} foreach _points;

f = + _borderpoints;
s = + _points;

//_borderpoints = _borderpoints - _points;

#include "script_component.hpp"
_borderLines = [];
_borderpointsCompare = + _borderpoints;
{	
	_thisBP = _x;
	_heightThis = getTerrainHeight _x;
	_tests = [[_x # 0, _x # 1 + _cellsize], [_x # 0 + _cellsize, _x # 1], [_x # 0 + _cellsize, _x # 1 - _cellsize], [_x # 0, _x # 1 - _cellsize], [_x # 0 - _cellsize, _x # 1], [_x # 0 - _cellsize, _x # 1 + _cellsize]];
	{
		if ((_x in _borderpointsCompare)) then {
			_height = getTerrainHeight _x;
			_borderLines pushback [(_x + [_height]), (_thisBP + [_heightThis])];
		};
	} foreach _tests;
	_borderpointsCompare = _borderpointsCompare - [_x];
} foreach _borderpoints;

_borderLines;