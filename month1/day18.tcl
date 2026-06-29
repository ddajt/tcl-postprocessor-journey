 #practice-1
 
 proc toolReport {arrayName} {
    foreach ar $arrayName {

    
    upvar 1 $ar arr

   puts "Tool: $arr(name)"
   puts "Diameter: $arr(dia)mm"
   puts "Material: $arr(mat)"
   puts "Status: $arr(status)"
   puts "\n\ "
    }
 }  
array set arr {name T01 dia 12.5 mat HSS status active}

array set t01 {name T01 dia 12.5 mat HSS status active}
array set t02 {name T02 dia 8.0 mat Carbide status worn}
array set t03 {name T03 dia 6.0 mat HSS status active}

 toolReport {t01 t02 t03}

puts "\n\ "
 #practice-2

 proc markWorn {arrayName} {
    upvar $arrayName arr
    if {$arr(status) eq "active"} {
        set arr(status) "worn"
        puts "$arr(name) marked as worn"
    } else {
        puts "$arr(name) alredy worn"
    }
 }

 markWorn arr 

 markWorn arr 

 puts "$arr(status)"

 puts "\n\ "

 #practice-3

 proc findLargest {arr} {
  set findLar 0
  set findNam 0
 foreach tool $arr {
    
    upvar 1 $tool ar 

        if {$ar(dia) > $findLar} {
         set findLar $ar(dia)
         set findNam $ar(name)
        }
    


 } 
 return $findNam

 }

 
 set largest [findLargest {t01 t02 t03}]

 puts "Largest tool:$largest"

