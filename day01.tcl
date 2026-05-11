
set X "100.000"
set Z "-45.250"
set offset "5.250"
set newX [format "%.3f" [expr $X+$offset]]

puts "Tool moves to X=$X Z=$Z
After offset, new X=$newX"

#note:
# %.3f breaks into 3 parts:
# % — "a value is coming here"
# .3 — "show exactly 3 digits AFTER the decimal point"
# f — "the value is a floating point number" (a number with decimals)

# practice -2

set spindleSpeed "S=1200 RPM"
set feedRate "0.25"

puts "Spindle speed: $spindleSpeed "
puts "Feed rate: F=[format %.3f $feedRate] mm/rev"

#Double quotes inside double quotes = Tcl gets confused. When you're already inside " ", don't open another " " inside [ ].
#Quotes = Tcl processes what's inside. Curly braces = Tcl leaves it completely alone.


#prctice - 3

set zIni "0"
set ztar "-12.5"

puts "Tool T05 cutting from Z=[format %.3f $zIni] to Z=[format %.3f $ztar]"
