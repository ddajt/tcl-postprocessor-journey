#practice-1

#Build: Take a raw CNC operation name like "face_mill_roughing" and:
#Convert it to uppercase
#Find how many characters it has
#Extract just the word "mill" from it using string range
#Append a suffix to make it "face_mill_roughing_OP1"

set s1 "face_mill_roughing"
puts [string toupper $s1]
puts [string length $s1]
puts [string range $s1 5 8 ]
append s1 "_OP1"
puts $s1
#Commands that only READ a variable use $. Commands that MODIFY a variable use the name directly without $.

#practice-2

#You have a tool comment coming from a CAM system as:
#"  G01_linear_move  "
#Extra spaces on both sides — messy. Clean it up, extract just the word "linear" from it, and print:
#Cleaned: G01_linear_move
#Operation type: linear
#Total characters: 15

puts "\n\n"
set camOutput " G01_linear_move "

set cam [string trim $camOutput]
puts "Cleaned: $cam"
puts "Operation type: [string range $cam 4 9 ]"
puts "Total characters: [string length $cam]"


#practice-3
#You have a machine mode variable:
#"turning_roughing_pass1"

#Convert it to uppercase
#Replace the word "roughing" with "finishing"
#Print both original and modified:

#Original: turning_roughing_pass1
#Modified: turning_FINISHING_pass1


puts "\n\n"
set machVar "turning_roughing_pass1"
set varU [string toupper $machVar]
set word "FINISHING"
puts "Original: $machVar"
puts "Modified: [string replace $machVar 8 15 $word]"

