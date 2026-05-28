#practice-1

array set G54 {X 100.0 Y 50.0 Z -44.0}
array set G55 {X 200.0 Y 75.0 Z -20.0}



foreach firsthand [array names G54] {

    puts "$firsthand = [format %.3f $G54($firsthand)]"
    
}
puts "\n\ "

foreach {l1 l2} [array get G55] {
    puts "$l1 = [format %.3f $l2]"
}
puts "\n\ "


if {[info exists G54(X)]} {
        set G54(X) "[format %.3f [expr $G54(X)+15.5]]"
        puts "X = $G54(X)"
    }

puts "\n\ "

unset G54(Z)



if {[info exists G54(Z)]} {
    puts "Z $G54(Z)"
} else {
    puts "Z Not set"
}

puts "\n\ "
#practice-2

puts "Rough passes:"
puts "\n\ "
array set setups {X_rough 2.5 Y_rough 1.8 Z_rough 3.0 X_finish 0.1 Y_finish 0.1 Z_finish 0.05}

foreach key [array names setups *_rough] {
    puts "$key = [format %.3f $setups($key)]"
}

puts "\n\ "

puts "Finish passes:"

puts "\n\ "
foreach key [array names setups *_finish] {
    puts "$key = [format %.3f $setups($key)]"
}

puts "\n\ "

puts "finding the largest rough value"

set count 0
set name 0

foreach lar [array names setups *_rough] {
    if {$count<$setups($lar)} {
       set count $setups($lar)
       set name $lar
    }
    
}
puts "Largest rough cut: $name = [format %.3f $count]"


#practice-3

puts "\n\ "

foreach g1 [array names G55] {

    if {[info exists G54($g1)]} {
        puts "$g1 differrence: [format %.3f [expr $G55($g1)-$G54($g1)]]"
    
    } else {
        puts "G54 has no $g1"
    }

}