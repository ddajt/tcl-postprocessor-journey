#practice 1
set magazine {
{T01  12.5  HSS     3-flute  active}
{T02  8.0   Carbide 4-flute  active}
{T03  6.0   HSS     2-flute  worn}
{T04  4.5   Carbide 2-flute  active}
{T05  16.0  Carbide 4-flute  worn}
}
puts "Tool Magazine Data"
foreach Tool $magazine {
    set tool [lindex $Tool 0]
    set dia [lindex $Tool 1]
    set mat [lindex $Tool 2]
    set flute [lindex $Tool 3]
    set status [lindex $Tool 4]

puts " $tool | $dia | $mat | $flute | $status  "

}

puts "\n\ "

puts "Active Tools:"

foreach AT $magazine {
    set activeTool [lindex $AT 4];

    if {$activeTool eq "active" } {
        puts "[lindex $AT 0]"
    }
}

puts "\n\ "

puts "Worn out Tools:"

foreach AT $magazine {
    set activeTool [lindex $AT 4];

    if {$activeTool eq "worn" } {
        puts "[lindex $AT 0] has been worned out please change the tool"
    }
}

puts "\n\ "

puts "Largest Dia Tool in the current Magazine "


set currentdia 0
set currentdiaName 0

foreach dia $magazine {

 set data [lindex $dia 1]

    if {$data > $currentdia} {
        set currentdia [lindex $dia 1]
        set currentdiaName [lindex $dia 0]
        
    }
    
}
 puts "$currentdiaName"


 puts "\n\ "

 puts "Active tools in Magazine"

 set count 0

 foreach mag $magazine {
    set actool [lindex $mag 4]
    if {$actool eq "active"} {
        set count [expr $count+1]
    }
 } 
 puts "$count"


 
 puts "\n\ "

 puts "Wear tools in Magazine"

 set counter 0

 foreach maz $magazine {
    set aktivtool [lindex $maz 4]
    if {$aktivtool eq "worn"} {
        set counter [expr $counter+1]
    }
 } 
 puts "$counter"

 puts "\n\ "

puts "Tool Summary:"

#  foreach mazc $magazine {
#     for {set i 0} {$i<=[llength $mazc]-3} {incr i} {
#         puts [join [lindex $mazc $i]]
#     }
    
#  }
#  puts "[join [lindex $magazine 0]]"



# set row {}
# foreach m $magazine {
#   lappend row [list [list [lindex $m 0] [lindex $m 1] [lindex $m 2]]]
# }

# foreach rw $row {
#     puts [join [list [lindex $rw 0] "[lindex $rw 1]mm" [lindex $rw 2]] ":"]
# }


foreach m $magazine {
    set name [lindex $m 0]
    set dia [lindex $m 1]
    set mat [lindex $m 2]

    puts [join [list $name ${dia}mm $mat] ":"]
}