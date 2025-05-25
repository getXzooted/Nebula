!>-------------------------------------------------------------------------------
!!
{
"FUNCTION": "CREATE_TRIGGER$(TRIGGER$)",
"DESCRIPTION":
"
USE THIS FUNCTION TO CREATE A NEW TRIGGER FROM 
(TRIGGER$) FOR USE WITH THE ON_EVENT$(TRIGGER$)
"
}
!!


FN.DEF CREATE_TRIGGER$(TRIGGER$)

   BUNDLE.GET         1,    "EVENT HORIZON",    EVENTS
   BUNDLE.GET    EVENTS,           "EVENTS",    EVENTS
   BUNDLE.GET    EVENTS,         "TRIGGERS",  TRIGGERS

   LIST.ADD    TRIGGERS,            TRIGGER$

FN.END
