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


!>-------------------------------------------------------------------------------
!!
{
"FUNCTION": "LOAD_THIS(NAME$)",
"ARGS": "STRING",
"DESCRIPTION":
"
THIS FUNCTION LOADS BY (NAME$) TO
THE rfoMM STACK MANAGEMENT SYSTEM
"
}
!!


FN.DEF LOAD_THIS$(NAME$)

   BUNDLE.GET 1, "rfoMM", rfoMM
   BUNDLE.GET rfoMM, "rfOOP_STACK", THIS
   BUNDLE.GET rfoMM, "CLASSES", CLASSES
   BUNDLE.GET rfoMM, "OBJECTS", OBJECTS
   
   LIST.SIZE CLASSES, TOTAL_CLASSES
   IF TOTAL_CLASSES > 0
      FOR CLASS = 1 TO TOTAL_CLASSES
         LIST.GET CLASSES, CLASS, CLASS_ID
         BUNDLE.GET CLASS_ID, "NAME", CURRENT_NAME$
         IF CURRENT_NAME$ = NAME$
            THIS_ID = CLASS_ID
            F_N.BREAK
         END IF
      NEXT CLASS
   END IF 
   
   LIST.SIZE OBJECTS, TOTAL_OBJECTS
   IF TOTAL_OBJECTS > 0
      FOR OBJECT = 1 TO TOTAL_OBJECTS
         LIST.GET OBJECTS, OBJECT, OBJECT_ID
         BUNDLE.GET OBJECT_ID, "NAME", CURRENT_NAME$
         IF CURRENT_NAME$ = NAME$
            THIS_ID = OBJECT_ID
            F_N.BREAK
         END IF
      NEXT OBJECT
   END IF 
   
   IF THIS_ID
      STACK.ISEMPTY THIS, EXISTS
            
      IF !EXISTS
         STACK.PEEK THIS, CURRENT
         IF CURRENT <> SELF
            STACK.PUSH THIS, THIS_ID
         END IF
      ELSE
         STACK.PUSH THIS, THIS_ID
      END IF
   ELSE
      EVENT$ = "{" + CHR$(34) + "EVENT" + CHR$(34) + ":{" + CHR$(34) + "FUNCTION" + CHR$(34) + ": " + CHR$(34) + "LOAD_THIS()" + CHR$(34) + ", " + CHR$(34) + "TYPE" + CHR$(34) + ": " + CHR$(34) + "rfOOP STRUCT LOAD FAILURE" + CHR$(34) + ", " + CHR$(34) + "MESSAGE" + CHR$(34) + ": " + CHR$(34) + "FAILED TO LOAD '" + INT$(rfOOP_STRUCT) + "' ONTO THE STACK }}"
   END IF 

FN.END
