
class Cfg3DEN
{
	class EventHandlers
	{
		class ELD_magicTriangle
		{
			OnMissionSave = "call ELD_magicTriangle_scripts_fnc_3DENMissionSave;";
			OnMissionAutosave = "call ELD_magicTriangle_scripts_fnc_3DENMissionSave;";
			OnMissionPreview = "diag_log 'OnMissionPreview EH config'; _this call ELD_magicTriangle_scripts_fnc_3DENMissionPreview;";
			OnMissionPreviewEnd = "diag_log 'OnMissionPreviewEnd EH config'; call (uiNamespace getVariable 'ELD_magicTriangle_scripts_fnc_3DENMissionPreviewEnd');";
			// <handlerName> = <handlerExpression>
		};
	};
};