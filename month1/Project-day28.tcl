#project day
source "pp_core.tcl"

if {[catch {source "pp_config.tcl"} result]} {
    error "not good"
    # error "again the same"
} else {
    
    if {[catch {open "tool_data.csv" r} data]} {
        puts $data
    } else {
        set readData [split [read $data] "\n"]
        close $data
        foreach line $readData {
          set newData [string trim $line]
          if {[string length $newData] <= 0} continue

          if {[regexp {^#[""]} $newData]} continue
          if {![regexp {^T[0]} $newData]} continue
       set toolNUm ""
       set speed ""
       set feed ""
       regexp {T([0-9]+)} $newData mat toolNUm
       regexp "${toolNUm}\\,(\[0-9\]+)" $newData mat speed
       regexp "${speed}\\,(\[0-9\]+)" $newData mat feed
       set tool($toolNUm,speed) $speed
       set tool($toolNUm,feed) $feed

    #    puts "[array exists tool]"
    #    puts "[info exists tool($toolNUm,speed)]"
    #    puts "[info exists tool($toolNUm,feed)]"
       

        }
        
    }



# opening moves_data

if {[catch {open "moves_data.csv" r} data]} {
    error $data
} else {
    set readData [split [read $data] "\n"]
    set coordinates {}
    close $data
    foreach line $readData {
        set newData [string trim $line]
        if {[string length $newData] == 0} continue
        if {[regexp {^#[""]} $newData]} continue
         if {![regexp {^(-?[0-9.])+} $newData]} continue
        # puts $newData
        lappend coordinates $newData

    }
    # puts $coordinates

}

set programName [open "PROGRAM_NAME.nc" w]

if {[file exists "PROGRAM_NAME.nc"]} {

    initState state ;

    puts $programName $PROGRAM_NUMBER\($MACHINE\)
    puts $programName "(Program generated for: Siemens 810D)"
    foreach li $coordinates  {arr arr2} [lsort [array names tool]] {
        # set datas [split $li ","]
        lassign [split $li ","] a b c d f

        set x $a
        set y $b
        set z $c
        set Feed $d

         set tnum [string range $arr 0 2]; 
 
 
    if {$state(tool) ne $tnum} {

         if {$arr2 == "${tnum}speed"} {

        set speed $tool($arr2);
        puts $programName [toolChange [string range $tnum 0 1] $speed]
        set state(tool) $tnum 
        set state(speed) $speed
        set state(feed) $Feed  
        puts $programName [safeRetract [string range $tnum 0 1]]
        puts $programName [SafeMove $x $y]
        puts $programName "Z$ini_safe"
        puts $programName [move $x $y $z $Feed]
        puts $programName [safeZRetract]
        puts $programName [Retractmove]
        }
       
        ;
    }

        # puts $a
        # puts $b
        # puts $c
        # puts $d
        # puts $f

       
        #  puts $x
        #  puts "$y"
       
# puts "$arr2 == ${tnum}speed"

       

        # puts "[toolChange [string range $tnum 0 1] $speed]"
        # puts "[safeRetract [string range $tnum 0 1]]" 
        # puts "[SafeMove $x $y]"
        # puts "Z$ini_safe"
        # puts "[move $x $y $z $DEFAULT_FEED]"
        # puts "[safeZRetract]" 
        # puts "[Retractmove]"
       
        

        # regexp {T[0-9]} $li m tnum
        # regexp "$tnum\\,(-?\[0-9.\]+)" $li m2 speed
        # puts "$speed"
        
        #  puts $tnum
        #   puts $arr
        #   puts "${tnum}speed"
     
    }
    puts $programName "M05"
    puts $programName "M30"

}
 close $programName

 if {[catch {open "PROGRAM_NAME.nc" r} data]} {
    puts $data
 } else {
    while {[gets $data line] >=0} {
        set newline [string trim $line]
        if {$newline eq ""} continue
        if {[string match "#*" $newline]} continue
        puts "$newline"
        
    }
 }
 close $data
}