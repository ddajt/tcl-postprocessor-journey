# MOM_start_of_program    → header output
# MOM_tool_change         → tool call format
# MOM_linear_move         → cutting move output
# MOM_rapid_move          → positioning output
# MOM_end_of_program      → program end
# MOM_length_compensation → tool offset call
# MOM_set_csys            → work offset output
# MOM_drill / MOM_drill_move → cycle output



# Problem 1
# Find PB_start_of_program in Legacy_practice_post.tcl. 
# output the program name line before the % rewind code.

#=============================================================
proc PB_start_of_program { } {
#=============================================================
   if [CMD_EXIST PB_CMD_kin_start_of_program] {
      PB_CMD_kin_start_of_program
   }
   global mom_output_file_basename
   PB_CMD___log_revisions
   MOM_set_seq_off
   MOM_output_literal "%_N_${mom_output_file_basename}_MPF"
   MOM_do_template rewind_stop_code
   MOM_set_seq_on

   MOM_force Once G_cutcom G_plane G_mode
   MOM_do_template absolute_mode
   PB_CMD_fix_RAPID_SET

   if [CMD_EXIST PB_CMD_kin_start_of_program_2] {
      PB_CMD_kin_start_of_program_2
   }
}


# problem - 2 

# In Legacy_practice_post.def, find the absolute_mode block. 
# Add G710 and remove G71. Also add FNORM as a literal text word after the G-codes.


BLOCK_TEMPLATE absolute_mode

  BLOCK_TEMPLATE absolute_mode
  {
       G_cutcom[$mom_sys_cutcom_code(OFF)]
       G_plane[$mom_sys_cutcom_plane_code(XY)]
       #G_mode[$mom_sys_output_code(ABSOLUTE)]
       Text[G710]
       Text[FNORM]

  }



  #problem-3

#   Add the TRAFOOF and SUPA home sequence after the absolute_mode line.
#   Suppress sequence numbers on these lines using MOM_suppress once N before each literal output. 

#=============================================================
proc PB_start_of_program { } {
#=============================================================
   if [CMD_EXIST PB_CMD_kin_start_of_program] {
      PB_CMD_kin_start_of_program
   }
   global mom_output_file_basename
   PB_CMD___log_revisions
   MOM_set_seq_off
   MOM_output_literal "%_N_${mom_output_file_basename}_MPF"
   MOM_do_template rewind_stop_code
   MOM_set_seq_on

   MOM_force Once G_cutcom G_plane G_mode
   MOM_do_template absolute_mode
   MOM_suppress once N 
   MOM_output_literal "TRAFOOF"
   MOM_suppress once N 
   MOM_output_literal "SUPA G0 Z=_Z_HOME D0"
   MOM_suppress once N 
   MOM_output_literal "SUPA G0 X=_X_HOME Y=_Y_HOME D1"

   PB_CMD_fix_RAPID_SET

   if [CMD_EXIST PB_CMD_kin_start_of_program_2] {
      PB_CMD_kin_start_of_program_2
   }
}



#  The NC output 
%_N_setup_2_MPF
%
N10 G40 G17 G710 FNORM
TRAFOOF
SUPA G0 Z=_Z_HOME D0
SUPA G0 X=_X_HOME Y=_Y_HOME D1
N20 G91 G28 Z0.0
N30 T01 M06
N40 G54
N50 G00 G90 X150. Y12.53 S1000 M03
N60 G43 Z5. H01
N70 Z4.5
N80 G01 Z1.5 F300. M08
N90 X100.
N100 X0.0
N110 G02 Y46.25 I0.0 J16.86
N120 G01 X100.
N130 G03 Y79.97 I0.0 J16.86
N140 G01 X0.0
N150 X-50.
N160 Z4.5
N170 G00 Z5.
N180 X150. Y12.53
N190 Z4.
N200 G01 Z1.
N210 X100.
N220 X0.0
N230 G02 Y46.25 I0.0 J16.86
N240 G01 X100.
N250 G03 Y79.97 I0.0 J16.86
N260 G01 X0.0
N270 X-50.
N280 Z4.
N290 G00 Z5.
N300 M02
%
