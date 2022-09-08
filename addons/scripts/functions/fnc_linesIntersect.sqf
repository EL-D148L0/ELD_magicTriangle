#include "script_component.hpp"

scopename "linesIntersect";
params ["_x1", "_y1", "_x2", "_y2", "_x3", "_y3", "_x4", "_y4"];

//        http://thirdpartyninjas.com/blog/2008/10/07/line-segment-intersection/
// true if intersect, false if no intersect or coincident
// with a bit of extra room for no collision with matching corners

_denominator = ((_y4 - _y3) * (_x2 - _x1)) - ((_x4 - _x3) * (_y2 - _y1));


if (_denominator < 0.0001 && _denominator > -0.0001) then {
	false breakOut "linesIntersect";
	//if (!_coincident) //exitwith {hint "BOING!!"; false};
};


_numerator1 = ((_x4 - _x3) * (_y1 - _y3)) - ((_y4 - _y3) * (_x1 - _x3));
_numerator2 = ((_x2 - _x1) * (_y1 - _y3)) - ((_y2 - _y1) * (_x1 - _x3));

_u1 = _numerator1 / _denominator;
_u2 = _numerator2 / _denominator;

if (0.0001 <= _u1 && _u1 <= 0.9999 && 0.0001 <= _u2 && _u2 <= 0.9999) exitWith {true};

_ac = 100;
_ab = 50;
_bc = 0;




if (_x1 == _x3 && _y1 == _y3) then {
	_ac = [_x1, _y1] distance2D [_x2, _y2]; 
	_ab = [_x1, _y1] distance2D [_x4, _y4]; 
	_bc = [_x4, _y4] distance2D [_x2, _y2]; 
} else {
	if (_x1 == _x4 && _y1 == _y4) then {
		_ac = [_x1, _y1] distance2D [_x2, _y2]; 
		_ab = [_x1, _y1] distance2D [_x3, _y3]; 
		_bc = [_x3, _y3] distance2D [_x2, _y2]; 
	} else {
		if (_x2 == _x3 && _y2 == _y3) then {
			_ac = [_x2, _y2] distance2D [_x1, _y1]; 
			_ab = [_x2, _y2] distance2D [_x4, _y4]; 
			_bc = [_x4, _y4] distance2D [_x1, _y1]; 
		} else {
			if (_x2 == _x4 && _y2 == _y4) then {
				_ac = [_x2, _y2] distance2D [_x1, _y1]; 
				_ab = [_x2, _y2] distance2D [_x3, _y3]; 
				_bc = [_x3, _y3] distance2D [_x1, _y1]; 
			} else {
				false breakOut "linesIntersect";
			};
		};
	};
};

_diff1 = _ac + _bc - _ab;
_diff2 = _ab + _bc - _ac;

//is this shit still needed???

if (_diff1 < 0.02 || _diff2 < 0.02) then {true breakOut "linesIntersect";};

false;