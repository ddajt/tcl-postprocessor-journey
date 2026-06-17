#build day

if {[catch {source "pp_config.tcl"} result]} {
    puts "pp_config.tcl fetching error $result"
}


if {[catch {source "pp_helpers.tcl"} result]} {
    puts "pp_helpers.tcl fetching error $result"
} 

if {[catch {open "tools.txt" r} result]} {
    puts "$result"
} else {
    set tools [split [read $result] "\n"]
    close $result
   set fileW [open "final_program.nc" w]
   puts $fileW "$PROGRAM_NUMBER ($MACHINE)"
foreach tool $tools {
    set data [string trim $tool]
    if {[string length $data] <= 0 } continue
    if {[string match "#*" $data]} continue
     set Tnum ""; set dia ""
     regexp {(T[0-9]+)} $data m Tnum

     regexp "$Tnum\\s+(-?\[0-9.\]+)" $data m2 dia

     lassign [split $data " "] name dia mat status
     if {$status eq "worn"} continue
     puts $fileW [toolChange [string replace $Tnum 0 0 ""]]
     puts $fileW [rapidMove 10 10 50]
     puts $fileW [linearMove 10 10 -2 300]
}

puts $fileW "M30"
close $fileW

}

if {[catch {open "final_program.nc" r} result]} {
    puts "not avilable"
} else {
    while {[gets $result line]>=0} {
        set line [string trim $line]
        if {[string length $line]<=0} continue
        if {[string match "#*" $line]} continue
        puts "$line"
    }
    close $result
}