! rfoMM v0.20 Test Suite
! File: rfoMM_tests.bas

! --- Configuration ---
! Ensure rfoMM.bas is accessible (e.g., in the same folder or Libraries/)
INCLUDE [your_lib_location]/rfoMM.bas

! --- Global Variables for Tests ---
DIM Result$[5]
DIM Pointer[7]
DIM Address$[7]
DIM Type$[3]
DIM KeysAddr$[1]
DIM KeysPtr[1]
DIM TempPtr[1]
DIM KeyCount[1]

! --- Simple Test Output Helper Function ---
FN.DEF TEST_PRINT(TestDesc$, Condition)
IF Condition THEN PRINT TestDesc$ + "... PASSED" ELSE PRINT TestDesc$ + "... FAILED"
FN.END

! ========================================
PRINT "--- rfoMM v0.20 Test Suite ---"
PRINT ""

! --- Initialization ---
PRINT "--- Testing Initialization ---"
MM_INIT()
PRINT "MM_INIT() called."
TEST_PRINT("Initialization Test", 1) % Assuming no crash indicates pass for now
PRINT ""

! --- Creation Tests ---
PRINT "--- Testing Creation (MM_CREATE$) ---"
Address$[1] = MM_CREATE$("B") % Create Bundle
TEST_PRINT("Create Bundle (MM_CREATE$)", Address$[1]<>"")
Address$[2] = MM_CREATE$("SL") % Create String List
TEST_PRINT("Create String List (MM_CREATE$)", Address$[2]<>"")
Address$[3] = MM_CREATE$("NL") % Create Numeric List
TEST_PRINT("Create Numeric List (MM_CREATE$)", Address$[3]<>"")
PRINT ""

! --- Existence Tests ---
PRINT "--- Testing Existence (MM_EXISTS/MM_EXISTS$) ---"
TEST_PRINT("Check Bundle Exists (MM_EXISTS)", MM_EXISTS(Address$[1]))
TEST_PRINT("Check SL Exists (MM_EXISTS$)", MM_EXISTS$(Address$[2])="TRUE")
TEST_PRINT("Check NL Exists (MM_EXISTS)", MM_EXISTS(Address$[3]))
TEST_PRINT("Check Non-Existent Address", !MM_EXISTS("rfoMM(999)"))
PRINT ""

! --- Type Checking Tests ---
PRINT "--- Testing Type Checking (MM_TYPE$) ---"
TEST_PRINT("Check Bundle Type (MM_TYPE$)", MM_TYPE$(Address$[1])="B")
TEST_PRINT("Check SL Type (MM_TYPE$)", MM_TYPE$(Address$[2])="SL")
TEST_PRINT("Check NL Type (MM_TYPE$)", MM_TYPE$(Address$[3])="NL")
TEST_PRINT("Check Non-Existent Type", MM_TYPE$("rfoMM(999)")="UNDEFINED")
PRINT ""

! --- Pointer Retrieval Tests ---
PRINT "--- Testing Pointer Retrieval (MM_POINTER) ---"
Pointer[1] = MM_POINTER(Address$[1])
TEST_PRINT("Get Bundle Pointer (MM_POINTER)", Pointer[1]>0)
Pointer[2] = MM_POINTER(Address$[2])
TEST_PRINT("Get SL Pointer (MM_POINTER)", Pointer[2]>0)
Pointer[3] = MM_POINTER(Address$[3])
TEST_PRINT("Get NL Pointer (MM_POINTER)", Pointer[3]>0)
TEST_PRINT("Get Non-Existent Pointer", MM_POINTER("rfoMM(999)")=0)
PRINT "Retrieved Pointers: B=" + INT$(Pointer[1]) + ", SL=" + INT$(Pointer[2]) + ", NL=" + INT$(Pointer[3])
PRINT ""

! --- Address Lookup Tests ---
PRINT "--- Testing Address Lookup (MM_ADDRESS$) ---"
Result$[1] = MM_ADDRESS$(Pointer[1], "B")
TEST_PRINT("Lookup Bundle Address (MM_ADDRESS$)", Result$[1]=Address$[1])
Result$[2] = MM_ADDRESS$(Pointer[2], "SL")
TEST_PRINT("Lookup SL Address (MM_ADDRESS$)", Result$[2]=Address$[2])
Result$[3] = MM_ADDRESS$(Pointer[3], "NL")
TEST_PRINT("Lookup NL Address (MM_ADDRESS$)", Result$[3]=Address$[3])
Result$[4] = MM_ADDRESS$(Pointer[1], "SL") % Wrong type lookup
TEST_PRINT("Lookup with Wrong Type", Result$[4]="")
Result$[5] = MM_ADDRESS$(999, "B") % Wrong pointer lookup
TEST_PRINT("Lookup with Wrong Pointer", Result$[5]="")
PRINT ""

! --- Deletion Tests ---
PRINT "--- Testing Deletion (MM_DELETE) ---"
MM_DELETE(Address$[1])
TEST_PRINT("Delete Bundle (MM_DELETE)", !MM_EXISTS(Address$[1]))
TEST_PRINT("Check Pointer after Delete", MM_POINTER(Address$[1])=0)
TEST_PRINT("Check Type after Delete", MM_TYPE$(Address$[1])="UNDEFINED")
MM_DELETE(Address$[2])
TEST_PRINT("Delete SL (MM_DELETE)", !MM_EXISTS(Address$[2]))
MM_DELETE(Address$[3])
TEST_PRINT("Delete NL (MM_DELETE)", !MM_EXISTS(Address$[3]))
PRINT ""

! --- Recycling Tests (Implicit) ---
PRINT "--- Testing Recycling (Implicit via Creation) ---"
Address$[4] = MM_CREATE$("B") % Should potentially reuse Pointer[1] if implementation allows
TEST_PRINT("Create Bundle after Delete (Recycling?)", Address$[4]<>"")
Pointer[4] = MM_POINTER(Address$[4])
PRINT "Pointer of new Bundle: " + INT$(Pointer[4]) + " (Old pointer was " + INT$(Pointer[1]) + ")"
MM_DELETE(Address$[4]) % Clean up
PRINT ""

! --- Loading Existing Structure Tests ---
PRINT "--- Testing Loading Existing (MM_LOAD$) ---"
BUNDLE.CREATE TempPtr[1] % Create raw RFO Bundle
BUNDLE.PUT TempPtr[1], "TestKey", "TestValue"
PRINT "Raw Bundle Pointer: " + INT$(TempPtr[1])
Address$[5] = MM_LOAD$(TempPtr[1], "B")
TEST_PRINT("Load Existing Bundle (MM_LOAD$)", Address$[5]<>"")
TEST_PRINT("Check Loaded Exists", MM_EXISTS(Address$[5]))
TEST_PRINT("Check Loaded Type", MM_TYPE$(Address$[5])="B")
TEST_PRINT("Check Loaded Pointer", MM_POINTER(Address$[5])=TempPtr[1])
% To check content, use raw pointer:
Pointer[5] = MM_POINTER(Address$[5])
IF Pointer[5] > 0
BUNDLE.GET Pointer[5], "TestKey", Result$[1]
TEST_PRINT("Check Loaded Content (Raw Pointer + BUNDLE.GET)", Result$[1]="TestValue")
ELSE
TEST_PRINT("Check Loaded Content (Raw Pointer + BUNDLE.GET)", 0) % Fail if pointer invalid
ENDIF
MM_DELETE(Address$[5])
TEST_PRINT("Delete Loaded Bundle", !MM_EXISTS(Address$[5]))
PRINT ""

! --- Bundle Keys Tests ---
PRINT "--- Testing Bundle Keys (MM_KEYS$) ---"
Address$[6] = MM_CREATE$("B")
Pointer[6] = MM_POINTER(Address$[6])
IF Pointer[6] > 0
PRINT "Created Bundle for Keys test, Pointer: " + INT$(Pointer[6])
% Use raw pointer to add keys
BUNDLE.PUT Pointer[6], "KeyA", "ValA"
BUNDLE.PUT Pointer[6], "KeyB", "ValB"
ELSE
PRINT "Failed to create bundle for Keys test."
GOTO SkipKeysTest
ENDIF

KeysAddr$ = MM_KEYS$(Address$[6])
TEST_PRINT("Get Keys Address (MM_KEYS$)", KeysAddr$<>"" & MM_EXISTS(KeysAddr$))
TEST_PRINT("Check Keys List Type", MM_TYPE$(KeysAddr$)="SL")
KeysPtr = MM_POINTER(KeysAddr$)
IF KeysPtr > 0
PRINT "Keys List Pointer: " + INT$(KeysPtr)
LIST.SIZE KeysPtr, KeyCount
TEST_PRINT("Check Key Count (LIST.SIZE on raw pointer)", KeyCount=2)
IF KeyCount = 2
  LIST.GET KeysPtr, 1, Result$[1]
  LIST.GET KeysPtr, 2, Result$[2]
  PRINT "Keys retrieved: " + Result$[1] + ", " + Result$[2]
  % Check if keys are correct (order isn't guaranteed by BUNDLE.KEYS)
  TEST_PRINT("Check Key Content", (Result$[1]="KeyA" & Result$[2]="KeyB") | (Result$[1]="KeyB" & Result$[2]="KeyA"))
ENDIF
ELSE
PRINT "Failed to get keys list pointer."
TEST_PRINT("Check Key Count", 0) % Fail test if pointer invalid
TEST_PRINT("Check Key Content", 0) % Fail test if pointer invalid
ENDIF
MM_DELETE(KeysAddr$) % Delete the keys list
TEST_PRINT("Delete Keys List", !MM_EXISTS(KeysAddr$))
MM_DELETE(Address$[6]) % Delete the bundle
TEST_PRINT("Delete Bundle after Keys", !MM_EXISTS(Address$[6]) )


SkipKeysTest:
PRINT ""

! --- Validation Test (Basic) ---
PRINT "--- Testing Validation (MM_VALIDATE$) ---"
Address$[7] = MM_CREATE$("B") % Create a plain bundle
Result$[1] = MM_VALIDATE$(Address$[7])
TEST_PRINT("Validate Plain Bundle (Expect FALSE)", Result$[1]="FALSE")

Pointer[7] = MM_POINTER(Address$[7])
IF Pointer[7] > 0
% Add expected rfOOP keys using raw pointer
BUNDLE.PUT Pointer[7], "NAME", "TestObj"
BUNDLE.PUT Pointer[7], "INDEX", Pointer[7]
BUNDLE.PUT Pointer[7], "TYPE", "TestType"
BUNDLE.PUT Pointer[7], "SUB TYPE", "TestSubType"
BUNDLE.PUT Pointer[7], "TYPINGS", 0 % Placeholder pointer
BUNDLE.PUT Pointer[7], "CLASS VARIABLES", 0 % Placeholder pointer
BUNDLE.PUT Pointer[7], "OBJECT VARIABLES", 0 % Placeholder pointer
Result$[2] = MM_VALIDATE$(Address$[7])
TEST_PRINT("Validate OOP-like Bundle (Expect TRUE)", Result$[2]="TRUE")
ELSE
TEST_PRINT("Validate OOP-like Bundle (Expect TRUE)", 0) % Fail if pointer invalid
ENDIF
MM_DELETE(Address$[7])
PRINT ""


PRINT "--- Test Suite Complete ---"
END

% Note: TEST_PRINT definition was moved to the top
