# practice -1
# question:
# At the very top of post_trial_001.tcl (line 1), 
# write a comment block that lists all five event procs, 
# what physical machine event each one handles, and roughly how many lines of code each one contains.


# solution:
# source "Legacy_practice_post.tcl" (post processor of NX)

# ============================================================
# POST MAP — post_trial_001
# ============================================================
# MOM_start_of_program  → [during start of the foremost post,cleanig up all the variables, firing up events and declarign new variables]  → [57] lines
# MOM_tool_change       → [M06,during tool chnge event, toolchecking, deciding manul or auto tool load]  → [around 20] lines
# MOM_linear_move       → [during tool linerar G01,G00 movement dedected]  → [6] lines
# MOM_arc_move          → [when G02,G03 or arc,radius,circle move dedicted]  → [not defined in this file] lines
# MOM_end_of_program    → [during progam end M30 ]  → [around 12 lines] lines
# ============================================================


# practice -2

# question:  Locate and annotate MOM_start_of_program
# Open post_trial_001.tcl in VS Code.
# Find MOM_start_of_program.
# Write a comment on every single line inside it.

# solution:
proc MOM_start_of_program { } {
#=============================================================
# native variabel perhaps asking log entry name and and current date,is_from variable calling, calling into this proc to ensure these datas
  global mom_logname mom_date is_from
# out side this proc this two is not declared. asking the coolant status, cutcom status (idk what it is) into this proc to access perhaps cheking the state
  global mom_coolant_status mom_cutcom_status
#clamp is unclamped or clamped checking purpose it is gets called inside here before running the start of the program. also it cheks mom_cycle_status asking for some cycle idk what exactly it is but it didnt defined out side of this proc
  global mom_clamp_status mom_cycle_status
#   asking for spindle status before starting the program cheking spindle is in idle or running anothr is mom_outcom_plane idk what it is same as pb_start_of_program_flag
  global mom_spindle_status mom_cutcom_plane pb_start_of_program_flag
#   some register for outcome adjust and tool adjust but idk whre it is defined out side of this proc, perhaps tool register knowing tool current number on the spindle and the outcome register might be for somthingelse like part count till now 
  global mom_cutcom_adjust_register mom_tool_adjust_register
#   again didnt seem it  got declared out side of this proc but something tells me this tool length register could be for tool lenth wear coulmn taking how much input now it has before starting the program
# length comp register is obviously seem like it is tool offset currnt lenght knowing for the current tool 
  global mom_tool_length_adjust_register mom_length_comp_register
#   idk what is flush register and wire cutcom adjust register it also didnt declared outside.
  global mom_flush_register mom_wire_cutcom_adjust_register
#   what it says wire cut status are we using cnc miling 3axis right i am quite confused here. idk what status it is and it didnt got declared outside of this proc
  global mom_wire_cutcom_status
#  now it is resetting the global called variable flag as 0 what is it for idk
    set pb_start_of_program_flag 0
   # it is resetiing coolant status is currnly undefined why though?
    set mom_coolant_status UNDEFINED
#   resetting the status of cutcom as undefined for why thouhg?
    set mom_cutcom_status  UNDEFINED
   #  resetting clamp status as undefined once reading those values and applying it then resetting as undefined would be understandable but this one spooky
    set mom_clamp_status   UNDEFINED
   #   again the same resetting for cycle status
    set mom_cycle_status   UNDEFINED
   #  restting the variable spindle status
    set mom_spindle_status UNDEFINED
   #  resetting the variable cutcom plane
    set mom_cutcom_plane   UNDEFINED
   #  resetting the variable wire cutcome status 
    set mom_wire_cutcom_status  UNDEFINED
#  catching the variable while unsetting it idk why it want to delete the variable and i get it why it wrapped in catch perhaps it containg a delicate value might endup in error sometimes
    catch {unset mom_cutcom_adjust_register}
   #  catching tool adjust register what this variable is for? where it from alredy we have tool length register, length comp register idk why this one used for
    catch {unset mom_tool_adjust_register}
# catching the tool length adjut value from the register, yes i get it perhaps it might empty they did not input the value yet in the toool lenth ofset coulmn so gracefully catching it before the fatal
    catch {unset mom_tool_length_adjust_register}
   #  catching tools wear coulmn values avoid error if it was empty incoming
    catch {unset mom_length_comp_register}
   #  i think this one also has to be updated coulmn data, and it prone to income as empty but not know what kind and what it is used for 
    catch {unset mom_flush_register}
   #  same needed physical update from the machine but prone to come as empty so  better catching it
    catch {unset mom_wire_cutcom_adjust_register}
   # resetting the is_from variable value as empty string why it get resetting before the grabbed value get used in proc by proc itself
    set is_from ""
#  it is caching a varible and not saving it or using it just catching it only idk what purpose it does it 
    catch { OPEN_files } ;# Open warning and listing files
   #  this one seem like proc name or variable intialization with nothing given as value
    LIST_FILE_HEADER     ;# List header in commentary listing    


#  there is one variable with same name which enables some set of actions like debug on of and sourcing $cam_post_dir  under certain condtion and listing some variables inside doing lot of stuffs that my understanding excceds.
# here it got invited into this start of the program proc 
  global mom_sys_post_initialized
#    it getting checked inside if condtion whether the the variable still defined or not if it was defined then it will return above 1 values and it gets returned idk what relevent it has here
  if { $mom_sys_post_initialized > 1 } { return }

# intersting here i see somting like CSS before after style applying symbol :: i wonder what it here doing ? and what is clock though?
  set ::mom_sys_start_program_clock_seconds [clock seconds]

   # Load parameters for alternate output units (this comment i did not write)
   # (i am writing ) this one i do know what it does and right next line to it there is a rename command never heard of it before doing somthing here
    PB_load_alternate_unit_settings
    rename PB_load_alternate_unit_settings ""


#************
# i thought uplevel is used to define inside the proc to use global variable and to use double nested arrays but here somthing else use case happening 
uplevel #0 {


#=============================================================
# another proc getting defined inside this proc  as sync i wonder what it does
proc MOM_sync { } {
#=============================================================
# okay this one asks somthing like if length of this command name has above zero then go for to call the command it could be proc or could be bare cutom command 
  if [llength [info commands PB_CMD_kin_handle_sync_event] ] {
    PB_CMD_kin_handle_sync_event
  }
}


#=============================================================
# here another proc calling another command if it exist using lenght if not it get overlooked ajth visited that proc 
proc MOM_set_csys { } {
#=============================================================
  if [llength [info commands PB_CMD_kin_set_csys] ] {
    PB_CMD_kin_set_csys
  }
}

# here defining one empty proc for purpose that i not know of
#=============================================================
proc MOM_msys { } {
#=============================================================
}

#  great inside start of the program proc there is an end of progarm proc 
#=============================================================
proc MOM_end_of_program { } {
#=============================================================

# making accessible two variables that are defined somewhere not in this file
  global mom_program_aborted mom_event_error
# calling the command in this name MOM_do_template, end_of_program,MOM_set_seq_off ajth comment stops here 
   

   MOM_do_template end_of_program
   MOM_set_seq_off

   MOM_do_template rewind_stop_code

  # Write tool list with time in commentary data (did not writen by ajith)
#   now writng by ajth here one  command get called but nowhere else it get called or used or defined idk why. ajith stops. 
   LIST_FILE_TRAILER 

  # Close warning and listing files (not by ajith comment)
#   ajith writting here one command gets called but nowhere else it get called or used or defined idk why. ajith stops.
   CLOSE_files 

# ajith writing here again the if conditon checking happning using custom command if it is exist it get called but this seems like no proc but pure command what it does not obvious to me ajith stops
   if [CMD_EXIST PB_CMD_kin_end_of_program] {
      PB_CMD_kin_end_of_program
   }
}

# incrementing the main variable that allows the if condtion to do some important stuffs idk what it exactly helps teach me all from the start of my comment because most of them are my guess work ajth stops here
  incr mom_sys_post_initialized



} ;# uplevel
#***********


}


proc PB_CMD_kin_set_csys { } {
#=============================================================
# - For mill post -
#

  # Output NC code according to CSYS (i didnot write this commnet)

#   now i am writting this comment : here below this custom proc defined line that only to check somthing exist or not is asking PB_CMD_set_csys exist by taking inside the custom defined proc 
# if exist call that proc 
   if { [CMD_EXIST PB_CMD_set_csys] } {
      PB_CMD_set_csys
   }

  # Overload IKS params from machine model.(ajith did not write this comment)
#   ajith writing this comment : here some other proc gets called  ajith visted that proc . now comment stop from ajth
   PB_CMD_reload_iks_parameters

  # In case Axis Rotation has been set to "reverse" (not writen by ajth)
#   ajith writting  here also custom command checks a command or proc exixt or not if exixt conditon allows to call proc comment stops from ajith and ajth visting the proc ajith vistied the command there is no proc defind in that name but it seem like custom command stops from ajith
   if { [CMD_EXIST PB_CMD_reverse_rotation_vector] } {
      PB_CMD_reverse_rotation_vector
   }
}



#  practice -3


# question : Find MOM_tool_change and MOM_linear_move.
# In a comment block at the top of each proc, 
# write which Month 1 concepts you can see being used.

# solution :
#=============================================================
proc MOM_tool_change { } {
#=============================================================

# declaring global variables here inside this proc to access
   global mom_tool_change_type mom_manual_tool_change
   global mom_tool_number mom_next_tool_number
   global mom_sys_tool_number_max mom_sys_tool_number_min
   # the if conditon asks given tool number is lessthan defined tool number min using variables
   # or is it greater than alredy defined tool variable. 

   if { $mom_tool_number < $mom_sys_tool_number_min || \
        $mom_tool_number > $mom_sys_tool_number_max } {
# declaring global variable again inside proc access
      global mom_warning_info
      # dynamic warning setting using the actual values inside the varible
      set mom_warning_info "Tool number to be output ($mom_tool_number) exceeds limits of\
                            ($mom_sys_tool_number_min/$mom_sys_tool_number_max)"
      # calling a proc here to show the warninig right away 
      MOM_catch_warning 
   }

# checking using info exist for variable prsent or not 
   if { [info exists mom_tool_change_type] } {
      #  using switch case here if a variable value comes with either of the below defined name then call a proc to react
      # in elseif checking manual tool change exist or not then if block inside if block comparing the variable value to a string using string compare fliping the logic with not operator,  condtion met upon a proc get called
      switch $mom_tool_change_type {
         MANUAL { PB_manual_tool_change }
         AUTO   { PB_auto_tool_change }
      }
   } elseif { [info exists mom_manual_tool_change] } {
      if { ![string compare $mom_manual_tool_change "TRUE"] } {
         PB_manual_tool_change
      }
   }
}




#=============================================================
proc MOM_linear_move { } {
#=============================================================

# it seem like proc call but proc is not defined inside this file
   ABORT_EVENT_CHECK
# calling another proc to define the move and confirm its varible existense
   HANDLE_FIRST_LINEAR_MOVE
# proc not defined in this file
   PB_CMD_suppress_linear_block_plane_code
   #  do temlplate proc might from ugbse.tcl called with argument
   MOM_do_template linear_move
}
