# problem-1

# linear_move block G_mode optional command applying in order to make it follow modal and to avoid redundand printing.

  BLOCK_TEMPLATE linear_move
  {
       G_cutcom[$mom_sys_cutcom_code($mom_cutcom_status)]\opt
       G_plane[$mom_sys_cutcom_plane_code($mom_cutcom_plane)]\opt
       G_motion[$mom_sys_linear_code]
       G_mode[$mom_sys_output_code($mom_output_mode)]\opt
       X[$mom_pos(0)]
       Y[$mom_pos(1)]
       Z[$mom_pos(2)]
       F[$feed]
       #S[$mom_spindle_speed]
       D[$mom_cutcom_adjust_register]\opt
       #M_spindle[$mom_sys_spindle_direction_code($mom_spindle_direction)]\opt
       M_coolant[$mom_sys_coolant_code(ON)]\opt
  }

#   ensuring does the G_mode has applied optional command.
  BLOCK_TEMPLATE rapid_traverse
  {
       G_motion[$mom_sys_rapid_code]
       G_mode[$mom_sys_output_code($mom_output_mode)]\opt
       X[$mom_pos(0)]
       Y[$mom_pos(1)]
       Z[$mom_pos(2)]
       S[$mom_spindle_speed]\opt
       M_spindle[$mom_sys_spindle_direction_code($mom_spindle_direction)]\opt
  }

#   ensuring does the G_mode has applied optional command.

  BLOCK_TEMPLATE rapid_traverse_xy
  {
       G_motion[$mom_sys_rapid_code]
       G_mode[$mom_sys_output_code($mom_output_mode)]\opt
       X[$mom_pos(0)]
       Y[$mom_pos(1)]
       #S[$mom_spindle_speed]\opt
       #M_spindle[$mom_sys_spindle_direction_code($mom_spindle_direction)]\opt
  }


  #   ensuring does the G_mode has applied optional command.
  BLOCK_TEMPLATE rapid_spindle_z
  {
       G_adjust[$mom_sys_adjust_code]
       G_motion[$mom_sys_rapid_code]
       G_mode[$mom_sys_output_code($mom_output_mode)]\opt
       Z[$mom_pos(2)]
       H[$mom_tool_adjust_register]\opt
  }

#output 

%_N_setup_2_MPF
%
N10 G40 G17 G710 FNORM
TRAFOOF
SUPA G0 Z=_Z_HOME D0
SUPA G0 X=_X_HOME Y=_Y_HOME D1
S1000 M3
SUPA G0 Z=_Z_HOME D0
T="MILL"
M06
N20 G54
N30 G00 G90 X150. Y12.53   ;G90 here only 
N40 G43 Z5. H01
N50 Z4.5
N60 G01 Z1.5 F300. M08
N70 X100.
N80 X0.0
N90 G02 Y46.25 I0.0 J16.86
N100 G01 X100.
N110 G03 Y79.97 I0.0 J16.86
N120 G01 X0.0
N130 X-50.
N140 Z4.5
N150 G00 Z5.
N160 X150. Y12.53
N170 Z4.
N180 G01 Z1.
N190 X100.
N200 X0.0
N210 G02 Y46.25 I0.0 J16.86
N220 G01 X100.
N230 G03 Y79.97 I0.0 J16.86
N240 G01 X0.0
N250 X-50.
N260 Z4.
N270 G00 Z5.  <---- G90 not repeted since the first appearing.
SUPA G0 Z=_Z_HOME D0
N280 M05 <--- i prefer this way dont mind.
N290 M09
N300 M30
%

# PROBLEM - 2

# Replace your hardcoded S1000 M3 literal in MOM_start_of_path with the direction-aware logic. 
# Test with your face milling operation — it uses M3 so output should be identical, but the logic now handles M4 correctly.
# Paste the updated proc and confirm output shows S1000 M3 still correct.

proc MOM_start_of_path { } {
#=============================================================
  global mom_sys_in_operation
   set mom_sys_in_operation 1

  global first_linear_move ; set first_linear_move 0
   TOOL_SET MOM_start_of_path

  global mom_sys_add_cutting_time mom_sys_add_non_cutting_time 
  global mom_sys_machine_time mom_machine_time 

   set mom_sys_add_cutting_time 0.0
   set mom_sys_add_non_cutting_time 0.0
   set mom_sys_machine_time $mom_machine_time

global mom_spindle_speed mom_spindle_direction
MOM_suppress once N
set Mcode ""
if {$mom_spindle_direction eq "CLW"} {
 set Mcode "M03"
} elseif {$mom_spindle_direction eq "CCLW"} {
   set Mcode "M04"
}

MOM_output_literal "S[expr int (${mom_spindle_speed})] $Mcode"


   if [CMD_EXIST PB_CMD_kin_start_of_path] {
      PB_CMD_kin_start_of_path
   }

   PB_CMD_start_of_operation_force_addresses

   
}

# output 
%_N_setup_2_MPF
%
N10 G40 G17 G710 FNORM
TRAFOOF
SUPA G0 Z=_Z_HOME D0
SUPA G0 X=_X_HOME Y=_Y_HOME D1
S1000 M04
SUPA G0 Z=_Z_HOME D0
T="MILL"
M06
N20 G54
N30 G00 G90 X150. Y12.53
N40 G43 Z5. H01
N50 Z4.5
N60 G01 Z1.5 F300. M08
N70 X100.
N80 X0.0
N90 G02 Y46.25 I0.0 J16.86
N100 G01 X100.
N110 G03 Y79.97 I0.0 J16.86
N120 G01 X0.0
N130 X-50.
N140 Z4.5
N150 G00 Z5.
N160 X150. Y12.53
N170 Z4.
N180 G01 Z1.
N190 X100.
N200 X0.0
N210 G02 Y46.25 I0.0 J16.86
N220 G01 X100.
N230 G03 Y79.97 I0.0 J16.86
N240 G01 X0.0
N250 X-50.
N260 Z4.
N270 G00 Z5.
SUPA G0 Z=_Z_HOME D0
N280 M05
N290 M09
N300 M30
%


# problem-3

# Two separate rapid lines. On 810D this is fine but your machine home sequence uses SUPA G0 not G00.
#  Verify that all programmed rapids in the cutting section correctly output G00 and are not accidentally using G0 format.


set mom_sys_rapid_code                        "0"


# checking Gmotion output digit
  ADDRESS G_motion
  {
      FORMAT      Digit_2
      FORCE       off
      MAX         9999 Truncate
      MIN         -9999 Truncate
      LEADER      "G"
  }
#   it confirms as two digt for rapid code get printed.

# output for confirming rapid code digits.


%_N_setup_2_MPF
%
N10 G40 G17 G710 FNORM
TRAFOOF
SUPA G0 Z=_Z_HOME D0
SUPA G0 X=_X_HOME Y=_Y_HOME D1
S1000 M04
SUPA G0 Z=_Z_HOME D0
T="MILL"
M06
N20 G54
N30 G00 G90 X150. Y12.53
N40 G43 Z5. H01
N50 Z4.5
N60 G01 Z1.5 F300. M08
N70 X100.
N80 X0.0
N90 G02 Y46.25 I0.0 J16.86
N100 G01 X100.
N110 G03 Y79.97 I0.0 J16.86
N120 G01 X0.0
N130 X-50.
N140 Z4.5
N150 G00 Z5.
N160 X150. Y12.53
N170 Z4.
N180 G01 Z1.
N190 X100.
N200 X0.0
N210 G02 Y46.25 I0.0 J16.86
N220 G01 X100.
N230 G03 Y79.97 I0.0 J16.86
N240 G01 X0.0
N250 X-50.
N260 Z4.
N270 G00 Z5.
SUPA G0 Z=_Z_HOME D0
N280 M05
N290 M09
N300 M30
%