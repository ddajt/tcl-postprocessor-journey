set tools {T01 12.5 HSS T02 8.0 Carbide T03 6.0 HSS}
# array set T {$tools}

# foreach tool [array names T] {
#    puts " $tool: $T($tool)"
# };

foreach {tool dia mat} $tools {
    puts " $tool : $dia - $mat"
}


#practice-1
set flatList {
T01, 12.5, HSS, 3
T02, 8.0, Carbide, 4
T03, 6.0, HSS, 2
T04, 4.5, Carbide, 2 
}
# puts $flatList

set list [ join [split $flatList ","] " " ]
puts "$list"

foreach {t d m fcount} $list {
   puts " $t | D=$d | $m | $fcount-flute"
}

puts "\n "
#practice -2

set nestedList {

{T01 12.5 HSS 3}
{T02 8.0 Carbide 4}
{T03 6.0 HSS 2}
{T04 4.5 Carbide 2}

 }

puts "Carbide tools :"
 foreach toold $nestedList {
    set name [lindex $toold 0]
        set dia [lindex $toold 1]
            set mat [lindex $toold 2]
                set fls [lindex $toold 3]
            

              if {$mat eq "Carbide"} {
                    
                   puts "$name"
                }
             

        
            
 }


puts "Diameter > 6.0:" 
 foreach toold $nestedList {
    set name [lindex $toold 0]
        set dia [lindex $toold 1]
            set mat [lindex $toold 2]
                set fls [lindex $toold 3]
            
 
               

if {$dia >6 } {
                puts "$name "
            }
        
                 
            
 }


 #practice-3

 set moves {
    {G01 100.0 50.0 -5.0 300}
    {G01 150.0 75.0 -5.0 300}
    {G00 0.0 0.0 50.0 0}
}


foreach mov $moves {

    set gcode [lindex $mov 0]
    set X [lindex $mov 1]
    set Y [lindex $mov 2]
    set Z [lindex $mov 3]
    set feed [lindex $mov 4]
   
        if {$feed == 0} {
            puts "$gcode X[format %.3f $X] Y[format %.3f $Y] Z[format %.3f $Z]"
        } else {
                            puts "$gcode X[format %.3f $X] Y[format %.3f $Y] Z[format %.3f $Z] F$feed"
        }
   
}