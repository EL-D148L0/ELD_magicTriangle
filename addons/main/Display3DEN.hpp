
class ctrlControlsGroupNoScrollbars;
class ctrlCheckboxToolbar;
class Display3DEN {
	class Controls {
		class Toolbar: ctrlControlsGroupNoScrollbars {
			class Controls {
				class Separator1;
				class Separator6: Separator1
				{
					x="34 * 	(	5 * (pixelW * pixelGrid * 	0.50))";
				};
				class TrenchControls: ctrlControlsGroupNoScrollbars
				{
					idc=10093;
					x="34.5 * 	(	5 * (pixelW * pixelGrid * 	0.50))";
					y="1 * (pixelH * pixelGrid * 	0.50)";
					w="1 * 	(	5 * (pixelW * pixelGrid * 	0.50))";
					h="(	5 * (pixelH * pixelGrid * 	0.50))";
					class Controls {
						class TerrainToggle: ctrlCheckboxToolbar {
							idc=HIDE_TOGGLE_IDC;
							onCheckedChanged="call (uiNamespace getVariable 'ELD_magicTriangle_scripts_fnc_3DENHideButtonReact')";
							onLoad="diag_log 'button initialised'";
							tooltip="Toggle Terrain Lowering";
							textureChecked="\x\ELD_magicTriangle\addons\main\icons\dig.paa";
							textureUnchecked="\x\ELD_magicTriangle\addons\main\icons\no_dig.paa";
							textureFocusedChecked="\x\ELD_magicTriangle\addons\main\icons\dig.paa";
							textureFocusedUnchecked="\x\ELD_magicTriangle\addons\main\icons\no_dig.paa";
							textureHoverChecked="\x\ELD_magicTriangle\addons\main\icons\dig.paa";
							textureHoverUnchecked="\x\ELD_magicTriangle\addons\main\icons\no_dig.paa";
							texturePressedChecked="\x\ELD_magicTriangle\addons\main\icons\dig.paa";
							texturePressedUnchecked="\x\ELD_magicTriangle\addons\main\icons\no_dig.paa";
							textureDisabledChecked="\x\ELD_magicTriangle\addons\main\icons\dig.paa";
							textureDisabledUnchecked="\x\ELD_magicTriangle\addons\main\icons\no_dig.paa";
							x="0 * 	(	5 * (pixelW * pixelGrid * 	0.50))";
							y=0;
							h="(	5 * (pixelH * pixelGrid * 	0.50))";
							w="(	5 * (pixelW * pixelGrid * 	0.50))";
						};
					};
				};
			};
		};
	};
};