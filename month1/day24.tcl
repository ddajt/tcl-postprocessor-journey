#1
if {[catch {open "program.nc" w} data]} {
    puts "cannot write"
} else {

set gcode { O0001 (VMC-850 PROGRAM)
(DATE: 2024-01-15)
(OPERATOR: AJITH)
G90 G94 G17 G21
G28 G91 Z0
T01 M06
G90 G54
S1200 M03
G00 X0.0 Y0.0
G43 H01 Z50.0
G01 Z-5.0 F300
G01 X100.0 Y50.0 F300
G00 Z50.0
M05
M30 }

set lines [split $gcode "\n"]
    foreach writer $lines {
        set writer [string trim $writer]
        if {[string length $writer] == 0} continue
        if {[string match "#*" $writer]} continue
        puts $data $writer
    }
}

close $data

if {[catch {open "program.nc" r} data]} {
    puts "error though"
} else {
    while {[gets $data thagaval] >=0} {
         set thagaval [string trim $thagaval]
         if {[string length $thagaval] == 0} {
            continue
         }
         if {[string match "#*" $thagaval]} {
            continue
         }
        puts "$thagaval"
    }
}

close $data


#2

puts "\n "


if {[catch {open "tools.txt" r} result]} {
    puts "invalid read"
} else {

    set newdata [open "tool_report.txt" w]
    puts $newdata "=== Tool Report ==="
    set countAc 0
    set countWr 0


    puts $newdata "Active Tools:"
    puts "Active Tools:"
    set rawData [split [read $result] "\n"]
    close $result 

    foreach line $rawData {
        set line [string trim $line]
        if {[string length $line] == 0} continue
        if {[string match "#*" $line]} continue


        set name [lindex $line 0]
        set dia [lindex $line 1]
        set status [lindex $line 3]
   if {$status eq "active"} {
    incr countAc 
    set data "$name | ${dia}mm | $status"
    puts $data
    puts $newdata $data
   }

 }

    puts $newdata "Worn Tools:"

    puts "Worn Tools:"

    foreach line $rawData {
        set line [string trim $line]
        if {[string length $line] == 0} continue
        if {[string match "#*" $line]} continue

        set name [lindex $line 0]
        set dia [lindex $line 1]
        set status [lindex $line 3]
   
if {$status eq "worn"} {
    incr countWr 
    set data "$name | ${dia}mm | $status"
    puts $data
    puts $newdata $data
   }

        
       
}

 puts $newdata "Total: [expr $countAc + $countWr] tools | Active: $countAc | Worn: $countWr"
puts "Total: [expr $countAc + $countWr] tools | Active: $countAc | Worn: $countWr"

close $newdata

}








if {[file exists "tool_report.txt"]} {
    set printtool [open "tool_report.txt" r]
    # while {[gets $printtool line] >=0 } {

    set line [split [read $printtool] "\n"]
    close $printtool
    # set countAc 0
    # set countWr 0

# puts "Active Tools:"
    foreach lin $line {

    

         set lin [string trim $lin]
        if {[string length $lin] == 0} continue
        if {[string match "#*" $lin]} continue
    #   set name [lindex $lin 0]
    #   set dia [lindex $lin 1]
    #   set mat [lindex $lin 2]
    #   set status [lindex $lin 3]

    #   if {$status eq "active"} {
    #     puts "$name | ${dia}mm | $mat"
    #     incr countAc
    #   }

        puts "$lin"
    }

    
# puts "Worn Tools:"
#     foreach lin $line {

    

#          set lin [string trim $lin]
#         if {[string length $lin] == 0} continue
#         if {[string match "#*" $lin]} continue
#       set name [lindex $lin 0]
#       set dia [lindex $lin 1]
#       set mat [lindex $lin 2]
#       set status [lindex $lin 3]

#       if {$status eq "worn"} {
#         puts "$name | ${dia}mm | $mat"
#         incr countWr
#       }

#         # puts "$line"
#     }

# puts " Total:[expr $countAc + $countWr] tools | Active: $countAc | Worn: $countWr"
    # }
} else {
    puts "invalid read"
}




puts "\n\ "

#3

set program {
    {T01 S1200 F300 X100.0 Y50.0 Z-5.0}
    {T02 S800  F150 X50.0  Y25.0 Z-3.0}
    {T03 S1500 F250 X75.0  Y40.0 Z-4.0}
}

proc writeGcode {flname prog} {
    
    if {[catch {open $flname w} result]} {
        puts "invalid write"
    } else {

set files {}


    foreach pro $prog {
        set n [lindex $pro 0]
        set speed [lindex $pro 1]
        set feed [lindex $pro 2]
        set x [lindex $pro 3]
        set y [lindex $pro 4]
        set z [lindex $pro 5]

set hval [string map {T ""} $n]
set snum [string map {S ""} $speed]
set fnum [string map {F ""} $feed]

set code "
$n M06
S$snum M03
G00 $x $y
G43 H$hval Z50.0
G01 $z F$fnum
G01 $x $y F$fnum
G00 Z50.0
"

lappend files $code
    

    }

    puts $result "O0001 (GENERATED PROGRAM)"

foreach fl $files {
    puts $result $fl
}

puts $result "M05"
puts $result "M30"
close $result
return $flname 



    }



}


set fl [writeGcode "cnc.txt" $program]
puts "$fl"

if {[catch {open $fl r} result]} {
    puts "invalid read "
} else {
    while {[gets $result line] >=0} {
        set line [string trim $line]
        if {[string length $line] == 0} continue
        if {[string match "#*" $line]} continue
        puts "$line"
        
    }
    close $result
}