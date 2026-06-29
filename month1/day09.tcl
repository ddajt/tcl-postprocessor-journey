#practice-1

proc validate_move {t x z f} {

    if { $f < 0.01 || $f > 2 } {
        puts "ERROR: Feed out of range - max 2.0 mm/rev"
        return
    }

    if {!($x > -500) || !($x < 500)} {
        puts "ERROR: X out of range - must be between -500 and 500"
        return
    }

    if {!($z > -1000) || !($z < 0)} {
        puts "ERROR: Z out of range - must be between -1000 and 0"
        return
    }

    if {!($t > 0)} {
        puts "ERROR: Invalid tool number"
        return
    }

    puts "G01 X[format %07.3f $x] Z[format %07.3f $z] F[format %05.3f $f]"
}

validate_move 5 100.0 -45.0 0.250
validate_move 5 100.0 -45.0 5.000
validate_move 0 100.0 -45.0 0.250
validate_move 5 100.0 50.0 0.250

puts "\n"

#practice-2

set tit "titanium"
set alu "aluminium"
set minrpm 800
set maxrpm 3000
set tooldia 6
set feed 0.150

proc cutting_condition_advisor {t r mat f} {
    global tit alu minrpm maxrpm tooldia feed

    if {$mat == $tit && $r > $minrpm} {
        puts "WARNING: Reduce speed for $mat"
        return
    }

    if {$mat == $alu && $r < $maxrpm} {
        puts "WARNING: Increase speed for $mat"
        return
    }

    if {$t < $tooldia && $f > $feed} {
        puts "WARNING: Feed too high for small tool"
        return
    }

    puts "Cutting conditions OK"
}

cutting_condition_advisor 7 900 "titanium" 0.140
cutting_condition_advisor 7 2000 "aluminium" 0.140
cutting_condition_advisor 5 700 "titanium" 0.160
cutting_condition_advisor 7 700 "titanium" 0.140

puts "\n"

#practice-3

proc validate_program {Onum Tnum SS F} {
    if {![string match "O*" $Onum]} {
        puts "ERROR: Enter valid program key"
        return
    }

    if {$Tnum <= 0} {
        puts "ERROR: Enter valid tool"
        return
    }

    if {$SS <= 0} {
        puts "ERROR: Cannot initiate the spindle"
        return
    }

    if {$F <= 0} {
        puts "ERROR: Feed cannot be zero"
        return
    }

    puts "%"
    puts "$Onum"
    puts "T[format %02d $Tnum] M06"
    puts "G43 H[format %02d $Tnum]"
    puts "S$SS M03"
    puts "F[format %.3f $F]"
    puts "G21 G40 G49"
    puts "%"
}

validate_program 00099 7 2400 0.5
validate_program O00099 0 2400 0.5
validate_program O00099 7 0 0.5
validate_program O00099 7 2400 0
validate_program O00099 7 2500 0.5