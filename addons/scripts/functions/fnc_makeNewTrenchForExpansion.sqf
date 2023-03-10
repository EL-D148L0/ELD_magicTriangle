#include "script_component.hpp"

/*
 * Author: EL_D148L0
 * creates and returns a new trench for expanding a trench according to config.
 * does not initialize the new trench. does not change anything on the graph.
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
 * newTrench <OBJECT>
 *		the new trench
 *
 * Example:
 * [_tronch1, 1 , 0] call ELD_magicTriangle_scripts_fnc_makeNewTrenchForExpansion;
 *
 * Public: No
 */



params ["_trench", "_direction", ["_option", 0]];

//if (!isNull (_trench getVariable "sides") # _direction) exitWith {false};// if the trench has no space in that direction return false

if (((getArray ((configOf _trench) >> "trench_sides_diggable")) # _direction) == 0) throw "impossible request to expand";//if the trench cant be dug in the requested direction


private _newTrenchClass = ((getArray ((configOf _trench) >> "trench_sides_dig_new_trench_options")) # _direction # _option);
private _newTrenchRelPos = ((getArray ((configOf _trench) >> "trench_sides_dig_new_trench_options_pos")) # _direction # _option);
private _newTrenchRelDir = ((getArray ((configOf _trench) >> "trench_sides_dig_new_trench_options_dir")) # _direction # _option);



private _newTrench = createVehicle [_newTrenchClass, _trench, [], 0, "CAN_COLLIDE"];
_newTrench setPosASL (_trench modelToWorldWorld _newTrenchRelPos);
_newTrench setVectorDir (_trench vectorModelToWorld _newTrenchRelDir);
_newTrench setVectorUp (vectorUp _trench);







_newTrench;
