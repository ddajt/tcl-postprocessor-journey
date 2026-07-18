# Problem 1
# Check your current face milling output. Count how many times F300 appears. 
# If it appears more than once on cutting moves at the same feed rate, find the F address in your .def and confirm FORCE off is set. Paste the relevant address definition and your finding.

# solution:
# F300 appears exactly once — modal suppression working
# proof:
N70 G01 Z1.5 F300. M08
N80 X100.
N90 X0.0
N100 G02 Y46.25 I0.0 J16.86
N110 G01 X100.
N120 G03 Y79.97 I0.0 J16.86
N130 G01 X0.0
N140 X-50.
N150 Z4.5
N160 G00 Z5.
N170 X150. Y12.53
N180 Z4.
N190 G01 Z1.
N200 X100.
N210 X0.0
N220 G02 Y46.25 I0.0 J16.86
N230 G01 X100.
N240 G03 Y79.97 I0.0 J16.86
N250 G01 X0.0
N260 X-50.
N270 Z4.
N280 G00 Z5.
N290 M05
N300 M09
N310 M30
%


#2 

# In PB_auto_tool_change or MOM_start_of_path, add a dedicated spindle output line before the positioning move. 
# Use MOM_output_literal with the actual spindle speed variable
# Then suppress S and M_spindle from the rapid_traverse_xy block in your .def so they don't repeat on the positioning line.

#   BLOCK_TEMPLATE rapid_traverse_xy
#   {
#        G_motion[$mom_sys_rapid_code]
#        G_mode[$mom_sys_output_code($mom_output_mode)]\opt
#        X[$mom_pos(0)]
#        Y[$mom_pos(1)]
#        #S[$mom_spindle_speed]\opt
#        #M_spindle[$mom_sys_spindle_direction_code($mom_spindle_direction)]\opt
#   }

# this works to stop the spindle speed and dirction be redudant.
  BLOCK_TEMPLATE linear_move
  {
       G_cutcom[$mom_sys_cutcom_code($mom_cutcom_status)]\opt
       G_plane[$mom_sys_cutcom_plane_code($mom_cutcom_plane)]\opt
       G_motion[$mom_sys_linear_code]
       G_mode[$mom_sys_output_code($mom_output_mode)]
       X[$mom_pos(0)]
       Y[$mom_pos(1)]
       Z[$mom_pos(2)]
       F[$feed]
       #S[$mom_spindle_speed]
       D[$mom_cutcom_adjust_register]\opt
       #M_spindle[$mom_sys_spindle_direction_code($mom_spindle_direction)]\opt
       M_coolant[$mom_sys_coolant_code(ON)]\opt
  }


#  again stoping the spindle speeds get prints in the during cicular move
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


# here spindle speed and the dirction gets defined.
#=============================================================
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
MOM_output_literal "S${mom_spindle_speed} M3"

   if [CMD_EXIST PB_CMD_kin_start_of_path] {
      PB_CMD_kin_start_of_path
   }

   PB_CMD_start_of_operation_force_addresses

   
}




#3

# Your end of program currently outputs:
M09
M05
M30
%
# Add a Z home return before M09 using MOM_output_literal.

# solution:

# here the supervised home position for z axis gets added upon competion of operation.
proc MOM_end_of_program { } {
#=============================================================
  global mom_program_aborted mom_event_error
MOM_suppress once N
MOM_output_literal "SUPA G0 Z=_Z_HOME D0"
   MOM_do_template end_of_path
   MOM_do_template end_of_program
   MOM_set_seq_off
   MOM_do_template rewind_stop_code

  # Write tool list with time in commentary data
   LIST_FILE_TRAILER

  # Close warning and listing files
   CLOSE_files

   if [CMD_EXIST PB_CMD_kin_end_of_program] {
      PB_CMD_kin_end_of_program
   }
}


  incr mom_sys_post_initialized


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