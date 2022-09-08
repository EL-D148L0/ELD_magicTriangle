#include "script_component.hpp"

class CfgPatches
{
	class ADDON
	{
		name = QUOTE(ADDON);
		units[] = 
		{
		};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {QMAIN_ADDON};
		authors[] = AUTHOR;
        VERSION_CONFIG;
	};
};

#include "CfgEventHandlers.hpp"
