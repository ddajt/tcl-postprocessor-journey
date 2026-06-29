proc fmt {val} {
    return [format %.3f $val]
}

proc toolChange {tnum} {
    return "T$tnum M06"
}

proc rapidMove {x y z} {
    return "G00 X[fmt $x] Y[fmt $y] Z[fmt $z]"
}

proc linearMove {x y z feed} {
    return "G01 X[fmt $x] Y[fmt $y] Z[fmt $z] F$feed"
}