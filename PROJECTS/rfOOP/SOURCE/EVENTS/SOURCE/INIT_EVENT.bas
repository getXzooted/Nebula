
!>-------------------------------------------------------------------------------
!!
{
"FUNCTION": "INIT_EVENTS()",
"DESCRIPTION":
"
THE EVENT HANDLER CLASS AND OBJECT
CREATED TO rfOOP SPECS USING rfoMM
"
}
!!


FN.DEF INIT_EVENTS()
            
   TRIGGERS              = MM_CREATE("SL")
   EVENTS                = MM_CREATE("SL")     
   ERRORS                = MM_CREATE("SL") 
   OBJECT_VARIABLES      = MM_CREATE("B")
   CLASS_VARIABLES       = MM_CREATE("B")
   TYPINGS               = MM_CREATE("B")
    
   EVENTS_OBJECT         = MM_CREATE("O") 
   
   BUNDLE.PUT            TYPINGS,              "INDEX",    "P"
   BUNDLE.PUT            TYPINGS,               "NAME",    "S"
   BUNDLE.PUT            TYPINGS,               "TYPE",    "S"
   BUNDLE.PUT            TYPINGS,           "SUB TYPE",    "S"
   BUNDLE.PUT            TYPINGS,            "TYPINGS",    "B"
   BUNDLE.PUT            TYPINGS,    "CLASS VARIABLES",    "B"
   BUNDLE.PUT            TYPINGS,   "OBJECT VARIABLES",    "B"
   BUNDLE.PUT            TYPINGS,             "EVENTS",    "SL"  
   BUNDLE.PUT            TYPINGS,           "TRIGGERS",    "SL"
   BUNDLE.PUT            TYPINGS,             "ERRORS",    "SL"
   
   BUNDLE.PUT             EVENTS,              "INDEX",    EVENTS_OBJECT
   BUNDLE.PUT             EVENTS,               "NAME",    "EVENT HORIZON"
   BUNDLE.PUT             EVENTS,               "TYPE",    "SUPER CLASS"
   BUNDLE.PUT             EVENTS,           "SUB TYPE",    "EVENT HANDLER"
   BUNDLE.PUT             EVENTS,            "TYPINGS",    TYPINGS
   BUNDLE.PUT             EVENTS,    "CLASS VARIABLES",    CLASS_VARIABLES
   BUNDLE.PUT             EVENTS,   "OBJECT VARIABLES",    OBJECT_VARIABLES
   BUNDLE.PUT             EVENTS,             "EVENTS",    EVENTS  
   BUNDLE.PUT             EVENTS,           "TRIGGERS",    TRIGGERS
   BUNDLE.PUT             EVENTS,             "ERRORS",    ERRORS   
   
   BUNDLE.PUT                  1,      "EVENT HORIZON",    EVENTS

FN.END

