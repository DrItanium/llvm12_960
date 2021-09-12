// only worry about the general purpose registers at this time
// defining SFRs and FPRs will come after I fully understand what is going on

class I960Reg<bits<5> Enc, string n> : Register<n> {
    let HWEncoding{15-5} = 0;
    let HWEncoding{4-0} = Enc;
    let Namespace = "I960";
}

class GPRi<bits<5> Enc, string n> : I960Reg<Enc, n>;
// i960 splits its 32 registers into two parts:
// 16 global registers
// 16 local registers
//
// global registers persist across calls
// local registers are only local to the given call. They are saved and restored into memory when the on chip
// local register frame cache is exhausted. This is done automatically.
foreach I = 0-14 in {
    def G#I : GPRi<I, "g"#I>;
}
// Four (well technically 5) of the registers have special purposes (with the fifth acting as link register so kinda)
// so we have to be very careful how these are used

def FP : GPRi<15, "fp">; // frame pointer
def PFP : GPRi<16, "pfp">; // previous frame pointer
def SP : GPRi<17, "sp">; // stack pointer
def RIP : GPRi<18, "rip">; // return instruction pointer

foreach I = 3-15 in {
    def L#I : GPRi<I + 16, "r"#I>;
}

def GPR : RegisterClass<"I960", [i32], 32,
(add (sequence "G%u", 0, 13),  // globals
     (sequence "L%u", 3, 15), // locals
     G14, // link register on branch and link, so we should be careful
     FP, // frame pointer / g15
     PFP, // previous frame pointer / r0 [r0 not accepted by assemblers]
     SP, // stack pointer / r1 [r1 not accepted by assemblers]
     RIP, // return instruction pointer / r2 [r2 not accepted by assemblers]
   )>;

def GPROperand : RegisterOperand<GPR>;

/// @todo add support for describing long words via register pairs (has special alignment requirements)
/// @todo add support for describing triple words via registers triples (aligned to four register bounds)
/// @todo add support for describing quad words via registers quads (aligned)
/// @todo add support for describing the four 80-bit floating point registers
/// @todo add support for describing how the general purpose registers can be used in floating point operations of different sizes
/// @todo figure out how to describe the arithmetic controls, trace controls, and process controls

