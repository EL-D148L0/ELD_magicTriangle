#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;



ADDON = true;



GVAR(coveredTrenchList) = [];



GVAR(trenchRankCounter) = 0;
GVAR(trenchObjectList) = [];

//functionname = QFUNC(fullyInitTrenchesWithIntersect);
// functionname2 = "asadasfasf";