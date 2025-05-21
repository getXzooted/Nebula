!>-------------------------------------------------------------------------------
!!
{
"FUNCTION": "THIS_NAME$()",
"RETURNS": "STRING",
"DESCRIPTION":
"
PEEKS AT THE rfoMM STACK MANAGEMENT SYSTEM AND 
RETURNS THE NAME OF THE CURRENT OBJECT / CLASS
"
}
!!


FN.DEF THIS_NAME$()

   BUNDLE.GET 1, "rfoMM", rfoMM
   BUNDLE.GET rfoMM, "rfOOP_STACK", THIS
   
   STACK.ISEMPTY THIS, EXISTS
   
   IF !EXISTS
      STACK.PEEK THIS, CURRENT   
      BUNDLE.GET CURRENT, "NAME", NAME$
      FN.RTN NAME$
   ELSE
      EVENT$ = "{" + CHR$(34) + "EVENT" + CHR$(34) + ":{" + CHR$(34) + "FUNCTION" + CHR$(34) + ": " + CHR$(34) + "THIS_NAME$()" + CHR$(34) + ", " + CHR$(34) + "TYPE" + CHR$(34) + ": " + CHR$(34) + "FAILURE GETTING THIS NAME" + CHR$(34) + ", " + CHR$(34) + "MESSAGE" + CHR$(34) + ": " + CHR$(34) + "NOTHING LOADED IN THIS STACK}}"
      LOG_EVENT$(EVENT$)
      FN.RTN EVENT$
   END IF 
   
FN.END


