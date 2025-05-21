!>-------------------------------------------------------------------------------
!!
{
"FUNCTION": "LOAD_THIS(rfOOP_STRUCT)",
"ARGS": [{"rfOOP_STRUCT": ["C", "O"]}],
"RETURNS": "STRUCT ID",
"DESCRIPTION":
"
THIS FUNCTION WILL LOAD THE CLASS OR 
OBJECT TO THE TOP OF THE rfOOP STACK
"
}
!!


FN.DEF LOAD_THIS(rfOOP_STRUCT)

   BUNDLE.GET 1, "rfoMM", rfoMM
   BUNDLE.GET rfoMM, "rfOOP_STACK", THIS
   BUNDLE.GET rfoMM, "CLASSES", CLASSES
   BUNDLE.GET rfoMM, "OBJECTS", OBJECTS
   
   LIST.SIZE CLASSES, TOTAL_CLASSES
   
   IF TOTAL_CLASSES > 0
      LIST.SEARCH CLASSES, rfOOP_STRUCT, EXISTS
   END IF 
   
   IF !EXISTS
      LIST.SIZE OBJECTS, TOTAL_OBJECTS
      IF TOTAL_OBJECTS > 0
         LIST.SEARCH OBJECTS, rfOOP_STRUCT, EXISTS
      END IF
   END IF 
   
   IF EXISTS
      STACK.ISEMPTY THIS, EXISTS
            
      IF !EXISTS
         STACK.PEEK THIS, CURRENT
         IF CURRENT <> rfOOP_STRUCT
            STACK.PUSH THIS, rfOOP_STRUCT
         END IF
      ELSE
         STACK.PUSH THIS, rfOOP_STRUCT
      END IF
      
      EVENT$ = "{" + CHR$(34) + "EVENT" + CHR$(34) + ":{" + CHR$(34) + "FUNCTION" + CHR$(34) + ": " + CHR$(34) + "LOAD_THIS()" + CHR$(34) + ", " + CHR$(34) + "TYPE" + CHR$(34) + ": " + CHR$(34) + "rfOOP STRUCT LOAD SUCCESS" + CHR$(34) + ", " + CHR$(34) + "MESSAGE" + CHR$(34) + ": " + CHR$(34) + "SUCCESFULLY LOADED '" + INT$(rfOOP_STRUCT) + "' ONTO THE STACK }}"
   ELSE
      EVENT$ = "{" + CHR$(34) + "EVENT" + CHR$(34) + ":{" + CHR$(34) + "FUNCTION" + CHR$(34) + ": " + CHR$(34) + "LOAD_THIS()" + CHR$(34) + ", " + CHR$(34) + "TYPE" + CHR$(34) + ": " + CHR$(34) + "rfOOP STRUCT LOAD FAILURE" + CHR$(34) + ", " + CHR$(34) + "MESSAGE" + CHR$(34) + ": " + CHR$(34) + "FAILED TO LOAD '" + INT$(rfOOP_STRUCT) + "' ONTO THE STACK }}"
   END IF 
   
   LOG_EVENT$(EVENT$)

FN.END


