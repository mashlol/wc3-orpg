local DROPS = {
[FourCC('hmbs')] = {
    [4] = 5,
    [8] = 5,
    [10] = 15,
    [43] = 25,
    none = 155,
},
[FourCC('troc')] = {
    [4] = 5,
    [8] = 5,
    [10] = 15,
    [43] = 25,
    none = 155,
},
[FourCC('trol')] = {
    [3] = 15,
    [11] = 25,
    [26] = 50,
},
}
return {DROPS = DROPS}