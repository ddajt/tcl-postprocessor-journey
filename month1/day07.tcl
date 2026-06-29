#practice-1

# Practice 1 — Tool Call Proc
# Write a proc called tool_call that takes a tool number and outputs a formatted tool change block:
# T05 M06
# G43 H05
# Both lines from one proc. Tool number formatted as 2 digits. H offset matches tool number.
# Call it three times with tools 5, 12, and 3.



proc tool_call {tnum} {
     
        
        return "T[format %02d $tnum] M06\nG[format %2d 43] H[format %02d $tnum]"
    
}

puts [tool_call 3]
puts [ tool_call 5]
puts [tool_call 12]

puts "\n"
#practice - 3

# Practice 2 — Motion Type Handler
# Write a proc called motion_handler that takes a motion type string and returns the correct G-code word using switch.


# Then write a foreach loop that calls motion_handler for each item in this list:
# tcl{rapid linear arc_cw arc_ccw plunge}

# And prints:
# rapid    → G00
# linear   → G01
# arc_cw   → G02
# arc_ccw  → G03
# plunge   → UNKNOWN


proc motion_handler {move} {

switch $move {
    "rapid" {
        return " $move -> G[format %02d 0]"
    }

    "linear" {
        return " $move -> G[format %02d 1]"
    }

    "arc_cw" {
        return " $move -> G[format %02d 2]"
    }

    "arc_ccw" {
        return " $move -> G[format %02d 3]"
    }

    default {
        return " $move -> [string toupper unknown]"
    }
}

}

set G {rapid linear arc_cw arc_ccw plunge}

foreach g $G {
    puts [motion_handler $g]
}

puts "\n"

#practice-3


proc spindle_start {speed direction} {

    switch $direction {

        "cw" {
            return "S$speed M[format %02d 3]"
        }

        "ccw" {
            return "S$speed M[format %02d 4]"
        }
    }
}

proc coolant_on {material} {
    switch $material {
        "aluminum" {
            return "M07"
        }
 
 "steel" {
    return "M08"
 }

 "titanium" {
    return "M08 M07"
 }

 default {
    return "M09"
 }

    }
}

proc linear_move {x z feed} {
    return "G[format %02d 1] X[format %07.3f $x] Z[format %07.3f $z] F[format %05.3f $feed]"
}




proc minipost {speed direction material x z feed} {
    puts "G21 G40 G49"

    puts [spindle_start $speed $direction]
    puts [coolant_on $material ]
    puts [linear_move $x $z $feed]

    puts "M05 M09"

}



minipost 1200 "cw"  "steel" 100.251 -45.250 0.25