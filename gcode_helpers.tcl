proc gFormat {val} {
    return [format %.3f $val]
}

proc gLine {gcode x y z} {
    return "$gcode X[gFormat $x] Y[gFormat $y] Z[gFormat $z]"
}