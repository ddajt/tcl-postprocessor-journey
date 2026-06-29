
#practice -1 
array set magazine {
t01 {name T01 dia 12.5 mat HSS status active}
t02 {name T02 dia 8.0 mat Carbide status worn}
t03 {name T03 dia 6.0 mat HSS status active}
}

foreach {key arr} [array get magazine] {
     set toolDict [dict create {*}$arr]

    set tool [dict get $toolDict name]
    set dia [dict get $toolDict dia]
    set mat [dict get $toolDict mat]
    set status [dict get $toolDict status]

if { $status eq "worn" } {
puts "$tool | $dia mm | $mat | [string toupper $status] - REPLACE"
} else {
    puts "$tool | $dia mm | $mat | $status "
}

    
    
}

puts "\n\ "

# practice-2
set worn {}
set active {}

foreach {key arr} [array get magazine] {
     set toolDict [dict create {*}$arr]

    set tool [dict get $toolDict name]
    set status [dict get $toolDict status]

if { $status eq "worn" } {
lappend worn $tool 
} else {
    lappend active $tool
}
}


puts "Active tools: [join $active " "]"

puts "\n\ "

puts "Worn tools: [join $worn " "]"

puts "\n\ "
#practice-3


 foreach arr [lsort [array names magazine]] {
    set toolDict $magazine($arr)

     
     
     if {[dict get $toolDict status] eq "worn" } {
         dict set toolDict action "order now"
         dict set toolDict status "replace"
         set magazine($arr) $toolDict
     }
    
 }
 
foreach tool [lsort [array names magazine]] {
    puts "$tool:"


set sortedKeys [lsort [dict keys $magazine($tool)]]

    foreach key $sortedKeys {
        set val [dict get $magazine($tool) $key]
        puts " $key:$val"
    }
}