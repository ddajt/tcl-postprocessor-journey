# Problem 1:

# In NX CAM:

# Create a new part — simple block, 100mm × 100mm × 20mm
# Create one Face Milling operation, any tool, S1000 F300
# Generate the toolpath
# Post process using Legacy_practice_post
# Open the output .ptp file (or .mpf if you changed it)

# Paste the entire output here.
# Expected output: Raw G-code, every line.


# solution : 

%
N10 G40 G17 G90 G71
N20 G91 G28 Z0.0
N30 T01 M06
N40 G54
N50 G00 G90 X150. Y12.53 S1000 M03
N60 G43 Z4. H01
N70 Z3.875
N80 G01 Z.875 F300. M08
N90 X100.
N100 X0.0
N110 G02 Y46.25 I0.0 J16.86
N120 G01 X100.
N130 G03 Y79.97 I0.0 J16.86
N140 G01 X0.0
N150 X-50.
N160 Z3.875
N170 G00 Z4.
N180 X150. Y12.53
N190 Z3.75
N200 G01 Z.75
N210 X100.
N220 X0.0
N230 G02 Y46.25 I0.0 J16.86
N240 G01 X100.
N250 G03 Y79.97 I0.0 J16.86
N260 G01 X0.0
N270 X-50.
N280 Z3.75
N290 G00 Z4.
N300 X150. Y12.53
N310 Z3.625
N320 G01 Z.625
N330 X100.
N340 X0.0
N350 G02 Y46.25 I0.0 J16.86
N360 G01 X100.
N370 G03 Y79.97 I0.0 J16.86
N380 G01 X0.0
N390 X-50.
N400 Z3.625
N410 G00 Z4.
N420 X150. Y12.53
N430 Z3.5
N440 G01 Z.5
N450 X100.
N460 X0.0
N470 G02 Y46.25 I0.0 J16.86
N480 G01 X100.
N490 G03 Y79.97 I0.0 J16.86
N500 G01 X0.0
N510 X-50.
N520 Z3.5
N530 G00 Z4.
N540 X150. Y12.53
N550 Z3.375
N560 G01 Z.375
N570 X100.
N580 X0.0
N590 G02 Y46.25 I0.0 J16.86
N600 G01 X100.
N610 G03 Y79.97 I0.0 J16.86
N620 G01 X0.0
N630 X-50.
N640 Z3.375
N650 G00 Z4.
N660 X150. Y12.53
N670 Z3.25
N680 G01 Z.25
N690 X100.
N700 X0.0
N710 G02 Y46.25 I0.0 J16.86
N720 G01 X100.
N730 G03 Y79.97 I0.0 J16.86
N740 G01 X0.0
N750 X-50.
N760 Z3.25
N770 G00 Z4.
N780 X150. Y12.53
N790 Z3.125
N800 G01 Z.125
N810 X100.
N820 X0.0
N830 G02 Y46.25 I0.0 J16.86
N840 G01 X100.
N850 G03 Y79.97 I0.0 J16.86
N860 G01 X0.0
N870 X-50.
N880 Z3.125
N890 G00 Z4.
N900 X150. Y12.53
N910 Z3.
N920 G01 Z0.0
N930 X100.
N940 X0.0
N950 G02 Y46.25 I0.0 J16.86
N960 G01 X100.
N970 G03 Y79.97 I0.0 J16.86
N980 G01 X0.0
N990 X-50.
N1000 Z3.
N1010 G00 Z4.
N1020 M02
%


# Problem 2
# Take your posted output. For every single line, 
# write a comment after it identifying which event proc generated it. 

# solution:
%
N10 G40 G17 G90 G71  mom_start_of_program
N20 G91 G28 Z0.0 mom_start_of_program,MOM_start_of_path
N30 T01 M06 mom_toolchange 
N40 G54 MOM_set_csys
N50 G00 G90 X150. Y12.53 S1000 M03 mom_rapid_move,mom_absoulute,
N60 G43 Z4. H01 MOM_length_compensation
N70 Z3.875 mom_rapid
N80 G01 Z.875 F300. M08 mom_linear,
N90 X100. mom_do_template
N100 X0.0 mom_do_template
N110 G02 Y46.25 I0.0 J16.86 mom_arc_mode, mom_do_template 
N120 G01 X100. mom_linear
N130 G03 Y79.97 I0.0 J16.86 mom_arc_mode
N140 G01 X0.0 mom_linear
N150 X-50. mom_do_template
N160 Z3.875 mom_do_template
N170 G00 Z4. mom_rapid
N180 X150. Y12.53 mom_do_template
N190 Z3.75 mom_do_template
N200 G01 Z.75 mom_linear_move
; the same continues untill N1010
N210 X100.
N220 X0.0
N230 G02 Y46.25 I0.0 J16.86
N240 G01 X100.
N250 G03 Y79.97 I0.0 J16.86
N260 G01 X0.0
N270 X-50.
N280 Z3.75
N290 G00 Z4.
N300 X150. Y12.53
N310 Z3.625
N320 G01 Z.625
N330 X100.
N340 X0.0
N350 G02 Y46.25 I0.0 J16.86
N360 G01 X100.
N370 G03 Y79.97 I0.0 J16.86
N380 G01 X0.0
N390 X-50.
N400 Z3.625
N410 G00 Z4.
N420 X150. Y12.53
N430 Z3.5
N440 G01 Z.5
N450 X100.
N460 X0.0
N470 G02 Y46.25 I0.0 J16.86
N480 G01 X100.
N490 G03 Y79.97 I0.0 J16.86
N500 G01 X0.0
N510 X-50.
N520 Z3.5
N530 G00 Z4.
N540 X150. Y12.53
N550 Z3.375
N560 G01 Z.375
N570 X100.
N580 X0.0
N590 G02 Y46.25 I0.0 J16.86
N600 G01 X100.
N610 G03 Y79.97 I0.0 J16.86
N620 G01 X0.0
N630 X-50.
N640 Z3.375
N650 G00 Z4.
N660 X150. Y12.53
N670 Z3.25
N680 G01 Z.25
N690 X100.
N700 X0.0
N710 G02 Y46.25 I0.0 J16.86
N720 G01 X100.
N730 G03 Y79.97 I0.0 J16.86
N740 G01 X0.0
N750 X-50.
N760 Z3.25
N770 G00 Z4.
N780 X150. Y12.53
N790 Z3.125
N800 G01 Z.125
N810 X100.
N820 X0.0
N830 G02 Y46.25 I0.0 J16.86
N840 G01 X100.
N850 G03 Y79.97 I0.0 J16.86
N860 G01 X0.0
N870 X-50.
N880 Z3.125
N890 G00 Z4.
N900 X150. Y12.53
N910 Z3.
N920 G01 Z0.0
N930 X100.
N940 X0.0
N950 G02 Y46.25 I0.0 J16.86
N960 G01 X100.
N970 G03 Y79.97 I0.0 J16.86
N980 G01 X0.0
N990 X-50.
N1000 Z3.
N1010 G00 Z4.
N1020 M02 mom_end_of_program
%


# Problem 3
# After annotating, list every line in your output that would be wrong or rejected by your actual Siemens 810D VMC 850. For each wrong line write:

# What the post output
# What your machine actually expects
# Which proc you'd need to modify to fix it

WRONG:  N20 G91 G28 Z0.0
EXPECT: G75 Z0 (no G91 needed — G75 is absolute reference return on 810D)
FIX IN: MOM_gohome_move / home position template

WRONG:  G43 Z4. H01
EXPECT: T1 D1 (Siemens tool length — D register, not H register, no G43)
FIX IN: MOM_length_compensation / tool_length_adjust template in .def

WRONG:  M02
EXPECT: M30 (810D standard program end with rewind)
FIX IN: MOM_end_of_program / end_of_program template

WRONG:  G71 not actually wrong but Siemens prefer dont want to omit it on the post level
EXPECT: Siemens sets inch / metric in control parameter level 
Fix in: PB_start_of_program / absolute_mode

WRONG:  G28 Z0.0
EXPECT: G75 z0 for home in z
fix: MOM_gohome_move

WRONG: G02 Y46.25 I0.0 J16.86
EXPECT: G02 Y46.25 I0.0 J16.86 (same - 810D accepts IJK format natively)
fix idk : nothing needed for basic IJK arcs
NOTE:   810D also accepts CR= radius format as alternative
        Verify full circle arcs work — FULL_CIRCLE mode may need checking