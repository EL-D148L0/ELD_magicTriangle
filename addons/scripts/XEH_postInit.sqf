
#include "script_component.hpp"
diag_log "XEH_POST_INIT!!!";

if (!is3DEN) then {
	if (!is3DENPreview) then {
		private _data = "[]";
		if (fileExists "trenchData.txt") then {_data = loadfile "trenchData.txt";};
		uiNamespace setVariable [QGVAR(trenchData), parseSimpleArray _data];
		diag_log "Loaded trenchData from File";

		diag_log "initializing trenches in postinit";
		call FUNC(missionPlay);
	};
};
