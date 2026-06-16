#1
source "toolconfig.tcl"
puts "Machine: $MACHINE"
foreach arr [lsort [array names tools]] {
    # puts "$arr"
    set value $tools($arr)
     
    # puts "$arr | $dia | $mat | $status"
        set dia [lindex $value 0]
        set mat [lindex $value 1]
        set status [lindex $value 2]

        puts "${dia}mm | $mat | $status "


     
}


puts " \n"

#2


if {[file exists "gcodelib.tcl"]} {
     source "gcodelib.tcl"
} else {
    puts "Try with valid file"
}

puts [gcodeMove "G01" 100 50 -5 300]
puts [gcodeMove "G00" 0 0 50 0]

puts "\n"

#3


set values {
    {X10 Y10 Z-2 F300}
    {X20 Y20 Z-2 F300}
    {X30 Y30 Z-2 F300}
    {X40 Y40 Z-2 F300}
}

foreach arr [lsort [array names tools]] val $values {
set xval [string map {X ""} [lindex $val 0]]
set yval [string map {Y ""} [lindex $val 1]]
set zval [string map {Z ""} [lindex $val 2]]
set fval [string map {F ""} [lindex $val 3]]

puts [toolChange $arr]
puts [gcodeMove "G01" $xval $yval $zval $fval]
}

puts "\n"
#4


if {[file exists "gcode_helpers.tcl"]} {
    source "gcode_helpers.tcl"
} else {
    "file coulnd'nt be found"
}

puts  [gLine "G01" 100 50 -5]
puts [gLine "G01" 150 75 -3]
puts [gLine "G00" 0 0 50]


puts "\n"

#5

if {[file exists "machine_config.tcl"]} {
    source "machine_config.tcl"
} else {
    puts " file invalid"
}

puts "Machine: $MACHINE"
puts "Control: $CONTROL"
puts "Default feed: F$DEFAULT_FEED"
puts "Default speed: S$DEFAULT_SPEED"


puts "\n"

#6
if {[catch {


if {[catch {source "missing_file.tcl"} result]} {
    error "cannot source missing_file.tcl"
} else {
    puts "file now avail for use"
}

} fatalError]} {
    puts "Error:$fatalError"
}


if {[catch {source "gcode_helpers.tcl"} result]} {
    error "cannot source gcode_helpers.tcl"
} else {
    puts "Loaded gcode_helpers.tcl successfully"
    puts [gLine "G01" 10 20 -1]
}