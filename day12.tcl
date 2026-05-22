puts [lsort -real {6.0 12.5 4.5 8.0}]

puts [lsort -integer {6 12 4 8}]


#practice-1
set tools {T04 T02 T01 T03}
set diameter {4.5 8.0 12.5 6.0}

puts [lsort  $tools]
puts [lsort -real $diameter]
# no, T01 dose not matching up with 12.5.

set decendingDia [lsort -real -decreasing $diameter]
puts "$decendingDia"

puts "\n\ "
#practice -2

set magazine {T01 T02 T03 T04 T05}

 set vari [linsert $magazine 2 T02-B]
puts "vari $vari"

set vae [lreplace $vari 5 5 T06]
puts "vae $vae"

set vare [lreplace $vae 3 3]

 puts [lset vare 0  T01-HSS]

 puts $vare

 puts "\n\ "

 #practice-3

 set fields {G01 X100.0 Y50.0 Z-5.0 F300}

 set joined [join $fields " "]
 puts $joined
 puts $fields
 set filler [split $fields " "]
 set backer [lassign $fields a]
 puts $a
 puts [linsert $fields 1 M08]

 puts [join [linsert $fields 1 M08] " "]