#practice-1

#Build a tool magazine system:

set magazine {}

proc load_tool {tnum} {
global magazine
 lappend  magazine $tnum

}

proc tool_loaded {tnum} {
global magazine
puts [expr [lsearch $magazine $tnum] + 1]
}

proc tool_position {tnum} {
    global magazine
    puts [expr [lsearch $magazine $tnum] + 1]
}

proc show_magazine {} {
    global magazine 
    set pos 0
    foreach tool  $magazine {
        puts "Position [expr $pos+1]: T0$tool"
        incr pos
    }
}

foreach tool {5 8 3 12 1} {
    load_tool $tool
}

tool_loaded 8
tool_loaded 99
#tool_position 12
tool_position 12

show_magazine

puts "\n\ "

proc ramp_feeds {sf ef} {
    set feed {}
for {set i $sf} {$i<=$ef} {set i [expr $i + 0.05]} {
   lappend feed $i 
}

 foreach f $feed {
    puts "F[format %05.3f $f]"
    }
    
}


ramp_feeds 0.050 0.250

puts "\n\ "

# practice -3

set operations {face_mill rough_turn finish_turn drill_center bore_finish}

proc run_sequence {} {
    global operations 

    foreach op $operations {
        if {[string match "rough*" $op]} {
            continue
        }
        puts "--- $op --- \n\ G01 operation:[string toupper $op]"
    }S
}
run_sequence