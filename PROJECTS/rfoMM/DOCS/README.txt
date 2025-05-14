rfoMM - Nebula Memory Manager (v0.20)

Purpose

rfoMM.bas provides essential structured memory management for RFO Basic data structures (Bundles, Lists, and in future versioning many more). A core challenge in RFO Basic is how it assigns numeric IDs: each data structure type (Bundle, String List, Numeric List, etc.) has its own independent counter starting from 1. This means you can simultaneously have a Bundle 1, a String List 1, and potentially many other structures of different types, all identified by the number 1. Knowing only the numeric ID is therefore highly ambiguous.

rfoMM solves this critical ambiguity and manages structures effectively by:


Creating a Unified Namespace: It replaces the overlapping, type-specific numeric IDs with unique, string-based Memory Addresses (MM_ADDRESS$). Each MM_ADDRESS$ unambiguously identifies a specific instance of a specific type (e.g., "rfoMM(1)", "rfoMM(2)" are distinct, even if their underlying RFO Basic numeric IDs might both be 1).

Tracking Type: It inherently knows the data type associated with each MM_ADDRESS$ based on your initial loading or creation, ensuring operations are performed correctly.

Managing Lifecycles: It includes functions like MM_DELETE to properly release structures and allow their underlying resources/IDs to be safely recycled within the rfoMM system, preventing conflicts and keeping memory usage organized and reducing memory usage on large scale applications that consistently reuse data structures.


This component is a foundational "pillar" of the Project Nebula Runtime Environment but can also be used as a standalone library for safer and more robust data management in any RFO Basic project.

Standalone Usage

To use rfoMM in your RFO Basic project outside of the full Nebula environment:


Place the rfoMM.bas file in a location accessible to your main project file.

Include the library at the beginning of your main .bas file using the INCLUDE statement:
INCLUDE rfoMM.bas

Getting Started

Before using any other rfoMM functions, you must initialize the memory manager, typically once near the start of your program:

MM_INIT()

After initialization, you can use functions like MM_CREATE$, MM_EXISTS, MM_TYPE$, MM_DELETE, etc., to manage your data structures. Refer to the comprehensive documentation for details on all available functions.

Project Nebula Context

Within the planned Project Nebula environment (distributed via APK), this library (rfoMM.bas) is intended to reside in the standard Libraries/ folder relative to the main application script. The Nebula runtime will manage its loading.


Version: 0.20 

License: GPL-3.0-or-later 

Part of Project Nebula


