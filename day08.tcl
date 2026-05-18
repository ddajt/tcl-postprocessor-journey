#practice -1

set current_feed 1.0

proc output_linear {x z feed } {

global current_feed



if {$feed != $current_feed} {
    set current_feed $feed

    puts "G01 X[format %07.3f $x] Z[format %07.3f $z] F[format %01.3f $feed]"
} else {
puts "G01 X[format %07.3f $x] Z[format %07.3f $z]"
}



}

output_linear 100.0 -10.0 0.250 
output_linear 100.0 -20.0 0.250 
output_linear 100.0 -30.0 0.150 
output_linear 100.0 -40.0 0.150 


puts "\n"

#practice 2

set state_spindle 0
set state_coolant 0
set state_tool 0

proc spindle_on {speed} {
    global state_spindle
    if {$state_spindle != $speed} {
        puts "S$speed M03"
        set state_spindle $speed
    } else {
        return
    }
}

proc coolant_on {} {
    global state_coolant

    if { $state_coolant == 0 } {
        puts "M08"
        set state_coolant 1
    } else {
        return
    }
}

proc tool_change {num} {
    global state_tool

    if {$num != $state_tool} {
        puts "T[format %02d $num] M06"
        set state_tool $num
    }
}

tool_change 5
spindle_on 1200
coolant_on
spindle_on 1200
tool_change 5
tool_change 8
coolant_on 


puts "\n"

#practice - 3


proc program_start {prognum} {
    return "O[format %05d $prognum]"
}

proc tool_call {tnum} {
    return "G21 G40 G49 G80 \n\T[format %02d $tnum] M06 \n\G43 H[format %02d $tnum]"
}

proc spindle_feed_start {speed feed} {
    return "S$speed M03 \n\F[format %01.3f $feed]"
}

proc program_end {} {
    return "M05 M09 \n\M30 "
}


proc generate_block {} {
    puts "%"
    puts [program_start 55]
    puts [tool_call 3]
    puts [spindle_feed_start 1500 .180]
    puts [program_end ]
    puts "%"
}

generate_block 