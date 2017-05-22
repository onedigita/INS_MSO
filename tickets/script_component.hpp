
#define ADDON INS
#define COMPONENT tickets
#define PREFIX INS

#ifdef DEBUG_ENABLED_TICKETS
	#define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_TICKETS
	#define DEBUG_SETTINGS DEBUG_SETTINGS_TICKETS
#endif

#include "\x\cba\addons\main\script_macros_common.hpp"