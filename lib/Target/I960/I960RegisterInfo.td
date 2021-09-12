// only worry about the general purpose registers at this time
// defining SFRs and FPRs will come after I fully understand what is going on

class I960Reg<bits<5> Enc, string n> : Register<n> {
    let HWEncoding{15-5} = 0;
    let HWEncoding{4-0} = Enc;
    let Namespace = "I960";
}

class GPRi<bits<5> Enc, string n> : I960Reg<Enc, n>;

foreach I = 0-14 in {
    def G#I : GPRi<I, "g"#I>;
}
// Four (well technically 5) of the registers have special purposes (with the fifth acting as link register so kinda)
// They will just be part of a different register group
def FP : GPRi<15, "fp">;
def PFP : GPRi<16, "pfp">;
def SP : GPRi<17, "sp">;
def RIP : GPRi<18, "rip">;

foreach I = 3-15 in {
    def R#I : GPRi<I + 16, "r"#I>;
}

/// @todo get more information on register groups