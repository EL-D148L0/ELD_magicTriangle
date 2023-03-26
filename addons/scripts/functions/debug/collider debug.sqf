
[[1918.08,5537.92,8.35002],[1920,5536,8.59],[1916,5536,8.74]] params ["_pos1", "_pos2", "_pos3"];

private _posAVG = ((_pos1) vectorAdd ((_pos2) vectorAdd (_pos3))) vectorMultiply (1/3);



([[_pos1, _pos2, _pos3], [_posAVG], {
	private _diff = _x vectorDiff _input0;
	_diff # 1 atan2 _diff # 0
}, "DESCEND"] call BIS_fnc_sortBy) params ["_pos1", "_pos2", "_pos3"];



private _longestSide = 0;
private _length0 = _pos1 vectorDistance _pos2;
private _length1 = _pos2 vectorDistance _pos3;
private _length2 = _pos3 vectorDistance _pos1;



private _pointA = [];
private _pointB = [];
private _pointC = [];
private _pointP = [];

if (_length0 >= _length1 && _length0 >= _length2) then {
	//_longestSide = 0;
	_pointA = _pos2;
	_pointC = _pos1;
	_pointB = _pos3;
} else {
	if (_length1 >= _length0 && _length1 >= _length2) then {
		_longestSide = 1;
		_pointA = _pos3;
		_pointC = _pos2;
		_pointB = _pos1;
	} else {
		_longestSide = 2;
		_pointA = _pos1;
		_pointC = _pos3;
		_pointB = _pos2;
	};
};
