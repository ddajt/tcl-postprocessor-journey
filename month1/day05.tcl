set S 201
set lw "Spindle too slow - minimum 200 RPM"
set hw "Spindle too fast - maximum 4000 RPM"
set mw "S$S"

if {$S < 200} {
    puts "[string toupper "Warning:"] $lw"
    #puts "hi"
} elseif {$S>4000} {
    puts "[string toupper "Warning:"] $hw"
} else {
    puts "$mw [format   M%02d 3]"
}
puts "\n"
#Practice 2 — Coolant Controller
# Store a material type as a string — "steel", "aluminum", or "titanium". Print the correct coolant code:
# steel → M08 (flood coolant)
# aluminum → M07 (mist coolant)
# titanium → M08 M07 (both)
# anything else → M09 (coolant off)

set material "titanium"

if {$material == "steel"} {
    puts "[format M%02d 8]"
} elseif {$material == "aluminum"} {
    puts "[format M%02d 7]"
} elseif {$material == "titanium"} {
    puts [format "M%02d M%02d" 8 7]
} else {
    puts "[format M%02d 9]"
}


puts "\n"

#Practice 3 — Tolerance Checker (Day 4 revisit)


# Store a measured diameter and a nominal diameter. Calculate the deviation. Format and print:
# Nominal:  080.000 mm
# Measured: 080.047 mm
# Deviation: +0.047 mm
# Tolerance: PASS
# Rules — deviation must show + or - sign. If deviation is within ±0.050 print PASS, otherwise print FAIL.


set nom 80
set m 80.047
set d .047

puts "Nominal: [format %07.3f $nom] mm"
puts "Measured: [format %07.3f $m] mm"
puts "Deviation: [format %+05.3f $d] mm"
if {$d<=0.05 && $d>=-0.05} {
    puts "[format %s Tolerance] : [string toupper pass]"
} else { 
    puts "[format %s Tolerance] : [string toupper fail]"
}

