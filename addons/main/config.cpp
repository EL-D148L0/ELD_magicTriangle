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
		requiredAddons[] = {"A3_Data_F_AoW_Loadorder", "cba_main", "TerrainLib_main"};
		authors[] = AUTHOR;
        VERSION_CONFIG;
	};
};

#include <Display3DEN.hpp>
