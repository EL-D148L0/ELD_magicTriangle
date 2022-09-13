#include "script_component.hpp"
params ["_trenchObject"];


private _minBBoxSize = 1.5;


private _cellsize = getTerrainInfo#2;
private _bbx = boundingBoxReal _trenchObject;
private _p1 = _bbx # 0;
private _p2 = _bbx # 1;




_p2 set [2, _p1 # 2];

//experimental
// works for now
private _padding = 0.3 * _cellsize;
_p1 = _p1 vectordiff [_padding, _padding, 0];
_p2 = _p2 vectoradd [_padding, _padding, 0];

//experimental end

private _xWidth = (_p2 # 0) - (_p1 # 0);
private _yWidth = (_p2 # 1) - (_p1 # 1);





if (_xWidth < (_minBBoxSize * _cellsize)) then {
	_diff = ((_minBBoxSize * _cellsize) - _xWidth) / 2;
	_p1 set [0, _p1 # 0 - _diff];
	_p2 set [0, _p2 # 0 + _diff];
};

if (_yWidth < (_minBBoxSize * _cellsize)) then {
	_diff = ((_minBBoxSize * _cellsize) - _yWidth) / 2;
	_p1 set [1, _p1 # 1 - _diff];
	_p2 set [1, _p2 # 1 + _diff];
};

private _bbxCenter  = ((_p1) vectoradd (_p2)) vectorMultiply 0.5;
private _bbxCenterWorld = _trenchObject modelToWorldWorld _bbxCenter;

//_p1r = _trenchObject modelToWorldWorld _p1;
//_p2r = _trenchObject modelToWorldWorld _p2;


private _area = [_bbxCenterWorld, abs (_p1 # 0 - _bbxCenter # 0), abs (_p1 # 1 - _bbxCenter # 1), getdir _trenchObject, true, -1];




private _bbsr = _bbx # 2;



_bbxCenterWorld apply {round (_x / _cellsize)} params ["_x0", "_y0"];
private _step = ceil(_bbsr / _cellsize) + 1;


private _pointsToModify = [];
//hint "BOING!!";

for "_x" from (_x0 - _step) to (_x0 + _step) do {
	for "_y" from (_y0 - _step) to (_y0 + _step) do {
		private _pos1 = [_x, _y] vectorMultiply _cellsize;	
		if (_pos1 inArea _area) then {
			_pointsToModify append [ + _pos1];
		};
	};
};

//experimental new part
/*private _interestingTerrainLines = [];
for "_x" from ((_x0 - _step) - 1) to (_x0 + _step) do {
	for "_y" from ((_y0 - _step) - 1) to (_y0 + _step) do {
		private _pos1 = [_x, _y] vectorMultiply _cellsize;	
		private _pos2 = [_x + 1, _y] vectorMultiply _cellsize;	
		private _pos3 = [_x, _y + 1] vectorMultiply _cellsize;	
		_interestingTerrainLines append [[_pos1, _pos2], [_pos1, _pos3], [_pos2, _pos3]];
	};
};

*/


//[_x0, _y0];
_pointsToModify;