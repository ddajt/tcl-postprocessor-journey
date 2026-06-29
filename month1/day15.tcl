#practice-1


array set T01 {name t01 dia 12.5 mat Carbide flute 4 status active }


#puts [info exists T01(mat)]
  unset T01(mat) 
foreach key [lsort [concat [array names T01] mat]] {
    if {[info exists T01($key)]} {
        #puts "exist"
        
         puts "$key: $T01($key)"  
        
        

    } else {
     puts "$key:NOT SET"
    }
}

puts "\n\ "
#practice -2

array set T02 [array get T01]

set T02(name) t02
set T02(dia) 8.0
set T02(status) worn
puts "T01|T02"
foreach v1 [lsort [array names T01]] v2 [lsort [array names T02]] {
    puts "$v1:[lsort $T01($v1)] | $v2:[lsort $T02($v2)]"
}


#practice -3


array set t01 {name t01 dia 12.5 mat Carbide flute 4 status active}
array set t02 {name t02 dia 8 mat Carbide flute 3 status worn}
array set t03 {name t03 dia 12 mat Carbide flute 4 status worn}

foreach arr {t01 t02 t03} {
    set sort [set ${arr}(status)] 
        if {$sort eq "worn"} {
            puts "warning [set ${arr}(name)] is worn out!"
        }
    foreach key [lsort [array names $arr]] {
        
        puts "$key:[set ${arr}($key)]"

        
    }



} 

