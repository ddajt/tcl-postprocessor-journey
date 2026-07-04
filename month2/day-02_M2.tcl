# practice-01

# qus:In your post file, find every place mom_pos is used — search the whole file. List every proc where it appears and what it's being used for in that specific spo

# PB_CMD__handle_end_of_subop_path -uses mom_pos is used to grab the values of x,y,z,4th,5th axis current postion in a dynamic way by calling the VMOV proc.

# Rapid_Set proc also using mom_pos for knowing last postion and target postion are the same in order to stop outputing that partcualr axis immovement at that time.
# also it checks the postion for non principle traver axis's whether their movement is fixed up to certain point then prints the code  without mentionning the axis.
# also checks wheter the mom_pos postion is less than mom_last spindle position using the mom_pos array.
# in Rapind_Set proc mom_pos use cheks against mom_prev_pos postion coordinate to check the traverse axis1 and traverse_axis2 movemet was still while rest of the axis running and decide ussing the conditon 
# to not to output the axis for those traverse axis untill there movment are detected.


# pracitce- 2

# Write a small standalone test proc — doesn't need to run inside NX, just write it in a separate scratch .tcl file in VS Code — that takes three numbers representing mom_pos(0), mom_pos(1), mom_pos(2) and prints them formatted like an actual NC line
 
array set mom_pos {0 100 1 50 2 -10}

proc standAlone {pos} {
    upvar $pos p1
   
    puts "X[format %7.3f $p1(0)] Y[format %7.3f $p1(1)] Z[format %7.3f $p1(2)]"
   }

standAlone mom_pos


# practice-3
# qus:Find mom_arc_center(0) and mom_arc_center(1) — they are not in Legacy_practice_post.tcl itself; you will not find them by searching this file. In a comment, explain why, based on what you learned on Day 1 about where variables come from and which procs are or aren't overridden in your post.

# ans:
# mom_arc_center(0) and mom_arc_center(1) are not in Legacy_practice_post.tcl
# because MOM_arc_move is not overridden in this file — the default from ugpost_base.tcl handles it.
# These variables are not defined in any Tcl file. NX's internal C++ engine injects them
# directly into the Tcl interpreter before MOM_arc_move fires, same mechanism as mom_pos.