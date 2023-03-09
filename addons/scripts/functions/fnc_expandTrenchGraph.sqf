#include "script_component.hpp"

/*
 * Author: EL_D148L0
 * expands from a trench.
 * adds new trench, switches out old trench and fixes all the data for the graph.
 *
 * Arguments:
 *	0: trench <OBJECT>
 * 		trench to expand from
 *	1: direction <NUMBER>
 * 		direction to expand in (according to trench config)
 *	0: option <NUMBER> (optional, default 0)
 * 		option number of expanded trench from original trench config
 *
 * Return Value:
 * success <BOOLEAN>
 *		if the initialization succeeded
 *
 * Example:
 * [_tronch1, 1 , 0] call ELD_magicTriangle_scripts_fnc_expandTrenchGraph;
 *
 * Public: No
 */



params ["_trench", "_direction", ["_option", 0]];

//if (!isNull (_trench getVariable "sides") # _direction) exitWith {false};// if the trench has no space in that direction return false

if (((getArray ((configOf _trench) >> trench_sides_diggable)) # _direction) == 0) exitWith {diag_log "bad trench expansion request"; false;};//if the trench cant be dug in the requested direction


private _newTrenchClass = ((getArray ((configOf _trench) >> "trench_sides_dig_new_trench_options")) # _direction # _option);
private _newTrenchRelPos = ((getArray ((configOf _trench) >> "trench_sides_dig_new_trench_options_pos")) # _direction # _option);
private _newTrenchRelDir = ((getArray ((configOf _trench) >> "trench_sides_dig_new_trench_options_dir")) # _direction # _option);

private _replacementTrenchClass = ((getArray ((configOf _trench) >> "trench_sides_dig_replacement")) # _direction);
private _replacementTrenchRelDir = ((getArray ((configOf _trench) >> "trench_sides_dig_replacement_vector_dir")) # _direction);
private _replacementTrenchSideSwitchingIndices = ((getArray ((configOf _trench) >> "trench_sides_dig_replacement_side_switching")) # _direction);




private _replacementTrench = createVehicle [_replacementTrenchClass, _trench, [], 0, "CAN_COLLIDE"];
_replacementTrench setPosASL (_trench modelToWorldWorld [0,0,0]);
_replacementTrench setVectorDirAndUp [_trench vectorModelToWorld _replacementTrenchRelDir, vectorUp _trench];



private _newTrench = createVehicle [_newTrenchClass, _trench, [], 0, "CAN_COLLIDE"];
_newTrench setPosASL (_trench modelToWorldWorld _newTrenchRelPos);
_newTrench setVectorDir (_trench vectorModelToWorld _newTrenchRelDir);
_newTrench setVectorUp (vectorUp _trench);



private _replacementTrenchCorners = [_replacementTrench] call FUNC(getTrenchCornersFromConfig);
private _replacementTrenchSides = _trench getVariable "sides";
{
	if (isNull _x) then {continue;};
	private _index = ((_x getVariable "sides") find _trench);
	if (_index == -1) throw "trench graph is broken: neighbor trench has no reference back";
	(_x getVariable "sides") set [_index, _replacementTrench];
} forEach _replacementTrenchSides;
_replacementTrenchSides set [_direction, _newTrench];
private _replacementTrenchSidesNew = [];
{
	_replacementTrenchSidesNew pushBack (_replacementTrenchSides # _x);
} forEach _replacementTrenchSideSwitchingIndices;
_replacementTrenchSides = _replacementTrenchSidesNew;
private _replacementTrenchRank = _trench getVariable "rank";
private _replacementTrenchTerrainPoints = _trench getVariable "terrainPoints";







private _newTrenchRank = GVAR(trenchRankCounter);
GVAR(trenchRankCounter) = GVAR(trenchRankCounter) + 1;

private _newTrenchCorners = [_newTrench] call FUNC(getTrenchCornersFromConfig);
private _newTrenchSides = [];
{
	_newTrenchSides append [objNull];
} forEach _newTrenchCorners;
private _newToOldSide = ((getArray ((configOf _newTrench) >> "trench_sides_open")) find 1);// the open side of the new trench
_newTrenchSides set [_newToOldSide, _replacementTrench];

private _newTrenchTerrainPoints = [_newTrench] call FUNC(makeSingleHole);









_replacementTrench setVariable ["rank", _replacementTrenchRank];
_replacementTrench setVariable ["corners", _replacementTrenchCorners];
_replacementTrench setVariable ["sides", _replacementTrenchSides];
_replacementTrench setVariable ["terrainPoints", _replacementTrenchTerrainPoints];

_newTrench setVariable ["rank", _newTrenchRank];
_newTrench setVariable ["corners", _newTrenchCorners];
_newTrench setVariable ["sides", _newTrenchSides];
_newTrench setVariable ["terrainPoints", _newTrenchTerrainPoints];


GVAR(trenchObjectList) deleteAt (GVAR(trenchObjectList) find _trench);
//GVAR(trenchObjectList) =  GVAR(trenchObjectL_trenchist) - [_trench];

GVAR(trenchObjectList) pushBack _replacementTrench;
GVAR(trenchObjectList) pushBack _newTrench;


deleteVehicle _trench;





true;
