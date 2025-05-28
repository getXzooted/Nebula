!>-------------------------------------------------------------------------------
!!
{
"FUNCTION": "ERROR_EVENT$(EVENT$)",
"ARGS": [{"EVENT$": "STRING"}],
"RETURNS": "NONE",
"DESCRIPTION":
"
FUNCTION IS USED FOR ADDING AN ERROR TO 
THE LIST OF ERRORS IN THE EVENT HORIZON
"
}
!!


FN.DEF ERROR_EVENT$(ERROR_MESSAGE$)

   BUNDLE.GET         1,    "EVENT HERIZON",    EVENTS
   BUNDLE.GET    EVENTS,           "ERRORS",    ERRORS
   
   LIST.ADD      ERRORS,      ERROR_MESSAGE$

FN.END

