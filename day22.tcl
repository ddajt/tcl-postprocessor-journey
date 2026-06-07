# 1
proc safemath {op a b} {
    if {[lsearch {add sub mul div} $op] ==-1} {
        error "unknown operation $op"
    } 
    
    if { $op eq "add" } {
        return "[expr $a + $b]"
    } elseif { $op eq "sub" } {
        return "[expr $a - $b]"
    } elseif { $op eq "mul" } {
        return "[expr $a * $b]"
    } elseif { $op eq "div" } {
        return "[expr $a / $b]"
    }
}

if {[catch {safemath "div" 10 2} result]} {
    puts "Error:$result"
} else {
  puts "result:$result"
}


if {[catch {safemath "div" 10 0} result]} {
    puts "Error:$result"
} else {
  puts "result:$result"
}


if {[catch {safemath "add" 10 5} result]} {
    puts "Error:$result"
} else {
  puts "result:$result"
}


if {[catch {safemath "mod" 10 3} result]} {
    puts "Error:$result"
} else {
  puts "result:$result"
}


#2
puts "\n\ "

array set t01 {name T01 dia 12.5 status active}

proc safeGet {arrName key} {

upvar $arrName arr

if {![info exists arr($key)]} {
    error "key $key is not found"
}
return $arr($key)
}

if {[catch {safeGet t01 name} result]} {
    puts "$result"
} else {
    puts "$result"
}


if {[catch {safeGet t01 dia} result]} {
    puts "$result"
} else {
    puts "$result"
}


if {[catch {safeGet t01 rpm} result]} {
    puts "$result"
} else {
    puts "$result"
}


#3

puts "\n\ "

proc validateLine {line} {
    if {[string length $line] == 0} {
       error "empty line"
    } elseif {![string match "G*" $line] && ![string match "M*" $line]} {
            error "invalid gcode: $line"
    } elseif {![string match "*X*" $line] && ![string match "*Y*" $line] && ![string match "*Z*" $line]} {
        error "NO axis data: $line"
    }
    return "OK: $line"
}

if {[catch {validateLine "G01 X100 Y50"} result]} {
    puts "ERROR: $result"
} else {
    puts "$result"
}


if {[catch {validateLine ""} result]} {
    puts "ERROR: $result"
} else {
    puts "$result"
}


if {[catch {validateLine "T01 X100"} result]} {
    puts "ERROR: $result"
} else {
    puts "$result"
}


if {[catch {validateLine "G01 F300"} result]} {
    puts "ERROR: $result"
} else {
    puts "$result"
}