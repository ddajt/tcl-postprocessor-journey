#1
set lines {
    "G01 X100.500 Y-50.250 Z-5.000 F300"
    "G00 X0.0 Y0.0 Z50.0"
    "G02 X50.0 Y25.0 R10.0 F150"
    "T03 M06"
}

# foreach line $lines {

#     if { [regexp {^G0[012]} $line ] || [regexp {^T[0]} $line]} {
#           set G0x [regexp -inline {X(-?[0-9.]+)} [regexp {^G0[0]} $line] m]
#           set G0y [regexp -inline {Y(-?[0-9.]+)} [regexp {^G0[0]} $line] m]
#           set G0z [regexp {Z(-?[0-9.]+)} [regexp {^G0[0]} $line] m]

#           set G01x [regexp {X(-?[0-9.]+)} [regexp {^G0[1]} $line] m]
#           set G01y [regexp {Y(-?[0-9.]+)} [regexp {^G0[1]} $line] m]
#           set G01z [regexp {Z(-?[0-9.]+)} [regexp {^G0[1]} $line] m]

#           set G02x [regexp {X(-?[0-9.]+)} [regexp {^G0[2]} $line] m]
#           set G02y [regexp {Y(-?[0-9.]+)} [regexp {^G0[2]} $line] m]
#           set G02z [regexp {Z(-?[0-9.]+)} [regexp {^G0[2]} $line] m]
          
#           regexp {T(-?[0-9.]+)} $line mal
          
#           puts "$mal"


#     }
# }

foreach line $lines {
    if { [regexp {^G0[012]} $line val] || [regexp {T(-?[0-9.]+)} $line matchT1 tool1]} {
         set x ""
        # set y "";set z ""
     regexp {G0(-?[0-9.]+)} $line match x
    #  regexp {Y(-?[0-9.]+)} $line matchy y
    #  regexp {Z(-?[0-9.]+)} $line matchz z
      set arr($val,X) $line
    #   set arr($val,Y) $matchy
    #   set arr($val,Z) $matchz

    #   set tool ""
    #   regexp {T(-?[0-9.]+)} $line matchT tool
    #   set feed [regexp -inline {F(-?[0-9.]+)} $line val]

if {[regexp {T(-?[0-9.]+)} $line m v]} {
        #  puts "$val : $arr($val,X)"
         puts "Tool change: $matchT1"
} else {

     puts "$val : [string map  [list $val ""] $arr($val,X)] "
    #  puts "$tool"
}





    }
}

puts "\n"
#2

set gcode {
    "G01 X100.0 Y50.0 F300"
    "G01 X150.0 Y75.0 F250"
    "G00 X0.0 Y0.0"
    "G01 X50.0 Y25.0 F400"
}


 



foreach code $gcode {
    set count [regsub {F[0-9.]+} $code F500 result]

    # if {![regsub {F[0-9]+} $code F500 result]} {
    #     puts " NO feed: skipped"
    #     puts "\n"
    # }

    # if { [regsub {F[0-9]+} $code F500 result]} {
    # puts "\n"
    # puts "Orginal: $code"
    # regsub -all {F[0-9]+} $code "F500" newresult
    #  puts "Modified: $newresult"

    # }

if {$count == 0 } {
    puts "No feed:skipped \n"
} else {
    puts "Orginal: $code"
    puts "Modified: $result \n"
}
    
    

}


#3

if {[catch {open "tools.txt" r} result]} {
    puts " invalid read"
} else {
 set block [split [read $result] "\n"]
 close $result

foreach line $block {
    set line [string trim $line]
    if {[string length $line] == 0} continue
    if {[string match "#*" $line]} continue
     set dia ""
     set tool ""

    if { [regexp {(T[0-9]+)} $line match1 tool] } {

      if {[regexp "${tool}\\s+(-?\[0-9.\]+)" $line match2 dia]} {
         
        #  puts "$dia"

        if {$dia > 6} {
            set counter $dia
            puts "$tool: dia=$dia \[Large\]" 
        } else {
            puts "$tool: dia=$dia"
        }
      }
    }
   
    
}

}

