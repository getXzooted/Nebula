!>-------------------------------------------------------------------------------
!!
{
"FUNCTION": "CHECK_EVENT$(EVENT$)",
"DESCRIPTION":
"
USE THIS FUNCTION TO CHECK FOR (EVENT$)
RETURNS 'TRUE' OR 'FALSE' IF IT OCCURED
"
}
!!


FN.DEF CHECK_EVENT$(EVENT$)

   BUNDLE.GET         1,    "EVENT HERIZON",    EVENTS
   BUNDLE.GET    EVENTS,           "EVENTS",    EVENTS
   
   LIST.SIZE     EVENTS,        TOTAL_EVENTS
   
   IF TOTAL_EVENTS > 0
      LIST.SEARCH   EVENTS,              EVENT$,   EXISTS
   END IF

   IF EXISTS <> 0
      FN.RTN "TRUE"
   ELSE
      FN.RTN "FALSE"
   END IF 

FN.END