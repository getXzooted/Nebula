!>-------------------------------------------------------------------------------
!!
{
"FUNCTION": "TRIGGER_EVENT$(TRIGGER$)",
"ARGS": [{"TRIGGER$": "STRING"}],
"RETURNS": "NONE",
"DESCRIPTION":
"
USE THIS FUNCTION TO CREATE A NEW TRIGGER FROM 
(TRIGGER$) FOR USE WITH THE ON_EVENT$(TRIGGER$)
"
}
!!


FN.DEF TRIGGER_EVENT$(TRIGGER$)

   BUNDLE.GET         1,    "EVENT HORIZON",    EVENTS
   BUNDLE.GET    EVENTS,         "TRIGGERS",  TRIGGERS

   LIST.ADD    TRIGGERS,            TRIGGER$

FN.END
