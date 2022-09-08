#include "script_component.hpp"

params ["_p1", "_a", "_b", "_c"];
//private _r1 = (_this # 0) inPolygon [_this # 1, _this # 2, _this # 3];
//private _r2 = ([_p1, _a, _b, _c] call FUNC(sameSide)) && ([_p1, _b, _a, _c] call FUNC(sameSide)) && ([_p1, _c, _a, _b] call FUNC(sameSide));

//if (isNil "_r1") then {msg1 = "WEEWOO";};
//if (isNil "_r2") then {msg1 = "AAAAAAAA";};
//if (_r1 != _r2) then {msg1 = "OOOOOOOOOO"; k = [_p1, _a, _b, _c];};

//_r1;


([_p1, _a, _b, _c] call FUNC(sameSide)) && ([_p1, _b, _a, _c] call FUNC(sameSide)) && ([_p1, _c, _a, _b] call FUNC(sameSide));
//(_this # 0) inPolygon [_this # 1, _this # 2, _this # 3];
