!>-------------------------------------------------------------------------------
!!
{
"FUNCTION": "THIS_SUBTYPE$()",
"RETURNS": "SUBTYPE OF THIS",
"DESCRIPTION":
"
PEEKS AT THE rfoMM STACK MANAGEMENT SYSTEM AND 
RETURNS SUB TYPE OF THE CURRENT OBJECT / CLASS
"
}
!!


FN.DEF THIS_SUBTYPE$()

   BUNDLE.GET 1, "rfoMM", rfoMM
   BUNDLE.GET rfoMM, "rfOOP_STACK", THIS
   
   STACK.ISEMPTY THIS, EXISTS
   
   IF !EXISTS
      STACK.PEEK THIS, CURRENT   
      BUNDLE.GET CURRENT, "SUB TYPE", SUB_TYPE$
      EVENT$ = "{" + CHR$(34) + "EVENT" + CHR$(34) + ":{" + CHR$(34) + "FUNCTION" + CHR$(34) + ": " + CHR$(34) + "THIS_SUBTYPE$()" + CHR$(34) + ", " + CHR$(34) + "TYPE" + CHR$(34) + ": " + CHR$(34) + "SUCCESS GETTING THIS SUBTYPE" + CHR$(34) + ", " + CHR$(34) + "MESSAGE" + CHR$(34) + ": " + CHR$(34) + "SUCCESSFULLY RETRIEVED SUBTYPE OF '" + INT$(CURRENT) + "'}}"
      LOG_EVENT$(EVENT$)
      FN.RTN SUB_TYPE$
   ELSE
      EVENT$ = "{" + CHR$(34) + "EVENT" + CHR$(34) + ":{" + CHR$(34) + "FUNCTION" + CHR$(34) + ": " + CHR$(34) + "THIS_SUBTYPE$()" + CHR$(34) + ", " + CHR$(34) + "TYPE" + CHR$(34) + ": " + CHR$(34) + "FAILURE GETTING THIS SUBTYPE" + CHR$(34) + ", " + CHR$(34) + "MESSAGE" + CHR$(34) + ": " + CHR$(34) + "NOTHING LOADED IN THIS STACK}}"
      LOG_EVENT$(EVENT$)
      FN.RTN EVENT$
   END IF 

FN.END


