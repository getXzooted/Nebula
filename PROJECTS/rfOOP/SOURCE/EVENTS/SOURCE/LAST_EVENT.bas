
!>-------------------------------------------------------------------------------
!!
{
"FUNCTION": "LAST_EVENT$()",
"DESCRIPTION":
"
USE THIS FUNCTION TO LOAD THE LAST 
EVENT INTO A {STRING} TYPE VARIABLE
"
}
!!


FN.DEF LAST_EVENT$()

   BUNDLE.GET         1,    "EVENT HERIZON",    EVENTS
   BUNDLE.GET    EVENTS,           "EVENTS",    EVENTS

   LIST.SIZE     EVENTS,        TOTAL_EVENTS
   
   IF TOTAL_EVENTS > 0
      LIST.GET EVENTS, TOTAL_EVENTS, LAST_EVENT$
   END IF 
   
   FN.RTN LAST_EVENT$

FN.END
