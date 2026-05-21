#arrays

#- Demonstrated sync failure risk of parallel lists

# set tool {T01 T02 T02-B T03}
# set data {12.5 8 6}

# foreach t $tool d $data {
#     puts "$t=[format %4.1f $d],"
# }


puts "\n"

#practice-1


set offset(X) 100
set offset(Y) 150
set offset(Z) -44

foreach T [array names offset] {
    puts "$T offset: [format %7.3f $offset($T)]"
}

#practice-2

puts "\n\ "

array set tool {T01 5.0 T02 5.5 T03 4.6}

set tool(T04) 4.5
set tool(T02) 9.5
puts [array size tool]
unset tool(T03)


foreach T [array names tool] {
     puts "$T: $tool($T)"
}
puts [array size tool]



puts "\n\ "

array set tool2 {T01 12.5 T02 8 T02-B 8.2 T03 6}

foreach T2 [array names tool2] {
    puts "$T2=[format %4.1f $tool2($T2)]"
}
