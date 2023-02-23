
_biglist = [];

{
	_thislist = _x;
	_list = [];
	{
		_list append [[typeOf _x, getposworld _x, [vectorDir _x, vectorup _x]]];
	} foreach _thislist #0;
	_biglist append [_list];
} foreach ELD_magicTriangle_scripts_coveredTrenchList;
_biglist;

