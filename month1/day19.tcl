set state(current) idle
set state(previous) running
set state(cycles) 0
set state(error) "invalid transition"


proc dazzle {daz attempted} {
    global state
if {$daz} {
 puts "OK: $state(previous) -> $state(current) \[cycles: $state(cycles)\]"
} else {
    puts "FAIL: $state(current) -> $attempted | $state(error)"
}
}

proc changeState {arrayName newstate allowed} {
     upvar $arrayName state
    if {[lsearch $allowed $state(current)]>=0} {
        set state(previous) $state(current)
        set state(current) $newstate
        incr state(cycles)
        return 1
    } else {

        set state(error) "invalid transition from $state(current) to $newstate"
        return 0
    }
}

# set allowedState {idle running paused complete}
set newstate [changeState state running {idle}] 
dazzle $newstate running
set newstate2 [changeState state paused {running}] 
dazzle $newstate2 paused
set newstate3 [changeState state complete {paused}] 
dazzle $newstate3 complete
set newstate4 [changeState state running {idle}] 
dazzle $newstate4 running
set newstate4 [changeState state running {idle complete}] 
dazzle $newstate4 running

puts "\n\ "
#practice-2

array set mode {coolant off spindle off feed 0 mode G90}

proc setModal {arrname key value} {
    upvar mode modee
  if {$modee($key) eq $value} {
      return "$key unchanged"

  } else {
    set var $modee($key)
    set modee($key) $value
    return "$key changed: $var -> $modee($key)"
 
  }
}


set test1 [setModal mode coolant on]
puts "$test1"

set test1 [setModal mode spindle 1000]
puts "$test1"


set test1 [setModal mode coolant on]
puts "$test1"


set test1 [setModal mode mode G91]
puts "$test1"


puts "\n\ "

set cycle 0

proc runCycle {name modelname} {
    global mode
    global state
    global cycle

    if {$state($name) eq "running"} {
       set mode($modelname) [expr $mode($modelname) + 50]
       incr cycle
       return "Cycle $cycle | machine: $state($name) | feed: $mode($modelname)"

    } else {
       return "invalid option"
    }
}

set cycle2 [runCycle current feed]
puts "$cycle2"
set cycle2 [runCycle current feed]
puts "$cycle2"
set cycle2 [runCycle current feed]
puts "$cycle2"