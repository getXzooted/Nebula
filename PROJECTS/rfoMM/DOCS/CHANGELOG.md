# **Changelog**

All notable changes to the rfoMM (Nebula Memory Manager) library will be documented in this file.  
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html) (starting formally with v0.20).

## **\[0.20\] \- 2025-05-06**

Major refactoring of v0.1 (rfOOP\_MM.txt), Introduces the MM\_ADDRESS$ system for unified, unambiguous structure referencing and tracking.

### **Added**

* **Core MM\_ADDRESS$ System:** Replaces v0.1's reliance on passing separate numeric pointers (SELF) and type strings (TYPE$). v0.20 uses unique string identifiers (e.g., "rfoMM(1)") as the primary handle.  
* **Internal Tracking Bundles:** Added MEMORY\_ADDRESSES (maps MM\_ADDRESS$ \-\> numeric pointer) and MEMORY\_TYPES (maps MM\_ADDRESS$ \-\> type string) bundles within the main rfoMM object during MM\_INIT for centralized tracking.  
* **MM\_CREATE$( type$ ):** Core function to create structures. Returns MM\_ADDRESS$. Internally uses MM\_LOAD$ after obtaining a raw pointer (via recycling or new creation). Handles types 'B', 'SL', 'NL', 'C', 'O'.  
* **MM\_LOAD$( struct\_id, type$ ):** Registers an existing RFO Basic structure pointer (struct\_id) with the MM system, assigning it a new unique MM\_ADDRESS$ and storing the mapping in the tracking bundles. Returns the new MM\_ADDRESS$. No v0.1 equivalent.  
* **MM\_ADDRESS$( struct\_id, type$ ):** Utility to find the existing MM\_ADDRESS$ for a managed structure given its numeric pointer and type by searching the tracking bundles. No v0.1 equivalent.  
* **MM\_POINTER( MM\_ADDRESS$ ):** Essential utility to retrieve the underlying RFO Basic numeric pointer from an MM\_ADDRESS$ by looking it up in MEMORY\_ADDRESSES. Not present in v0.1.  
* **MM\_KEYS$( MM\_ADDRESS$ ):** Takes MM\_ADDRESS$ (for Bundles). Gets the numeric pointer using MM\_POINTER. Calls BUNDLE.KEYS. Uses MM\_LOAD$ to register the *new keys list* under MM management. Returns the MM\_ADDRESS$ *of this new keys list*. (v0.1 MM\_KEYS returned the raw list pointer and added it to a shared SL list).  
* **MM\_EXISTS( MM\_ADDRESS$ ) / MM\_EXISTS$( MM\_ADDRESS$ ):** Checks if MM\_ADDRESS$ key exists in the MEMORY\_ADDRESSES bundle. Replaces v0.1's MM\_EXISTS$(NAME$) which searched CLASSES/OBJECTS lists based on names retrieved via GET\_NAME$.  
* **Wrapper Functions:** Added MM\_CREATE(type$) \-\> returns numeric pointer; MM\_KEYS(MM\_ADDRESS$) \-\> returns numeric pointer of keys list. These wrap the $ versions for specific needs.

### **Changed**

* **Fundamental Interface:** Most functions now operate on MM\_ADDRESS$ instead of SELF (numeric pointer) and often TYPE$. Functions like MM\_DELETE, MM\_TYPE$, MM\_VALIDATE$ have updated signatures and logic.  
* **MM\_DELETE( MM\_ADDRESS$ ):** Takes MM\_ADDRESS$. Uses MM\_POINTER and MM\_TYPE$ to get details. Removes the entry from MEMORY\_ADDRESSES and MEMORY\_TYPES. Then proceeds with structure clearing (BUNDLE.CLEAR/LIST.CLEAR) and adding the numeric pointer to the appropriate OPEN\_... list for recycling (logic similar to v0.1 MM\_DELETE(SELF, TYPE$) after finding the item).  
* **MM\_TYPE$( MM\_ADDRESS$ ):** Takes MM\_ADDRESS$. Retrieves type string directly from MEMORY\_TYPES bundle. Replaces v0.1 MM\_TYPE$(SELF) which took a numeric pointer and searched through all IN\_USE lists (B, SL, NL, CLASSES, OBJECTS).  
* **MM\_VALIDATE$( MM\_ADDRESS$ ):** Signature changed to take MM\_ADDRESS$. Still performs structural validation on the underlying bundle (checking for rfOOP keys like "NAME", "INDEX", etc.) but uses BUNDLE.CONTAIN directly instead of relying on MM\_KEYS results like v0.1. *This function was NOT removed.*  
* **Internal Lists:** Renamed internal lists (e.g., B \-\> IN\_USE\_BUNDLES, OB \-\> OPEN\_BUNDLES). Added central MEMORY\_ADDRESSES, MEMORY\_TYPES bundles.  
* **Internal Functions (MM\_OPEN, MM\_RECYCLE):** Logic is similar to v0.1 but adapted for the new internal list names. Marked as internal in v0.20 header.

### **Removed**

* **Direct Pointer/Type Interface:** Primary method of passing SELF \+ TYPE$ to functions is replaced by MM\_ADDRESS$.  
* **v0.1 MM\_EXISTS$(NAME$):** Removed name-based search; replaced by address-based MM\_EXISTS$(MM\_ADDRESS$).  
* **v0.1 MM\_KEYS(SELF):** Replaced by MM\_KEYS$(MM\_ADDRESS$) (returns address of managed list) and MM\_KEYS(MM\_ADDRESS$) (returns pointer wrapper).

## **\[0.1\] \- \[Date of v0.1 \- No Community Release Date\]**

* Initial version (rfOOP\_MM.bas).  
* Used numeric pointers (SELF) and type strings (TYPE$) as function arguments.  
* Managed structures via separate lists per type (B, SL, NL, CLASSES, OBJECTS) and corresponding recycle lists (OB, OSL, ONL).  
* Included OOP helpers (MM\_EXISTS$(NAME$), MM\_VALIDATE$(SELF)).  
* MM\_TYPE$ searched multiple lists.  
* MM\_KEYS returned raw list pointer, added pointer to main SL list.  
* Lacked MM\_ADDRESS$, MM\_POINTER, MM\_LOAD$, MM\_ADDRESS$.

