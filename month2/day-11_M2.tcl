# problem -1
# Problem 1 — Map the full parameter gap.
# Write out CYCLE81(RTP, RFP, SDIS, DP, DPR) as a comment. 
# For each parameter, note whether your current cycle_drill block template has a matching mom_ variable already available, or whether it's completely missing (like RFP/SDIS above). 
# This is your gap list


  BLOCK_TEMPLATE cycle_drill
  {
       G_plane[$mom_sys_cutcom_plane_code($mom_cutcom_plane)]\opt
       G_motion[$mom_sys_cycle_drill_code]
       X[$mom_cycle_feed_to_pos(0)]
       Y[$mom_cycle_feed_to_pos(1)]
       Z[$mom_cycle_feed_to_pos(2)]
       R[$mom_cycle_rapid_to_pos($mom_cycle_spindle_axis)]
       F[$feed]
  }

# cycle_drill didnt have the main parameter for siemiense 810D drill cycle
#  what the block lacks:
RFP --> Referece plane  fatal
SDIS --> safety distance fatal
#  what are avilabe :
RTP --> Retract plane 
DP --> final depth
DPR --> Depth relative to refrece plane. (not mandatory yet as a option should be given)

# Problem 2 — Hand-calculate a real CYCLE81 call.

# This is suppose should be simense810D output code, unlike current post processor version. 
SUPA G0 Z=_Z_HOME D0
SUPA G0 X=_X_HOME Y=_Y_HOME D3
N390 TRAFOOF
G54
G0 X0.0 Y0.0 Z3 S600 D3 M3
F9.8
MCALL CYCLE81(25,0.,2,-15)
X.5906 Y1.9685
MCALL
SUPA G0 Z=_Z_HOME D0
SUPA G0 X=_X_HOME Y=_Y_HOME D3
M5
M30


# Problem 3 — Generate real output and confirm the gap.


#currently post processor misaglied from the simense 810D program output.
# it didnt called Mcall cycle 81 at all need to be tweaked.
# it is defined for funuc like structure output.

%_N_setup_2_MPF
%
N10 G40 G17 G710 FNORM
TRAFOOF
SUPA G0 Z=_Z_HOME D0
SUPA G0 X=_X_HOME Y=_Y_HOME D1
S0 M03
SUPA G0 Z=_Z_HOME D0
T="STD_DRILL"
M06
N20 G54
N30 G00 G90 X15. Y50.
N40 G43 Z10. H03
N50 G81 X15. Y50. Z-56.91 R3. F250.
N60 G80
SUPA G0 Z=_Z_HOME D0
N70 M05
N80 M09
N90 M30
%