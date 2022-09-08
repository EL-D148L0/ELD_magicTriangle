#include "script_component.hpp"
params ["_tronches"];
private _pointsToModify = [];
{
	//_pointsToModify append ([_x] call FUNC(makeSingleHole));
	_pointsToModify = _pointsToModify + ([_x] call FUNC(makeSingleHole));
} foreach _tronches;
private _pointsToModify2 = [];
{
	//_pointsToModify append ([_x] call FUNC(makeSingleHole));
	_pointsToModify2 pushbackunique _x;
} foreach _pointsToModify;
_pointsToModify2;