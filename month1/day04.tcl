# practice-1


set Onum 42
set tool 5
set s 1200
set x 100.257
set z -45.250
set f 0.250
set sci 100.3

puts "Program: O[format %05d $Onum]"
puts "Tool: T[format %02d $tool]"
puts "Spindle: S[format %d $s]"
puts  [format "G01 X%.3f Z%08.3f F%.3f" $x $z $f]
puts "Operation: [format %-10s FACE_MILL]"
puts "Scientific: [format %.3e $sci]"

# practice-2

# #  Full Block Output
# Store these as variables and produce this complete turning block using format:
# %O00150
# (TOOL: T0303 - ROUGHING INSERT)
# G97 S850 M03
# G00 X082.000 Z005.000
# G01 X082.000 Z-125.500 F0.350
# M05
# M30

# Rules — every number from a variable. Program number 5 digits. X and Z zero padded to 3 digits before decimal. Tool number 4 digits.
# One format call per line.

puts "\n"
set progNum "150"
set toolNum "303"
set inserName "roughing insert"
set s "850"

puts "%O[format %05d $progNum]"
puts  "([string toupper "tool: T[format %04d $toolNum] - $inserName"]) "
 puts  [format "G97 S%s M%02d" $s 3]
 puts [format "G%02d X%07.3f Z%07.3f" 0 82 5]
 puts [format "G%02d X%07.3f Z-%7.3f F%05.3f" 1 82 125.5 .35]
 puts [format "M%02d" 5]
 puts [format "M%d0" 3]

puts "\n"

# Practice 3 — Tolerance Checker


# Store a measured diameter and a nominal diameter. Calculate the deviation. Format and print:
# Nominal:  080.000 mm
# Measured: 080.047 mm
# Deviation: +0.047 mm
# Tolerance: PASS
# Rules — deviation must show + or - sign. If deviation is within ±0.050 print PASS, otherwise print FAIL. Use %+.3f for the signed deviation.


set n 80
set m 80.047
set d .047

puts "Nominal: [format %07.3f  $n ] mm"
puts "Measured: [format %07.3f $m] mm"
puts "Deviation: [format %+05.3f $d] mm"
puts "Tolerance: [format %s PASS] "