!>-------------------------------------------------------------------------------
!!
{
"FUNCTION": "LOG_EVENT$(EVENT$)",
"ARGS": {"EVENT$": "STRING"},
"DESCRIPTION":
"
FUNCTION THAT LOGS AN EVENT 
INSIDE OF THE EVENT HORIZON
"
}
!!


FN.DEF LOG_EVENT$(EVENT$)

   BUNDLE.GET         1,    "EVENT HORIZON",    EVENTS
   BUNDLE.GET    EVENTS,           "EVENTS",    EVENTS
   
   LIST.ADD      EVENTS,              EVENT$
   
FN.END
