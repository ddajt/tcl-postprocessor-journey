
#build day

array set machineData {Machine VMC-850 Operator Ajith SessionStartState idle}

proc startSession {session st state} {
    upvar $session mc

    if { [lsearch $state $mc(SessionStartState)]>=0} {
        set mc(SessionStartState) $st
        return "Session $mc(SessionStartState) | machine $mc(Machine) | operator $mc(Operator)"
    }
}

set ajith [startSession machineData running {idle}]
puts "$ajith"
puts "\n\ "

proc logOperation {arr op feed rpm} {
    upvar $arr mc
    if {$mc(SessionStartState) eq "running"} {
        lappend  mc(log) "$op | F$feed | S$rpm "
        return "OP logged: $op | F$feed | S$rpm"
    } else {
        return "invalid"
    }
}

set ak [logOperation machineData "Face Mill" 300 1200]
puts "$ak"
set ak [logOperation machineData "Drill" 150 800]
puts "$ak"
set ak [logOperation machineData "Contour" 250 1000]
puts "$ak"
puts "[array names machineData]"
puts "\n\ "



proc endSession {arr} {
  upvar $arr mc
  if {$mc(SessionStartState) eq "running"} {
    set mc(SessionStartState) complete
    return $mc(SessionStartState)
    #
  }
}

set aj [endSession machineData]
set indeces 1
if {$aj eq $machineData(SessionStartState)} {
 puts "Session ended: $machineData(Machine)\n\Total operations: [llength $machineData(log)] \n\Operations log:\n\ "
 foreach li $machineData(log) {
    puts "$indeces. $li"
    incr indeces
 }
}

puts "\n\ "
proc getStatus {arr} {
    upvar $arr mc
    if {$mc(SessionStartState) eq "complete"} {
       
        return "$mc(Machine) | $mc(SessionStartState) | Ops:[llength $mc(log)]"
    }
}

set akak [getStatus machineData]

puts "$akak"