#include <\a3\editor_f\Data\Scripts\dikCodes.h>

// #define DEBUG_SYNCHRONOUS
// #include "\x\cba\addons\main\script_macros_common.hpp"
// #include "\x\cba\addons\xeh\script_xeh.hpp"

#include "\z\ace\addons\main\script_macros.hpp"


#ifdef DISABLE_COMPILE_CACHE
    #undef PREP
    #define PREP(fncName) DFUNC(fncName) = compile preprocessFileLineNumbers QPATHTOF(functions\DOUBLES(fnc,fncName).sqf)
#else
    #undef PREP
    #define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction
#endif