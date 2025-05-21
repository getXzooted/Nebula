!>-------------------------------------------------------------------------------
!!
{
"FUNCTION": "THIS()",
"RETURNS": "STRUCT ID",
"DESCRIPTION":
"
PEEKS AT THE rfoMM STACK MANAGEMENT SYSTEM AND RETURNS 
THE CURRENT OBJECT OR CLASS / ROOT IS THE rfoMM OBJECT
"
}
!!


FN.DEF THIS()

   BUNDLE.GET 1, "rfoMM", rfoMM
   BUNDLE.GET rfoMM, "rfOOP_STACK", THIS
   
   STACK.ISEMPTY THIS, EXISTS
   
   IF !EXISTS
      STACK.PEEK THIS, CURRENT   
      FN.RTN CURRENT
   ELSE
      FN.RTN rfoMM
   END IF 

FN.END