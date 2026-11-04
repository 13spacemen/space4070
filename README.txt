SS13 40.70 rebuilt source (June 2004, BYOND 338). Compiles to the original cellautomata.dmb byte for byte:
md5 06e7a2e9563340bcd766ee5e7d7f2591 (521658 bytes).

Compiler: BYOND 338 (C:\s40\byond338\x), run through the kit's Dream Maker driver:
  sh C:/ss70/work/cmp.sh <folder>        (compiles <folder>/cellautomata.dme, prints md5 + audit against the original)
Tested: 10 of 10 compiles from clean copies gave the identical file; `cmp` clean; a from-scratch rebuild
(sh C:/ss70/work/rebuild.sh <new folder>) gives the same file and the same text as this folder.
Plain Dream Maker 338 (dreammaker.exe started normally) does NOT run on this PC (Windows 11): it crashes at startup with
0xC0000005 every time, even with no project (tested 3 times, 2026-11-04). Cause (verified for BYOND 334 in 2026-10, same failure
here): byond.dll uses printf's "%n", which modern Windows' msvcrt disables. The kit starts the same Dream Maker under a tiny debugger
(kit\host334.py) that fills in that one printf count; nothing else is changed, and the compile itself is Dream Maker's own Build >
Compile. On a period Windows (XP etc.) the plain program should run and give the same file (INFERRED, not tested).

The .rsc: the 40 icons/files inside are identical to the original's (checked record by record). The .rsc FILE is not
byte-identical and cannot be from a fresh compile: the original also holds 13 dead records and slack from its cache history.

How it was made: the bit-perfect April 2004 source (C:\misc\dev\space2004apr) with every April -> 40.70 change put in by hand,
using the 40.70 decompile and, where its code matched, the author's own text from the 40.93.0 source (C:\misc\dev\space40930).
The map is written from the 40.70 .dmb, the icons are extracted from the 40.70 .rsc. Every text change: C:\ss70\work\port4070.patch.

Not the author's text: comments are gone (the .dmb does not store them), and where the .dmb stores nothing the spelling is a
choice that gives the same bytes. Choices made in this version (on top of the April source's own, see its notes):
  - dir1..dir4: four placeholder folders. The original's .dme had 4 more lines; Dream Maker rewrites the .dme on every compile
    and writes one `#define FILE_DIR` line per sub-folder that holds a .dm/.dmi file, so the 40.70 project folder had 4 more
    sub-folders. Their names are unknown; any 4 such folders give the same bytes.
  - blank lines: 20 after /client/Move (mob.dm), 9 after the game_kit type block (items.dm), 2 before show_panel, and others
    whose only job is to put each proc on its original line.
  - one-line forms chosen for position/order only: `/obj/machinery/atmoalter/siphs/var/alterable = 1` (and f_time),
    `/turf/station/wall/var/state = 2`, and the two `/obj/item/weapon/flash{...}` lines in items.dm.
  - shock_kit `desc = "..."; desc = null` (its desc string is in the .dmb's string table but the value is null).
  - /client `var/obj/admins/holder` is typed (needed: holder:update() must bind to the admin panel's update).
  - the computer subtypes keep their own `density = 1` although /obj/machinery/computer now sets it: the lines are needed for
    the line numbers, and a setting equal to the inherited value is not stored in the .dmb.
