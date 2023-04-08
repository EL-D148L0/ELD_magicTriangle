
class CfgVehicles
{
	class Rocks_base_F;
	class Trench_base: Rocks_base_F
	{
		autocenter = false;

		armor				= 5000;	/// just some protection against missiles, collisions and explosions
		
		
		class Attributes // Entity attributes have no categories, they are all defined directly in class Attributes
		{
			class Rank
			{
				//--- Mandatory properties
				displayName = "Trench Rank"; // Name assigned to UI control class Title
				tooltip = "Configure all the things!"; // Tooltip assigned to UI control class Title
				property = "trenchRank"; // Unique config property name saved in SQM
				control = "Edit"; // UI control base class displayed in Edit Attributes window, points to Cfg3DEN >> Attributes

				// Expression called when applying the attribute in Eden and at the scenario start
				// The expression is called twice - first for data validation, and second for actual saving
				// Entity is passed as _this, value is passed as _value
				// %s is replaced by attribute config name. It can be used only once in the expression
				// In MP scenario, the expression is called only on server.
				expression = "_this setVariable ['rank',_value];";

				// Expression called when custom property is undefined yet (i.e., when setting the attribute for the first time)
				// Entity (unit, group, marker, comment etc.) is passed as _this
				// Returned value is the default value
				// Used when no value is returned, or when it is of other type than NUMBER, STRING or ARRAY
				// Custom attributes of logic entities (e.g., modules) are saved always, even when they have default value
				defaultValue = "-1";

				//--- Optional properties
				unique = 0; // When 1, only one entity of the type can have the value in the mission (used for example for variable names or player control)
				typeName = "NUMBER"; // Defines data type of saved value, can be STRING, NUMBER or BOOL. Used only when control is "Combo", "Edit" or their variants
			};
			class Neighbors
			{
				//--- Mandatory properties
				displayName = "Neighbor Rank List"; // Name assigned to UI control class Title
				tooltip = "Configure all the things!"; // Tooltip assigned to UI control class Title
				property = "neighborRanks"; // Unique config property name saved in SQM
				control = "Edit"; // UI control base class displayed in Edit Attributes window, points to Cfg3DEN >> Attributes

				expression = "_this setVariable ['%s',_value];";

				defaultValue = "str ((getArray ((configOf _trench) >> 'trench_sides_open')) apply {[-1, -1]})";

				//--- Optional properties
				unique = 0; // When 1, only one entity of the type can have the value in the mission (used for example for variable names or player control)
				typeName = "STRING"; // Defines data type of saved value, can be STRING, NUMBER or BOOL. Used only when control is "Combo", "Edit" or their variants
			};
		};
		
		class EventHandlers;
		class EventHandlers: EventHandlers {
			init = "diag_log 'trench init'; _this call (uiNamespace getVariable 'ELD_magicTriangle_scripts_fnc_initTrench');";
			dragged3DEN = "_this call ELD_magicTriangle_scripts_fnc_3DENUpdateTrench;";
			unregisteredFromWorld3DEN = "_this call ELD_magicTriangle_scripts_fnc_3DENUnregisterTrench;";
			registeredToWorld3DEN = "_this call ELD_magicTriangle_scripts_fnc_3DENReregisterTrench";
		};

		
		
	};
	class Tronch_new_core: Trench_base
	{
		scope				= 2;										/// makes the lamp invisible in editor
		scopeCurator		= 2;											/// makes the lamp visible in Zeus
		displayName			= "Tronch new core";
		model				= QPATHTOF(data\core.p3d);	/// simple path to model
		
		// in clockwise order
		trench_corners_clockwise[] = {"Corner_1_1", "Corner_1_2", "Corner_2_2", "Corner_2_1"};
		//in clockwise order, starting with the side after the first corner
		trench_sides_open[] = {0, 0, 0, 0}; // 0 for false, 1 for true;
		trench_sides_open_positions[] = {"", "", "", ""}; // content doesn't matter on sides that have open=0
		trench_sides_diggable[] = {1, 1, 1, 1};
		trench_sides_dig_replacement[] = {"Tronch_new_end", "Tronch_new_end", "Tronch_new_end", "Tronch_new_end"};
		trench_sides_dig_replacement_vector_dir[] = {{1,0,0}, {0,-1,0}, {-1,0,0}, {0,1,0}};
		trench_sides_dig_replacement_side_switching[] = {{1,2,3,0}, {2,3,0,1}, {3,0,1,2}, {0,1,2,3}}; // if the sides are (0,1,2,3) before switching, they will be after:
		
		
		trench_sides_dig_new_trench_options[] = {{"Tronch_new_end"}, {"Tronch_new_end"}, {"Tronch_new_end"}, {"Tronch_new_end"}};// arrays so that i can add more styles as well as triangles later
		//only trenches with one open side are supported for new trench options
		trench_sides_dig_new_trench_options_pos[] = {{{0,3,0}}, {{3,0,0}}, {{0,-3,0}}, {{-3,0,0}}}; //relative position the new trench object will be in
		trench_sides_dig_new_trench_options_dir[] = {{{-1,0,0}}, {{0,1,0}}, {{1,0,0}}, {{0,-1,0}}}; //relative direction the new trench object will be facing in
		
		
		
	};
	
	class Tronch_new_end: Trench_base
	{
		scope				= 2;										/// makes the lamp invisible in editor
		scopeCurator		= 2;											/// makes the lamp visible in Zeus
		displayName			= "Tronch new end";
		model				= QPATHTOF(data\end.p3d);	/// simple path to model
		
		
		// in clockwise order
		trench_corners_clockwise[] = {"Corner_1_1", "Corner_1_2", "Corner_2_2", "Corner_2_1"};
		//in clockwise order, starting with the side after the first corner
		trench_sides_open[] = {0, 0, 0, 1}; // 0 for false, 1 for true;
		trench_sides_open_positions[] = {"Border_1", "Border_2", "Border_3", "Border_4"}; // content doesn't matter on sides that have open=0, mempoints are named what's in here + _pos, _dir, _up
		trench_sides_diggable[] = {1, 1, 1, 0};
		trench_sides_dig_replacement[] = {"Tronch_new_corner", "Tronch_new_straight", "Tronch_new_corner", ""};
		trench_sides_dig_replacement_vector_dir[] = {{1,0,0}, {0,1,0}, {0,1,0}, {}};
		trench_sides_dig_replacement_side_switching[] = {{1,2,3,0}, {0,1,2,3}, {0,1,2,3}, {}}; // if the sides are (0,1,2,3) before switching, they will be after:
		
		
		trench_sides_dig_new_trench_options[] = {{"Tronch_new_end"}, {"Tronch_new_end"}, {"Tronch_new_end"}, {"Tronch_new_end"}};// arrays so that i can add more styles as well as triangles later
		//only trenches with one open side are supported for new trench options
		trench_sides_dig_new_trench_options_pos[] = {{{0,3,0}}, {{3,0,0}}, {{0,-3,0}}, {{-3,0,0}}}; //relative position the new trench object will be in
		trench_sides_dig_new_trench_options_dir[] = {{{-1,0,0}}, {{0,1,0}}, {{1,0,0}}, {{0,-1,0}}}; //relative direction the new trench object will be facing in
		
		
	};
	
	class Tronch_new_straight: Trench_base
	{
		scope				= 2;										/// makes the lamp invisible in editor
		scopeCurator		= 2;											/// makes the lamp visible in Zeus
		displayName			= "Tronch new straight";
		model				= QPATHTOF(data\straight.p3d);	/// simple path to model
		
		
		// in clockwise order
		trench_corners_clockwise[] = {"Corner_1_1", "Corner_1_2", "Corner_2_2", "Corner_2_1"};
		//in clockwise order, starting with the side after the first corner
		trench_sides_open[] = {0, 1, 0, 1}; // 0 for false, 1 for true;
		trench_sides_open_positions[] = {"Border_1", "Border_2", "Border_3", "Border_4"}; // content doesn't matter on sides that have open=0, mempoints are named what's in here + _pos, _dir, _up
		trench_sides_diggable[] = {1, 0, 1, 0};
		trench_sides_dig_replacement[] = {"Tronch_new_tjunction", "", "Tronch_new_tjunction", ""};
		trench_sides_dig_replacement_vector_dir[] = {{0,-1,0}, {}, {0,1,0}, {}};
		trench_sides_dig_replacement_side_switching[] = {{2,3,0,1}, {}, {0,1,2,3}, {}}; // if the sides are (0,1,2,3) before switching, they will be after:
		
		
		trench_sides_dig_new_trench_options[] = {{"Tronch_new_end"}, {"Tronch_new_end"}, {"Tronch_new_end"}, {"Tronch_new_end"}};// arrays so that i can add more styles as well as triangles later
		//only trenches with one open side are supported for new trench options
		trench_sides_dig_new_trench_options_pos[] = {{{0,3,0}}, {{3,0,0}}, {{0,-3,0}}, {{-3,0,0}}}; //relative position the new trench object will be in
		trench_sides_dig_new_trench_options_dir[] = {{{-1,0,0}}, {{0,1,0}}, {{1,0,0}}, {{0,-1,0}}}; //relative direction the new trench object will be facing in
	};
	
	class Tronch_new_corner: Trench_base
	{
		scope				= 2;										/// makes the lamp invisible in editor
		scopeCurator		= 2;											/// makes the lamp visible in Zeus
		displayName			= "Tronch new corner";
		model				= QPATHTOF(data\corner.p3d);	/// simple path to model
		
		// in clockwise order
		trench_corners_clockwise[] = {"Corner_1_1", "Corner_1_2", "Corner_2_2", "Corner_2_1"};
		//in clockwise order, starting with the side after the first corner
		trench_sides_open[] = {0, 0, 1, 1}; // 0 for false, 1 for true;
		trench_sides_open_positions[] = {"Border_1", "Border_2", "Border_3", "Border_4"}; // content doesn't matter on sides that have open=0, mempoints are named what's in here + _pos, _dir, _up
		trench_sides_diggable[] = {1, 1, 0, 0};
		trench_sides_dig_replacement[] = {"Tronch_new_tjunction", "Tronch_new_tjunction", "", ""};
		trench_sides_dig_replacement_vector_dir[] = {{1,0,0}, {0,1,0}, {}, {}};
		trench_sides_dig_replacement_side_switching[] = {{1,2,3,0}, {0,1,2,3}, {}, {}}; // if the sides are (0,1,2,3) before switching, they will be after:
		
		
		trench_sides_dig_new_trench_options[] = {{"Tronch_new_end"}, {"Tronch_new_end"}, {"Tronch_new_end"}, {"Tronch_new_end"}};// arrays so that i can add more styles as well as triangles later
		//only trenches with one open side are supported for new trench options
		trench_sides_dig_new_trench_options_pos[] = {{{0,3,0}}, {{3,0,0}}, {{0,-3,0}}, {{-3,0,0}}}; //relative position the new trench object will be in
		trench_sides_dig_new_trench_options_dir[] = {{{-1,0,0}}, {{0,1,0}}, {{1,0,0}}, {{0,-1,0}}}; //relative direction the new trench object will be facing in
	};
	class Tronch_new_tjunction: Trench_base
	{
		scope				= 2;										/// makes the lamp invisible in editor
		scopeCurator		= 2;											/// makes the lamp visible in Zeus
		displayName			= "Tronch new tjunction";
		model				= QPATHTOF(data\tjunction.p3d);	/// simple path to model
		
		// in clockwise order
		trench_corners_clockwise[] = {"Corner_1_1", "Corner_1_2", "Corner_2_2", "Corner_2_1"};
		//in clockwise order, starting with the side after the first corner
		trench_sides_open[] = {0, 1, 1, 1}; // 0 for false, 1 for true;
		trench_sides_open_positions[] = {"Border_1", "Border_2", "Border_3", "Border_4"}; // content doesn't matter on sides that have open=0, mempoints are named what's in here + _pos, _dir, _up
		trench_sides_diggable[] = {1, 0, 0, 0};
		trench_sides_dig_replacement[] = {"Tronch_new_xjunction", "", "", ""};
		trench_sides_dig_replacement_vector_dir[] = {{0,1,0}, {}, {}, {}};
		trench_sides_dig_replacement_side_switching[] = {{0,1,2,3}, {}, {}, {}}; // if the sides are (0,1,2,3) before switching, they will be after:
		
		
		trench_sides_dig_new_trench_options[] = {{"Tronch_new_end"}, {"Tronch_new_end"}, {"Tronch_new_end"}, {"Tronch_new_end"}};// arrays so that i can add more styles as well as triangles later
		//only trenches with one open side are supported for new trench options
		trench_sides_dig_new_trench_options_pos[] = {{{0,3,0}}, {{3,0,0}}, {{0,-3,0}}, {{-3,0,0}}}; //relative position the new trench object will be in
		trench_sides_dig_new_trench_options_dir[] = {{{-1,0,0}}, {{0,1,0}}, {{1,0,0}}, {{0,-1,0}}}; //relative direction the new trench object will be facing in
	};
	
	
	class Tronch_new_xjunction: Trench_base
	{
		scope				= 2;										/// makes the lamp invisible in editor
		scopeCurator		= 2;											/// makes the lamp visible in Zeus
		displayName			= "Tronch new xjunction";
		model				= QPATHTOF(data\xjunction.p3d);	/// simple path to model
		

		// in clockwise order
		trench_corners_clockwise[] = {"Corner_1_1", "Corner_1_2", "Corner_2_2", "Corner_2_1"};
		//in clockwise order, starting with the side after the first corner
		trench_sides_open[] = {1, 1, 1, 1}; // 0 for false, 1 for true;
		trench_sides_open_positions[] = {"Border_1", "Border_2", "Border_3", "Border_4"}; // content doesn't matter on sides that have open=0, mempoints are named what's in here + _pos, _dir, _up
		trench_sides_diggable[] = {0, 0, 0, 0};
		trench_sides_dig_replacement[] = {"", "", "", ""};
		trench_sides_dig_replacement_vector_dir[] = {{}, {}, {}, {}};
		trench_sides_dig_replacement_side_switching[] = {{}, {}, {}, {}}; // if the sides are (0,1,2,3) before switching, they will be after:
		
		
		trench_sides_dig_new_trench_options[] = {{"Tronch_new_end"}, {"Tronch_new_end"}, {"Tronch_new_end"}, {"Tronch_new_end"}};// arrays so that i can add more styles as well as triangles later
		//only trenches with one open side are supported for new trench options
		trench_sides_dig_new_trench_options_pos[] = {{{0,3,0}}, {{3,0,0}}, {{0,-3,0}}, {{-3,0,0}}}; //relative position the new trench object will be in
		trench_sides_dig_new_trench_options_dir[] = {{{-1,0,0}}, {{0,1,0}}, {{1,0,0}}, {{0,-1,0}}}; //relative direction the new trench object will be facing in
	};
	
	
	
	
};