
# problem -1
# IN PB_auto_tool_change, replace MOM_do_template tool_change with MOM_output_literal calls that output the correct 810D home sequence before tool change.

  BLOCK_TEMPLATE tool_change
  {
       ;G_mode[$mom_sys_output_code(INCREMENTAL)]
       ;G[$mom_sys_return_code]
       ;Z[0]
       Text[SUPA G0 Z=_Z_HOME D0]
  }


# problem-2
# In tool_change_1 block in .def, the tool outputs as T[$mom_tool_number].
# For 810D it needs to output T="toolname".

  BLOCK_TEMPLATE tool_change_1
  {
       T[$mom_tool_number]
       M[$mom_sys_tool_change_code]
  }




proc PB_CMD_tool_name_output {} {
   global mom_tool_name
   MOM_suppress once N
   MOM_output_literal "T=\"${mom_tool_name}\""
}

#=============================================================
proc PB_auto_tool_change { } {
#=============================================================
   global mom_tool_number mom_next_tool_number
   if { ![info exists mom_next_tool_number] } {
      set mom_next_tool_number $mom_tool_number
   }

   MOM_force Once G_mode G Z
   MOM_suppress once N
   MOM_do_template tool_change
   PB_CMD_tool_change_force_addresses

   MOM_force Once T M
   # MOM_do_template tool_change_1
   PB_CMD_tool_name_output

   MOM_do_template tool_change_2
}





# problem-3

# Find end_of_program block in your .def: do the requied edit to add coolant turn off code, spindle turn off code and progrma end rewind code.


  BLOCK_TEMPLATE end_of_path
  {
       
       M_spindle[$mom_sys_spindle_direction_code(OFF)]
       M_coolant[$mom_sys_coolant_code(OFF)]
  }

  BLOCK_TEMPLATE end_of_program
  {    
       M[$mom_sys_rewind_code]
       
  }

uplevel 0{

proc MOM_end_of_program { } {
#=============================================================
  global mom_program_aborted mom_event_error
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


} ;# uplevel




# output
%_N_setup_2_MPF
%
N10 G40 G17 G710 FNORM
TRAFOOF
SUPA G0 Z=_Z_HOME D0
SUPA G0 X=_X_HOME Y=_Y_HOME D1
SUPA G0 Z=_Z_HOME D0
T="MILL"
N20 T01
N30 G54
N40 G00 G90 X150. Y12.53 S1000 M03
N50 G43 Z5. H01
N60 Z4.5
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
N290 M05 M09
N300 M30
%