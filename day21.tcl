#practice-01


set lines {
    "   G01 X100.0 Y50.0 F300   "
    "###G02 X50.0 Y25.0 R10.0###"
    "000G00 X0.0 Y0.0 Z50.0"
    "G01 X150.0 Y75.0 F250   "
}


# puts [llength $lines]
# puts [lindex $lines 0]
# puts [string is list $lines]tclsh day21.tcl

foreach li $lines {

    # if {[string match "   G0*" $li] && [string match "*0   " $li]} {
    #     puts "[string trim $li]"
    # } 
    # if {[string match "###G0*" $li] && [string match "*0.0###" $li]} {
    #     puts "[string trim $li "#"]"
    # } 
    # if {[string match "000G0*" $li]} {
    #      puts "[string trimleft $li "0"]"
    # }

    # if {[string match "*0   " $li] &&  ![string match "   G0*" $li]} {
    #     puts "[string trim $li]"
    # } 

    set clean [string trim $li]
    set clean [string trim $clean "#"]
    set clean [string trim $clean "0"]
    set clean [string trimleft $clean]
    puts "$clean"
}

puts "\n\ "

# practice-2

set gline "G01 X100.500 Y-50.250 Z-5.000 F300"

puts "Length: [string length $gline]"
if {[string first "Z" $gline]>=0} {
    puts "Z axis present"
} else {
    puts "no Z"
}

if {[string first "X" $gline]} {
    puts "X word: [string range $gline 4 11]"
}

puts "Rapid version: [string map {"G01" "G00"} $gline]"
if {[string match "*F300*" $gline]} {
   puts "Feed present: Yes"
}

if {[string match "G0*" $gline]} {
    puts "Starts with G0: Yes"
}

puts "\n\ "

#practice-3

set rawTools {
    "  t01_rough_hss  "
    "T02_FINISH_CARBIDE"
    "t03_rough_carbide  "
}

foreach rw $rawTools {
    # if {[string match "  t*" $rw] && [string match "*  " $rw] && [string match "*rough*" $rw]} {
    #  puts "[string map {_ -} [string toupper [string trim $rw]]] \[ROUGH\]"
    # }
    # if {![string match "  t*" $rw] && [string match "*  " $rw] && [string match "*rough*" $rw]} {
    #   puts "[string map {_ -} [string toupper [string trim $rw]]] \[ROUGH\]"
    # }
    # if {[string match "*FINISH*" $rw]} {
    #   puts "[string map {_ -} [string toupper $rw]] \[FINISH\]"
    # }

    set clean [string trim $rw]

    if {[string match "*rough*" $clean]} {
       puts "[string map {_ -} [string toupper $clean]] \[ROUGH\]"
    }
        if {[string match "*FINISH*" $clean]} {
       puts "[string map {_ -} [string toupper $clean]] \[FINISH\]"
    }
}
