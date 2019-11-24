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
[FourCC('lold')] = {
    [9] = 1,
},
[FourCC('wol2')] = {
    [77] = 1,
},
[FourCC('mamo')] = {
    [76] = 1,
},
}
return {DROPS = DROPS}