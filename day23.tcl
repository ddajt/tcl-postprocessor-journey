#1

if {[catch {open "tools.txt" r} result]} {

    puts "invalid file"
} else {

while {[gets $result line]>=0} {
    set newLine [string trim $line]
    if {[string length $newLine] == 0} continue
    if {[string match "#*" $newLine]} continue
    puts $newLine
}

}
close $result

puts "\n\ "


   array set tools {}


if {[catch {open "tools.txt" r} result]} {
    puts " invalid thing though"
} else {
    set lines [split [read $result] "\n"]
   close $result
   foreach lin $lines {
 set nwline [string trim $lin]
    if {[string length $nwline] == 0} continue
    if {[string match "#*" $nwline]} continue
     set realData [split $nwline " "]


    lassign $realData name dia mat status

    set tools($name) [dict create name $name dia $dia mat $mat status $status]

    #  puts "$nwline"
   }


puts "[array exists tools]"
if {[array exists tools]} {
    foreach n [lsort [array names tools]] {

       dict for {inkey invlu } $tools($n) {
                 lappend neuvlu $invlu
                
    
       }

    
    }

}
  foreach {1 2 3 4} $neuvlu {
                  puts "$1 | ${2}mm | $3 | $4"
                 }  
}


#3

puts "\n\ "


array set tooldata {}
set wcount 0
set acount 0
set total_lines 0
set comment_lines 0
set data_lines 0
set blank_lines 0


if {[catch {open "tools.txt" r} result]} {
    puts "invalid"
} else {
    while {[gets $result line]>=0} {
         incr total_lines

         set dataline [string trim $line]

         if {[string length $dataline] == 0 } {
            incr blank_lines
            continue
        }


        if {[string match "#*" $dataline]} {
            incr comment_lines
            continue
        }

      incr data_lines

        lassign [split $dataline " "] name dia mat status

        set tooldata($name) [dict create name $name dia $dia mat $mat status $status]


    }
    close $result
        


        foreach arr [array names tooldata] {

            dict for {key val} $tooldata($arr) {
                if {$val eq "worn"} {
                    incr wcount 

                } 

                if {$val eq "active"} {
                    incr acount 

                } 

            }
        }
        
        puts "Total lines: $total_lines"
        puts "Comment lines: $comment_lines"
        puts "Blank lines: $blank_lines"
        puts "Data lines: $data_lines"
        

        puts "Active tools: $acount"

        puts "Worn tools: $wcount"

    
}