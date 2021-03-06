#if !defined(using_map_DATUM)

	#include "../../mods/misc/mundane.dm"
	#include "../../mods/corporate/_corporate.dme"

	// Tethys Edit
	#include "../../tethys/mods/machine/_machine.dme"
//	#include "../../tethys/mods/europa_floors/_europa_floors.dme"

	#include "bearcat_unit_testing.dm"

	#include "../../code/datums/music_tracks/businessend.dm"
	#include "../../code/datums/music_tracks/salutjohn.dm"

	#include "bearcat_areas.dm"
	#include "bearcat_jobs.dm"
	#include "bearcat_lobby.dm"
	#include "bearcat_shuttles.dm"
	#include "bearcat_outfits.dm"
	#include "bearcat_overmap.dm"
	#include "bearcat_overrides.dm"
	#include "bearcat_loadouts.dm"
	#include "bearcat-1.dmm"
	#include "bearcat-2.dmm"

	#define using_map_DATUM /datum/map/bearcat

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Bearcat

#endif
