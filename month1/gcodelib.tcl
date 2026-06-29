proc formatCoord {val} {
    return [format %.3f $val]
}

proc gcodeMove {gcode x y z feed} {
    return "$gcode X[formatCoord $x] Y[formatCoord $y] Z[formatCoord $z] F$feed"
}

proc toolChange {tnum} {
    return "$tnum M06"
}