#practise-1
set i 0
puts "--- Depth Passes ---"
for {set j 1} {$j<=5} {incr j} {
    
       puts "Pass $j: Z=[format %.3f $i]" 
    #
   set i [expr $i-2.5]
}

#practise-2

puts "\n"

puts "--- Tool List ---"

set toolPoc {T01 T02 T03 T04}
set tools {face_mill slot_mill drill boring_bar}
set k 1
foreach tool $tools poc $toolPoc {
    
        puts "$poc - [string toupper $tool]"
    
}
puts "\n"

puts "--- paired method for the same forEach"

set toolsPaired {T01 face_mill T02 slot_mill T03 drill T04 boring_bar}

foreach { poc tool } $toolsPaired {
  puts " $poc - $tool "
}

puts "\n"
#practice-3
puts "---Feed Ramp---"
set k 0.050
while {$k<=0.25} {
    puts " F[format %01.3f $k] "
    set k [expr $k+0.050]
}