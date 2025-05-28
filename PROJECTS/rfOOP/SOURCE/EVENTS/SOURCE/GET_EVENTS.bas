!>-------------------------------------------------------------------------------
!!
{
"FUNCTION": "GET_EVENTS()",
"ARGS": [],
"RETURNS": "STRUCT ID",
"DESCRIPTION":
"
THIS FUNCTION RETURNS THE
EVENT HANDLER EVENTS LIST
"
}
!!


FN.DEF GET_EVENTS()

   BUNDLE.GET         1,    "EVENT HORIZON",    EVENTS
   BUNDLE.GET    EVENTS,           "EVENTS",    EVENTS

   FN.RTN EVENTS

FN.END