# State tracking
proc initState {arrName} {
    upvar $arrName state
    set state(tool) 0
    set state(feed) 0
    set state(speed) 0
}

# Format output
proc fmt {val} {
    return [format %.3f $val]
}

proc safeRetract {tnum} {
    global SAFE_Z
    return "G00 G43 H$tnum Z[fmt $SAFE_Z]"
}

proc toolChange {tnum speed} {
    return "T$tnum M06\nS$speed M03"
}
proc move {x y z feed} {
    return "G01 X[fmt $x] Y[fmt $y] Z[fmt $z] F$feed"
}
proc SafeMove {x y} {
    return "G00 G54 X[fmt $x] Y[fmt $y]"
}
proc Retractmove {} {
    global SAFE_Z
    return "G75 Z[fmt 0]"
}
proc safeZRetract {} {
    global SAFE_Z
    return "G00 Z[fmt $SAFE_Z]"
}


