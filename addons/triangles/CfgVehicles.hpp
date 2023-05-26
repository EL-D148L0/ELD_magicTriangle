
#include "basicDefines_A3.hpp"
class CfgVehicles
{
	
	class Rocks_base_F;

	class PathObject: Rocks_base_F {
		displayName			= "path test object";			
		scope				= public;
		model				= QPATHTOF(data\path.p3d);	/// simple path to model

	};
	class Triangle_base: Rocks_base_F
	{
		scope				= private;										/// makes the lamp invisible in editor
		scopeCurator		= private;							/// makes the lamp visible in Zeus
		displayName			= "Magic Triangle";									/// displayed in Editor
		
		autocenter = false;
		//model				= \magicTriangle\Triangl.p3d;	/// simple path to model
		hiddenSelections[] = {"camo"}; /// what selection in model could have different textures
		hiddenSelectionsTextures[] = {QPATHTOF(data\uvcheck.paa)}; /// what texture is going to be used
	
		armor				= 5000;	/// just some protection against missiles, collisions and explosions

		class Hitpoints {};
		class AnimationSources {
			class Corner_1_UD_source
			{
				source = "user"; // "user" = custom source = not controlled by some engine value
				initPhase = 0; // Initial value of animations based on this source
				animPeriod = 1; // Coefficient for duration of change of this animation
				sound = "GenericDoorsSound"; /// Selects sound class from CfgAnimationSourceSounds that is going to be used for sounds of doors
			};
			class Corner_1_LR_source
			{
				source = "user"; // "user" = custom source = not controlled by some engine value
				initPhase = 0; // Initial value of animations based on this source
				animPeriod = 1; // Coefficient for duration of change of this animation
				sound = "GenericDoorsSound"; /// Selects sound class from CfgAnimationSourceSounds that is going to be used for sounds of doors
			};
			class Corner_1_FB_source
			{
				source = "user"; // "user" = custom source = not controlled by some engine value
				initPhase = 0; // Initial value of animations based on this source
				animPeriod = 1; // Coefficient for duration of change of this animation
				sound = "GenericDoorsSound"; /// Selects sound class from CfgAnimationSourceSounds that is going to be used for sounds of doors
			};
			class Corner_2_UD_source
			{
				source = "user"; // "user" = custom source = not controlled by some engine value
				initPhase = 0; // Initial value of animations based on this source
				animPeriod = 1; // Coefficient for duration of change of this animation
				sound = "GenericDoorsSound"; /// Selects sound class from CfgAnimationSourceSounds that is going to be used for sounds of doors
			};
			class Corner_2_LR_source
			{
				source = "user"; // "user" = custom source = not controlled by some engine value
				initPhase = 0; // Initial value of animations based on this source
				animPeriod = 1; // Coefficient for duration of change of this animation
				sound = "GenericDoorsSound"; /// Selects sound class from CfgAnimationSourceSounds that is going to be used for sounds of doors
			};
			class Corner_2_FB_source
			{
				source = "user"; // "user" = custom source = not controlled by some engine value
				initPhase = 0; // Initial value of animations based on this source
				animPeriod = 1; // Coefficient for duration of change of this animation
				sound = "GenericDoorsSound"; /// Selects sound class from CfgAnimationSourceSounds that is going to be used for sounds of doors
			};
			class Corner_3_UD_source
			{
				source = "user"; // "user" = custom source = not controlled by some engine value
				initPhase = 0; // Initial value of animations based on this source
				animPeriod = 1; // Coefficient for duration of change of this animation
				sound = "GenericDoorsSound"; /// Selects sound class from CfgAnimationSourceSounds that is going to be used for sounds of doors
			};
			class Corner_3_LR_source
			{
				source = "user"; // "user" = custom source = not controlled by some engine value
				initPhase = 0; // Initial value of animations based on this source
				animPeriod = 1; // Coefficient for duration of change of this animation
				sound = "GenericDoorsSound"; /// Selects sound class from CfgAnimationSourceSounds that is going to be used for sounds of doors
			};
			class Corner_3_LR_source_FB_source
			{
				source = "user"; // "user" = custom source = not controlled by some engine value
				initPhase = 0; // Initial value of animations based on this source
				animPeriod = 1; // Coefficient for duration of change of this animation
				sound = "GenericDoorsSound"; /// Selects sound class from CfgAnimationSourceSounds that is going to be used for sounds of doors
			};
		};
		
	};


    class hsTest: Triangle_base
	{
		displayName			= "hiddenselections test";			
		scope				= public;
		model				= QPATHTOF(data\test\hs.p3d);	/// simple path to model
		hiddenSelections[] = {"camo", "camo2", "camo3"}; /// what selection in model could have different textures
		hiddenSelectionsTextures[] = {QPATHTOF(data\uvcheck.paa), "a3\map_data\gdt_strconcrete_co.paa", "\a3\missions_f_aow\data\img\textures\grass\grass_01_co.paa"}; /// what texture is going to be used
	
	};


	class TriangleNoCollision24OM: Triangle_base
	{
		displayName			= "Magic Triangle (no collision, BBX 24m, origin moved)";			
		scope				= protected;
		model				= QPATHTOF(data\Triangle24OriginMoved.p3d);	/// simple path to model
	
	};
	class UnmodifiedCover0: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\coverUnmodified\cover0.p3d);
    };
	class UnmodifiedCover1: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\coverUnmodified\cover1.p3d);
    };
	class ELD_cover_0P0009438416449404352_0P04343722427630684: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P0009438416449404352_0P04343722427630684.p3d);
    };
    class ELD_cover_0P04332611957114163_0P29116161578269617: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P04332611957114163_0P29116161578269617.p3d);
    };
    class ELD_cover_0P04545454545454547_0P04545454545454547: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P04545454545454547_0P04545454545454547.p3d);
    };
    class ELD_cover_0P04545454545454547_0P13636363636363635: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P04545454545454547_0P13636363636363635.p3d);
    };
    class ELD_cover_0P04545454545454547_0P2272727272727273: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P04545454545454547_0P2272727272727273.p3d);
    };
    class ELD_cover_0P08085496998194208_0P3939192985791677: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P08085496998194208_0P3939192985791677.p3d);
    };
    class ELD_cover_0P13636363636363635_0P04545454545454547: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P13636363636363635_0P04545454545454547.p3d);
    };
    class ELD_cover_0P13636363636363635_0P13636363636363635: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P13636363636363635_0P13636363636363635.p3d);
    };
    class ELD_cover_0P13636363636363635_0P2272727272727273: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P13636363636363635_0P2272727272727273.p3d);
    };
    class ELD_cover_0P13636363636363635_0P3181818181818182: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P13636363636363635_0P3181818181818182.p3d);
    };
    class ELD_cover_0P13636363636363635_0P40909090909090906: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P13636363636363635_0P40909090909090906.p3d);
    };
    class ELD_cover_0P13636363636363635_0P5: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P13636363636363635_0P5.p3d);
    };
    class ELD_cover_0P17469273875016822_0P5646839155919902: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P17469273875016822_0P5646839155919902.p3d);
    };
    class ELD_cover_0P2272727272727273_0P04545454545454547: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P2272727272727273_0P04545454545454547.p3d);
    };
    class ELD_cover_0P2272727272727273_0P13636363636363635: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P2272727272727273_0P13636363636363635.p3d);
    };
    class ELD_cover_0P2272727272727273_0P2272727272727273: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P2272727272727273_0P2272727272727273.p3d);
    };
    class ELD_cover_0P2272727272727273_0P3181818181818182: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P2272727272727273_0P3181818181818182.p3d);
    };
    class ELD_cover_0P2272727272727273_0P40909090909090906: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P2272727272727273_0P40909090909090906.p3d);
    };
    class ELD_cover_0P2272727272727273_0P5: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P2272727272727273_0P5.p3d);
    };
    class ELD_cover_0P2272727272727273_0P5909090909090909: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P2272727272727273_0P5909090909090909.p3d);
    };
    class ELD_cover_0P2501621446349076_0P6616216370868464: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P2501621446349076_0P6616216370868464.p3d);
    };
    class ELD_cover_0P3181818181818182_0P04545454545454547: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P3181818181818182_0P04545454545454547.p3d);
    };
    class ELD_cover_0P3181818181818182_0P13636363636363635: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P3181818181818182_0P13636363636363635.p3d);
    };
    class ELD_cover_0P3181818181818182_0P2272727272727273: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P3181818181818182_0P2272727272727273.p3d);
    };
    class ELD_cover_0P3181818181818182_0P3181818181818182: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P3181818181818182_0P3181818181818182.p3d);
    };
    class ELD_cover_0P3181818181818182_0P40909090909090906: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P3181818181818182_0P40909090909090906.p3d);
    };
    class ELD_cover_0P3181818181818182_0P5: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P3181818181818182_0P5.p3d);
    };
    class ELD_cover_0P3181818181818182_0P5909090909090909: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P3181818181818182_0P5909090909090909.p3d);
    };
    class ELD_cover_0P3181818181818182_0P6818181818181819: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P3181818181818182_0P6818181818181819.p3d);
    };
    class ELD_cover_0P3383783629131536_0P7498378553650925: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P3383783629131536_0P7498378553650925.p3d);
    };
    class ELD_cover_0P40909090909090906_0P04545454545454547: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P40909090909090906_0P04545454545454547.p3d);
    };
    class ELD_cover_0P40909090909090906_0P13636363636363635: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P40909090909090906_0P13636363636363635.p3d);
    };
    class ELD_cover_0P40909090909090906_0P2272727272727273: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P40909090909090906_0P2272727272727273.p3d);
    };
    class ELD_cover_0P40909090909090906_0P3181818181818182: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P40909090909090906_0P3181818181818182.p3d);
    };
    class ELD_cover_0P40909090909090906_0P40909090909090906: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P40909090909090906_0P40909090909090906.p3d);
    };
    class ELD_cover_0P40909090909090906_0P5: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P40909090909090906_0P5.p3d);
    };
    class ELD_cover_0P40909090909090906_0P5909090909090909: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P40909090909090906_0P5909090909090909.p3d);
    };
    class ELD_cover_0P40909090909090906_0P6818181818181819: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P40909090909090906_0P6818181818181819.p3d);
    };
    class ELD_cover_0P40909090909090906_0P7727272727272727: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P40909090909090906_0P7727272727272727.p3d);
    };
    class ELD_cover_0P43531608440800984_0P8253072612498318: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P43531608440800984_0P8253072612498318.p3d);
    };
    class ELD_cover_0P5_0P04545454545454547: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P5_0P04545454545454547.p3d);
    };
    class ELD_cover_0P5_0P13636363636363635: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P5_0P13636363636363635.p3d);
    };
    class ELD_cover_0P5_0P2272727272727273: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P5_0P2272727272727273.p3d);
    };
    class ELD_cover_0P5_0P3181818181818182: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P5_0P3181818181818182.p3d);
    };
    class ELD_cover_0P5_0P40909090909090906: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P5_0P40909090909090906.p3d);
    };
    class ELD_cover_0P5_0P5: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P5_0P5.p3d);
    };
    class ELD_cover_0P5_0P5909090909090909: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P5_0P5909090909090909.p3d);
    };
    class ELD_cover_0P5_0P6818181818181819: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P5_0P6818181818181819.p3d);
    };
    class ELD_cover_0P5_0P7727272727272727: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P5_0P7727272727272727.p3d);
    };
    class ELD_cover_0P49999999999999994_0P8660254037844387: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P49999999999999994_0P8660254037844387.p3d);
    };
    class ELD_cover_0P5909090909090909_0P04545454545454547: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P5909090909090909_0P04545454545454547.p3d);
    };
    class ELD_cover_0P5909090909090909_0P13636363636363635: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P5909090909090909_0P13636363636363635.p3d);
    };
    class ELD_cover_0P5909090909090909_0P2272727272727273: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P5909090909090909_0P2272727272727273.p3d);
    };
    class ELD_cover_0P5909090909090909_0P3181818181818182: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P5909090909090909_0P3181818181818182.p3d);
    };
    class ELD_cover_0P5909090909090909_0P40909090909090906: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P5909090909090909_0P40909090909090906.p3d);
    };
    class ELD_cover_0P5909090909090909_0P5: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P5909090909090909_0P5.p3d);
    };
    class ELD_cover_0P5909090909090909_0P5909090909090909: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P5909090909090909_0P5909090909090909.p3d);
    };
    class ELD_cover_0P5909090909090909_0P6818181818181819: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P5909090909090909_0P6818181818181819.p3d);
    };
    class ELD_cover_0P5909090909090909_0P7727272727272727: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P5909090909090909_0P7727272727272727.p3d);
    };
    class ELD_cover_0P5646839155919902_0P8253072612498318: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P5646839155919902_0P8253072612498318.p3d);
    };
    class ELD_cover_0P6818181818181819_0P04545454545454547: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P6818181818181819_0P04545454545454547.p3d);
    };
    class ELD_cover_0P6818181818181819_0P13636363636363635: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P6818181818181819_0P13636363636363635.p3d);
    };
    class ELD_cover_0P6818181818181819_0P2272727272727273: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P6818181818181819_0P2272727272727273.p3d);
    };
    class ELD_cover_0P6818181818181819_0P3181818181818182: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P6818181818181819_0P3181818181818182.p3d);
    };
    class ELD_cover_0P6818181818181819_0P40909090909090906: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P6818181818181819_0P40909090909090906.p3d);
    };
    class ELD_cover_0P6818181818181819_0P5: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P6818181818181819_0P5.p3d);
    };
    class ELD_cover_0P6818181818181819_0P5909090909090909: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P6818181818181819_0P5909090909090909.p3d);
    };
    class ELD_cover_0P6818181818181819_0P6818181818181819: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P6818181818181819_0P6818181818181819.p3d);
    };
    class ELD_cover_0P6616216370868464_0P7498378553650925: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P6616216370868464_0P7498378553650925.p3d);
    };
    class ELD_cover_0P7727272727272727_0P04545454545454547: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P7727272727272727_0P04545454545454547.p3d);
    };
    class ELD_cover_0P7727272727272727_0P13636363636363635: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P7727272727272727_0P13636363636363635.p3d);
    };
    class ELD_cover_0P7727272727272727_0P2272727272727273: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P7727272727272727_0P2272727272727273.p3d);
    };
    class ELD_cover_0P7727272727272727_0P3181818181818182: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P7727272727272727_0P3181818181818182.p3d);
    };
    class ELD_cover_0P7727272727272727_0P40909090909090906: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P7727272727272727_0P40909090909090906.p3d);
    };
    class ELD_cover_0P7727272727272727_0P5: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P7727272727272727_0P5.p3d);
    };
    class ELD_cover_0P7727272727272727_0P5909090909090909: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P7727272727272727_0P5909090909090909.p3d);
    };
    class ELD_cover_0P7498378553650924_0P6616216370868464: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P7498378553650924_0P6616216370868464.p3d);
    };
    class ELD_cover_0P8636363636363636_0P04545454545454547: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P8636363636363636_0P04545454545454547.p3d);
    };
    class ELD_cover_0P8636363636363636_0P13636363636363635: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P8636363636363636_0P13636363636363635.p3d);
    };
    class ELD_cover_0P8636363636363636_0P2272727272727273: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P8636363636363636_0P2272727272727273.p3d);
    };
    class ELD_cover_0P8636363636363636_0P3181818181818182: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P8636363636363636_0P3181818181818182.p3d);
    };
    class ELD_cover_0P8636363636363636_0P40909090909090906: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P8636363636363636_0P40909090909090906.p3d);
    };
    class ELD_cover_0P8636363636363636_0P5: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P8636363636363636_0P5.p3d);
    };
    class ELD_cover_0P8253072612498318_0P5646839155919902: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P8253072612498318_0P5646839155919902.p3d);
    };
    class ELD_cover_0P9545454545454546_0P04545454545454547: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P9545454545454546_0P04545454545454547.p3d);
    };
    class ELD_cover_0P9545454545454546_0P13636363636363635: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P9545454545454546_0P13636363636363635.p3d);
    };
    class ELD_cover_0P9545454545454546_0P2272727272727273: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P9545454545454546_0P2272727272727273.p3d);
    };
    class ELD_cover_0P9191450300180579_0P3939192985791677: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P9191450300180579_0P3939192985791677.p3d);
    };
    class ELD_cover_0P9990561583550596_0P04343722427630684: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P9990561583550596_0P04343722427630684.p3d);
    };
    class ELD_cover_0P9566738804288584_0P29116161578269617: Triangle_base {
        scope = protected;
        model = QPATHTOF(data\gen1\cover_0P9566738804288584_0P29116161578269617.p3d);
    };


	
	
};