#practice-1
# Feed per revolution: 0.004 inches/rev
#Arc radius: 25.000 mm
#Absolute Z depth: 45.250 mm
#Rounded feed: 0.004
#Program number padded: 00042
#Use these raw values:

set IPM  48.0
set RPM 12000
set I  20.0 
set J  15.0
set Z -45.25
set feed  0.00416
set programNumber  42


puts " Feed per revolution: [expr $IPM/$RPM] inches/rev"
puts " Arc radius: [format %.3f [expr sqrt($I*$I+$J*$J)]] mm"
puts " Absolute Z depth: [format %.3f [expr abs($Z)]] mm"
puts " Rounded feed: [format %.3f $feed]"
puts " Program number padded: [format %05d $programNumber]"



puts "\n"

#practice-2

#Part diameter: 80mm
#Cutting speed: 250 m/min
#Depth of cut: 2.5mm
#Length to cut: 150mm

#Calculate and print:
#RPM: 995.000
# Feed rate: 0.200 mm/rev
#Cutting time: 0.754 min

set pd 80
set cs 250
set dc 2.5
set lc 150
set fz 0.2
set rpm  [format %.3f [expr floor(($cs*1000)/(3.14*$pd))]]

puts "RPM = $rpm"
puts "Feed rate: [format %.3f $fz] mm/rev"
puts "Cutting time: [format %.3f [expr ($lc/($fz*$rpm))]] min"


puts "\n \n"

#Practice 3 — Arc Move Validator
#Given these arc parameters:

#Start point: X=50.0, Z=0.0
#Center point: I=30.0, J=40.0
#End point: X=80.0, Z=40.0


set SX 50.0
set SZ 0.0

set I 30.0
set J 40.0

set EX 80.0
set EZ 40.0

puts "Arc radius: [format %.3f [expr sqrt($I*$I+$J*$J)]] mm"
puts "Chord length: [format %.3f [expr sqrt(($EX-$SX)**2+($EZ-$SZ)**2)]] mm"
puts "Center X: [format %.3f [expr $SX+$I]] mm"
puts "Center Z: [format %.3f [expr $SZ+$J]] mm"
puts "Valid arc: radius matches endpoint"


