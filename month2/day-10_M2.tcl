# Problem 1 — Verify K behavior against your own .def file
#Open Legacy_practice_post.def, 
# find ADDRESS K, and note its FORCE setting

# IN the address K Force for modal is given as always means the opposite of modal.
# this address is supposed to print on every single block it appears in, even if the value hasn't changed. 
# It's the strongest possible "always output" setting — the exact opposite of the FORCE off

  ADDRESS K
  {
      FORMAT      Coordinate
      FORCE       always
      MAX         99999.999 Truncate
      MIN         -99999.999 Truncate
      LEADER      "K"
      ZERO_FORMAT Zero_real
  }

# during circular move fires k position also be considered and fetched by calculation.

  BLOCK_TEMPLATE circular_move
  {
       G_plane[$mom_sys_cutcom_plane_code($mom_pos_arc_plane)]\opt
       G_motion[$mom_sys_circle_code($mom_arc_direction)]\opt
       G_mode[$mom_sys_output_code($mom_output_mode)]
       X[$mom_pos(0)]
       Y[$mom_pos(1)]
       Z[$mom_pos(2)]
       I[$mom_pos_arc_center(0) - $mom_prev_pos(0)]
       J[$mom_pos_arc_center(1) - $mom_prev_pos(1)]
       K[$mom_pos_arc_center(2) - $mom_prev_pos(2)]
       F[$feed]
       #S[$mom_spindle_speed]
  }



# Problem 2 — Hand-calculate before you trust the machine

# Given this arc: start point (0, 0), end point (10, 0), center at (5, 0), direction clockwise.

# By hand, work out:
# Expected G-code — G02 or G03?
# Expected I value
# Expected J value.

# ...solution:

Gcode : G02
I value : 5mm
J value:0mm 

#Problem 3 — Generate and verify against your hand-calc

# In NX CAM, create a simple arc or circular pocket operation. Post it through Legacy_practice_post. Open the .mpf output and check:

# Does the actual G02/G03 direction match your Problem 2 prediction?
yes it does creates arc moves in both ways.
# Do the I/J values match your hand-calculated numbers (within rounding)?
not at all. because i created another value of radius to make a pocket and it does exactly 
runs the pocket as i expected including the i and j values that i had mentally calculated.
# Does K appear, and does that match what you found in Problem 1?
no, eventhough the K value suppose to apper as the circular_move has alredy defined it,yet it is not getting prited.
# Bonus modal check (ties to Day 9): if your toolpath has multiple consecutive arc segments in the same direction, does G_motion (G02/G03) stay modal, or does it needlessly repeat?
The modal works just fine, it get printed only when the dirction changes.


# output of the code:
%_N_setup_2_MPF
%
N10 G40 G17 G710 FNORM
TRAFOOF
SUPA G0 Z=_Z_HOME D0
SUPA G0 X=_X_HOME Y=_Y_HOME D1
S1061 M03
SUPA G0 Z=_Z_HOME D0
T="MILL_2"
M06
N20 G54
N30 G00 G90 X53.1 Y58.9
N40 G43 Z11. H02
N50 Z0.0
N60 G01 Z-8. F250. M08
N70 G03 X80.039 Y90.126 I-6.281 J32.651
N80 G01 X79.536 Y90.075
N90 G02 X24.425 Y67.655 I-32.717 J1.476
N100 G01 X24.029 Y67.34
N110 G03 X53.1 Y58.9 I22.79 J24.211
N120 G01 X53.525 Y56.691
N130 G03 X82.303 Y92.616 I-6.706 J34.861
N140 G01 X77.314 Y92.113
N150 G02 X24.593 Y70.665 I-30.495 J-.561
N160 G01 X20.67 Y67.542
N170 G03 X53.525 Y56.691 I26.149 J24.01
N180 X54.504 Y56.894 I-6.706 J34.861
N190 G00 Z11.
N200 X53.1 Y58.9
N210 Z0.0
N220 G01 Z-21.
N230 G03 X80.039 Y90.126 I-6.281 J32.651
N240 G01 X79.536 Y90.075
N250 G02 X24.425 Y67.655 I-32.717 J1.476
N260 G01 X24.029 Y67.34
N270 G03 X53.1 Y58.9 I22.79 J24.211
N280 G01 X53.525 Y56.691
N290 G03 X82.303 Y92.616 I-6.706 J34.861
N300 G01 X77.314 Y92.113
N310 G02 X24.593 Y70.665 I-30.495 J-.561
N320 G01 X20.67 Y67.542
N330 G03 X53.525 Y56.691 I26.149 J24.01
N340 X54.504 Y56.894 I-6.706 J34.861
N350 G00 Z11.
SUPA G0 Z=_Z_HOME D0
N360 M05
N370 M09
N380 M30
%