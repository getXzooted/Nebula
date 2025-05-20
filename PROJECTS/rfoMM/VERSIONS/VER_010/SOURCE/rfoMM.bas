!>-------------------------------------------------------------------------------
!!
VER: 0.1
CLASS: rfoMM
FUNCTION: MM_INIT()
THIS FUNCTION WILL INITIALIZE THE rfOOP
MEMORY MANAGEMENT CLASS AND ENVIRONMENT
!!


FN.DEF MM_INIT()
   
   BUNDLE.CREATE rfoMM 
   
   LIST.CREATE       N,       B
   LIST.CREATE       N,       SL
   LIST.CREATE       N,       NL   
                                 
   BUNDLE.PUT    rfoMM,       "B",         B
   BUNDLE.PUT    rfoMM,       "SL",        SL
   BUNDLE.PUT    rfoMM,       "NL",        NL
                                 
   LIST.CREATE       N,       OB
   LIST.CREATE       N,       OSL
   LIST.CREATE       N,       ONL 
                                 
   BUNDLE.PUT    rfoMM,       "OB",       OB
   BUNDLE.PUT    rfoMM,       "OSL",      OSL
   BUNDLE.PUT    rfoMM,       "ONL",      ONL
                              
   STACK.CREATE      N,       THIS
   LIST.CREATE       N,       CLASSES
   LIST.CREATE       N,       OBJECTS
   
   BUNDLE.PUT    rfoMM,       "rfOOP_STACK",    THIS
   BUNDLE.PUT    rfoMM,       "CLASSES", CLASSES
   BUNDLE.PUT    rfoMM,       "OBJECTS", OBJECTS
    
   BUNDLE.CREATE CLA_VAR 
   BUNDLE.CREATE OBJ_VAR
   BUNDLE.CREATE TYPINGS   
   
   BUNDLE.PUT    TYPINGS, "INDEX",            "P"
   BUNDLE.PUT    TYPINGS, "NAME",             "S"
   BUNDLE.PUT    TYPINGS, "TYPE",             "S"
   BUNDLE.PUT    TYPINGS, "SUB TYPE",         "S"
   BUNDLE.PUT    TYPINGS, "TYPINGS",          "B"
   BUNDLE.PUT    TYPINGS, "CLASS VARIABLES",  "B"
   BUNDLE.PUT    TYPINGS, "OBJECT VARIABLES", "B"
   BUNDLE.PUT    TYPINGS, "B",                "NL"
   BUNDLE.PUT    TYPINGS, "SL",               "NL"
   BUNDLE.PUT    TYPINGS, "NL",               "NL"
   BUNDLE.PUT    TYPINGS, "OB",               "NL"
   BUNDLE.PUT    TYPINGS, "OSL",              "NL"
   BUNDLE.PUT    TYPINGS, "ONL",              "NL"
   BUNDLE.PUT    TYPINGS, "rfOOP_STACK",      "P"
   BUNDLE.PUT    TYPINGS, "CLASSES",          "NL"
   BUNDLE.PUT    TYPINGS, "OBJECTS",          "NL"
   
   BUNDLE.PUT      rfoMM, "INDEX",            rfoMM
   BUNDLE.PUT      rfoMM, "NAME",             "rfoMM"
   BUNDLE.PUT      rfoMM, "TYPE",             "CLASS"
   BUNDLE.PUT      rfoMM, "SUB TYPE",         "rfoMM"
   BUNDLE.PUT      rfoMM, "TYPINGS",          TYPINGS
   BUNDLE.PUT      rfoMM, "CLASS VARIABLES",  CLA_VAR
   BUNDLE.PUT      rfoMM, "OBJECT VARIABLES", OBJ_VAR
     
   BUNDLE.PUT          1, "rfoMM",            rfoMM
   
   LIST.ADD      CLASSES, rfoMM 

FN.END


!>-------------------------------------------------------------------------------
!!
VER: 0.1
CLASS: rfoMM
FUNCTION: MM_CREATE(TYPE$)
ABILITY TO CREATE DATA STRUCTURES USING THE APPROPRIATE COMMANDS IN THIS LIB AS 
(TYPE$) "B" BUNDLE, "SL" STRING LIST, "NL" NUMERIC LIST, "C" CLASS & "O" OBJECT
!!


FN.DEF MM_CREATE(TYPE$)

   BUNDLE.GET     1, "rfoMM", rfoMM

   IF TYPE$ = "C"
      IF !MM_OPEN("B")
         BUNDLE.CREATE MM
         BUNDLE.GET rfoMM, "B", B
         BUNDLE.GET rfoMM, "CLASSES", C
         LIST.ADD       B, MM
         LIST.ADD       C, MM
      ELSE
         MM = MM_RECYCLE("B")
         BUNDLE.GET rfoMM, "B", B
         BUNDLE.GET rfoMM, "CLASSES", C
         LIST.ADD       B, MM
         LIST.ADD       C, MM
      END IF
   ELSEIF TYPE$ = "O"
      IF !MM_OPEN("B")
         BUNDLE.CREATE MM
         BUNDLE.GET rfoMM, "B", B
         BUNDLE.GET rfoMM, "OBJECTS", O
         LIST.ADD       B, MM
         LIST.ADD       O, MM
      ELSE
         MM = MM_RECYCLE("B")
         BUNDLE.GET rfoMM, "B", B
         BUNDLE.GET rfoMM, "OBJECTS", O
         LIST.ADD       B, MM
         LIST.ADD       O, MM
      END IF 
   ELSEIF TYPE$ = "B"
      IF !MM_OPEN("B") 
         BUNDLE.CREATE MM
         BUNDLE.GET rfoMM, "B", B
         LIST.ADD       B, MM
      ELSE
         MM = MM_RECYCLE("B")
         BUNDLE.GET rfoMM, "B", B
         LIST.ADD       B, MM
      END IF            
   ELSEIF TYPE$ = "SL"   
      IF !MM_OPEN("SL")  
         LIST.CREATE    S, MM
         BUNDLE.GET rfoMM, "SL", SL
         LIST.ADD      SL, MM
      ELSE
         MM = MM_RECYCLE("SL")
         BUNDLE.GET rfoMM, "SL", SL
         LIST.ADD      SL, MM
      END IF 
   ELSEIF TYPE$ = "NL"
      IF !MM_OPEN("NL")
         LIST.CREATE    N, MM
         BUNDLE.GET rfoMM, "NL", NL
         LIST.ADD      NL, MM
      ELSE
         MM = MM_RECYCLE("NL")
         BUNDLE.GET rfoMM, "NL", NL
         LIST.ADD      NL, MM
      END IF
   ELSE
      PRINT "rfOOP MEMORY MANAGMENT ERROR, '" + TYPE$ + "' IS NOT A SUPPORTED TYPE"    
   END IF
   
   FN.RTN MM 

FN.END


!>-------------------------------------------------------------------------------
!!
VER: 0.1
CLASS: rfoMM
FUNCTION: MM_OPEN(TYPE$)
CHECK A DATA STRUCTURE TYPE FOR THE NEXT OPEN REFERENCE 
(TYPE$) "B" BUNDLE, "SL" STRING LIST, "NL" NUMERIC LIST
!!


FN.DEF MM_OPEN(TYPE$)

   BUNDLE.GET 1, "rfoMM", rfoMM

   IF TYPE$ = "B"
      BUNDLE.GET rfoMM, "OB", OB
      LIST.SIZE OB, TOTAL_OPEN
      IF TOTAL_OPEN
         LIST.GET OB, 1, MM
      ELSE
         MM = 0
      END IF 
   ELSEIF TYPE$ = "SL"
      BUNDLE.GET rfoMM, "OSL", OSL
      LIST.SIZE OSL, TOTAL_OPEN
      IF TOTAL_OPEN
         LIST.CREATE S, MM
      ELSE
         MM = 0
      END IF 
   ELSEIF TYPE$ = "NL"
      BUNDLE.GET rfoMM, "ONL", ONL
      LIST.SIZE ONL, TOTAL_OPEN
      IF TOTAL_OPEN
         LIST.CREATE N, MM
      ELSE
         MM = 0
      END IF  
   ELSE
      PRINT "rfOOP MEMORY MANAGMENT ERROR, '" + TYPE$ + "' IS NOT A SUPPORTED TYPE"  
   END IF
   
   FN.RTN MM 

FN.END


!>-------------------------------------------------------------------------------
!!
VER: 0.1
CLASS: rfoMM
FUNCTION: MM_DELETE(SELF, TYPE$)
DELETE DATA STRUCTURE (SELF) FROM
THE MEMORY MANAGEMENT ENVIRONMENT 
!!


FN.DEF MM_DELETE(SELF, TYPE$)

   BUNDLE.GET       1, "rfoMM"  ,  rfoMM
   
   SW.BEGIN TYPE$
   
      SW.CASE "C"
         BUNDLE.GET   rfoMM, "CLASSES", C
         LIST.SEARCH      C, SELF, C_EXISTS
         BUNDLE.CLEAR  SELF                  
         LIST.REMOVE      C, C_EXISTS
         LIST.ADD        OB, SELF
         SW.BREAK
      SW.CASE "O"
         BUNDLE.GET   rfoMM, "OBJECTS", O
         LIST.SEARCH      O, SELF, O_EXISTS
         BUNDLE.CLEAR  SELF            
         LIST.REMOVE      O, O_EXISTS
         LIST.ADD        OB, SELF
         SW.BREAK
      SW.CASE "B"
         BUNDLE.GET   rfoMM, "B"      , B
         BUNDLE.GET   rfoMM, "OB"     , OB
         LIST.SEARCH      B, SELF, B_EXISTS
         BUNDLE.CLEAR  SELF
         LIST.REMOVE      B, B_EXISTS     
         LIST.ADD        OB, SELF
         SW.BREAK
      SW.CASE "SL"
         BUNDLE.GET   rfoMM, "SL"     , SL
         BUNDLE.GET   rfoMM, "OSL"    , OSL
         LIST.SEARCH     SL, SELF, SL_EXISTS
         LIST.CLEAR    SELF      
         LIST.REMOVE     SL, SL_EXISTS
         LIST.ADD       OSL, SELF
         SW.BREAK
      SW.CASE "NL"
         BUNDLE.GET   rfoMM, "NL"     , NL
         BUNDLE.GET   rfoMM, "ONL"    , ONL
         LIST.SEARCH     NL, SELF, NL_EXISTS
         LIST.CLEAR    SELF  
         LIST.REMOVE     NL, NL_EXISTS    
         LIST.ADD       ONL, SELF
         SW.BREAK
      SW.DEFAULT
         PRINT "rfOOP MEMORY MANAGMENT ERROR, '" + STR$(SELF) + "'DOES NOT EXIST AS A REFERENCE IN THE rfoMM"
   SW.END
   
FN.END


!>-------------------------------------------------------------------------------
!!
VER: 0.1
CLASS: rfoMM
FUNCTION: MM_RECYCLE(TYPE$)
RECYCLE DATA STRUCTURE TYPE FOR THE NEXT OPEN REFERENCE 
(TYPE$) "B" BUNDLE, "SL" STRING LIST, "NL" NUMERIC LIST
!!



FN.DEF MM_RECYCLE(TYPE$)

   BUNDLE.GET 1, "rfoMM", rfoMM
   
   IF TYPE$ = "B"
      BUNDLE.GET rfoMM, "OB", OB
      LIST.SIZE OB, OPEN_OB
      IF OPEN_OB > 0
         LIST.GET OB, 1, MM
         LIST.REMOVE OB, 1
      ELSE
         MM = MM_CREATE("B")
      END IF
   ELSEIF TYPE$ = "SL"
      BUNDLE.GET rfoMM, "OSL", OSL
      LIST.SIZE OSL, OPEN_OSL
      IF OPEN_OSL > 0
         LIST.GET OSL, 1, MM
         LIST.REMOVE OSL, 1
      ELSE
         MM = MM_CREATE("SL")
      END IF      
   ELSEIF TYPE$ = "NL"
      BUNDLE.GET rfoMM, "ONL", ONL
      LIST.SIZE ONL, OPEN_ONL
      IF OPEN_ONL > 0
         LIST.GET ONL, 1, MM
         LIST.REMOVE ONL, 1
      ELSE
         MM = MM_CREATE("NL")
      END IF 
   ELSE
      PRINT "rfOOP MEMORY MANAGMENT ERROR, '" + TYPE$ + "' IS NOT A SUPPORTED TYPE"
   END IF 
   
   FN.RTN MM
   
FN.END


!>-------------------------------------------------------------------------------
!!
VER: 0.1
CLASS: rfoMM
FUNCTION: MM_TYPE$(SELF)
CHECK TYPE OF (SELF) IF IT IS A rfoMM DATA STRUCTURE THIS RETURNS "B" BUNDLE 
"SL" STRING LIST, "NL" NUMERIC LIST, "CB" CLASS BUNDLE OR "OB" OBJECT BUNDLE
!!


FN.DEF MM_TYPE$(SELF)

   TYPE$ = "NULL"

   BUNDLE.GET 1, "rfoMM", rfoMM
   
   BUNDLE.GET rfoMM, "B", B
   LIST.SIZE B, B_KEYS
   
   IF B_KEYS > 0
      LIST.SEARCH B, SELF, B_EXISTS
      IF B_EXISTS
         TYPE$ = "B"
      END IF    
   END IF 
   
   BUNDLE.GET rfoMM, "SL", SL
   LIST.SIZE SL, SL_KEYS
   
   IF SL_KEYS > 0
      LIST.SEARCH SL, SELF, SL_EXISTS
      IF SL_EXISTS
         TYPE$ = "SL"
      END IF    
   END IF 
   
   BUNDLE.GET rfoMM, "NL", NL
   LIST.SIZE NL, NL_KEYS 
   
   IF NL_KEYS > 0
      LIST.SEARCH NL, SELF, NL_EXISTS
      IF NL_EXISTS
         TYPE$ = "NL"
      END IF    
   END IF 
   
   BUNDLE.GET rfoMM, "CLASSES", C
   LIST.SIZE C, C_KEYS 
   
   IF C_KEYS > 0
      LIST.SEARCH C, SELF, C_EXISTS
      IF C_EXISTS
         TYPE$ = "CB"
      END IF    
   END IF 
   
   BUNDLE.GET rfoMM, "OBJECTS", O
   LIST.SIZE O, O_KEYS 
   
   IF O_KEYS > 0
      LIST.SEARCH O, SELF, O_EXISTS
      IF O_EXISTS
         TYPE$ = "OB"
      END IF    
   END IF 
   
   FN.RTN TYPE$

FN.END


!>-------------------------------------------------------------------------------
!!
VER: 0.1
CLASS: rfoMM
FUNCTION: MM_EXISTS$(NAME$)
CHECK (NAME$) OF OBJECT OR CLASS DATA STRUCTURE
EXISTS WITHIN THE MEMORY MANAGEMENT ENVIRONMENT
!!


FN.DEF MM_EXISTS$(NAME$)

   BUNDLE.GET 1, "rfoMM", rfoMM
   
   BUNDLE.GET rfoMM, "CLASSES", CLASSES
   LIST.SIZE CLASSES, TOTAL_CLASSES
   
   IF TOTAL_CLASSES > 0
      FOR CLASS = 1 TO TOTAL_CLASSES
         LIST.GET CLASSES, CLASS, CLASS_ID
         IF NAME$ = GET_NAME$(CLASS_ID)   
            EXISTS$ = "TRUE"
            F_N.BREAK
         END IF
      NEXT CLASS 
   END IF 
   
   IF EXISTS$ <> "TRUE"
      BUNDLE.GET rfoMM, "OBJECTS", OBJECTS
      LIST.SIZE OBJECTS, TOTAL_OBJECTS
   
      IF TOTAL_OBJECTS > 0
         FOR OBJECT = 1 TO TOTAL_OBJECTS
            LIST.GET OBJECTS, OBJECT, OBJECT_ID
            IF NAME$ = GET_NAME$(OBJECT_ID) 
               EXISTS$ = "TRUE"
               F_N.BREAK
            END IF
         NEXT OBJECT 
      END IF 
   END IF 
   
   IF EXISTS$ = "TRUE"
      FN.RTN "TRUE"
   ELSE
      FN.RTN "FALSE"
   END IF 

FN.END


!>-------------------------------------------------------------------------------
!!
VER: 0.1
CLASS: rfoMM
FUNCTION: MM_VALIDATE$(SELF)
THIS FUNCTION VALIDATES THE BUNDLE PASSED AS AN 
rfOOP OBJECT OR CLASS AND RETURNS TRUE OR FALSE
!!


FN.DEF MM_VALIDATE$(SELF)

   KEYS = MM_KEYS(SELF)
   LIST.SIZE KEYS, TOTAL_KEYS
   IF TOTAL_KEYS > 0
      LIST.SEARCH KEYS, "NAME", NAME_EXISTS
      LIST.SEARCH KEYS, "INDEX", INDEX_EXISTS
      LIST.SEARCH KEYS, "TYPE", TYPE_EXISTS
      LIST.SEARCH KEYS, "SUB TYPE", SUBTYPE_EXISTS
      LIST.SEARCH KEYS, "TYPINGS", TYPINGS_EXISTS
      LIST.SEARCH KEYS, "CLASS VARIABLES", CLAVAR_EXISTS
      LIST.SEARCH KEYS, "OBJECT VARIABLES", OBJVAR_EXISTS
      
      IF NAME_EXISTS
         IF INDEX_EXISTS
            IF TYPE_EXISTS
               IF SUBTYPE_EXISTS
                  IF TYPINGS_EXISTS
                     IF CLAVAR_EXISTS
                        IF OBJVAR_EXISTS
                           MM_DELETE(KEYS, "SL")
                           FN.RTN "PASS"
                        ELSE
                           FN.RTN "FAIL"
                        END IF
                     ELSE
                        FN.RTN "FAIL"
                     END IF
                  ELSE
                     FN.RTN "FAIL"
                  END IF
               ELSE
                  FN.RTN "FAIL"
               END IF
            ELSE
               FN.RTN "FAIL"
            END IF
         ELSE
            FN.RTN "FAIL"
         END IF
      ELSE
         FN.RTN "FAIL"
      END IF
   ELSE
     FN.RTN "FAIL"
   END IF

FN.END


!>-------------------------------------------------------------------------------
!!
VER: 0.1
CLASS: rfoMM
FUNCTION: MM_KEYS$(SELF)
rfo BASIC CREATES A NEW LIST EACH TIME BUNDLE.KEYS IS CALLED 
WITH THIS WE LOAD EACH LIST TO rfoMM FOR SAFE DELETION LATER
!!


FN.DEF MM_KEYS(SELF)

   BUNDLE.KEYS SELF, MM
   BUNDLE.GET     1, "rfoMM", rfoMM
   BUNDLE.GET rfoMM, "SL",    SL   
   LIST.ADD      SL, MM
   FN.RTN MM

FN.END


