// only worry about the general purpose registers at this time
// defining SFRs and FPRs will come after I fully understand what is going on

class I960Reg<bits<5> Enc, string n> : Register<n> {
    let HWEncoding{15-5} = 0;
    let HWEncoding{4-0} = Enc;
    let Namespace = "I960";
}
class I960MultiReg<bits<5> Enc, string n, list<Register> subregs> : RegisterWithSubRegsr<n, subregs> {
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
    def R#I : GPRi<I + 16, "r"#I>;
}
// aliases to double, triple and quad registers
// this is not a real thing! I just am providing them to make life a little
// easier for reasoning purposes
def L0 : I960MultiReg<0, "g0", [G0, G1]>;
def L1 : I960MultiReg<2, "g2", [G3, G3]>;
def L2 : I960MultiReg<4, "g4", [G4, G5]>;
def L3 : I960MultiReg<6, "g6", [G6, G7]>;
def L4 : I960MultiReg<8, "g8", [G8, G9]>;
def L5 : I960MultiReg<10, "g10", [G10, G11]>;
def L6 : I960MultiReg<12 , "g12", [G12, G13]>;
def L7 : I960MultiReg<14 , "g14", [G14, FP]>;
def L8 : I960MultiReg<16 , "pfp", [PFP, SP]>;
def L9 : I960MultiReg<18 , "rip", [RIP, R3]>;
def L10 : I960MultiReg<20 , "r4", [R4, R5]>;
def L11 : I960MultiReg<22, "r6", [R6, R7]>;
def L12 : I960MultiReg<24, "r8", [R8, R9]>;
def L13 : I960MultiReg<26 , "r10", [R10, R11]>;
def L14 : I960MultiReg<28 , "r12", [R12, R13]>;
def L15 : I960MultiReg<30 , "r14", [R14, R15]>;

def T0 : I960MultiReg<0, "g0", [G0, G1, G2]>;
def T1 : I960MultiReg<4, "g4", [G4, G5, G6]>;
def T2 : I960MultiReg<8, "g8", [G8, G9, G10]>;
def T3 : I960MultiReg<12, "g12", [G12, G13, G14]>;
def T4 : I960MultiReg<16, "pfp", [PFP, SP, RIP]>;
def T5 : I960MultiReg<20, "r4", [R4, R5, R6]>;
def T6 : I960MultiReg<24, "r8", [R8, R9, R10]>;
def T7 : I960MultiReg<28, "r12", [R12, R13, R14]>;

def Q0 : I960MultiReg<0, "g0", [G0, G1, G2, G3]>;
def Q1 : I960MultiReg<4, "g4", [G4, G5, G6, G7]>;
def Q2 : I960MultiReg<8, "g8", [G8, G9, G10, G11]>;
def Q3 : I960MultiReg<12, "g12", [G12, G13, G14, FP]>;
def Q4 : I960MultiReg<16, "pfp", [PFP, SP, RIP, R3]>;
def Q5 : I960MultiReg<20, "r4", [R4, R5, R6, R7]>;
def Q6 : I960MultiReg<24, "r8", [R8, R9, R10, R11]>;
def Q7 : I960MultiReg<28, "r12", [R12, R13, R14, R15]>;


def GPR : RegisterClass<"I960", [i32], 32,
(add (sequence "G%u", 0, 13),  // globals
     (sequence "R%u", 3, 15), // locals
     G14, // link register on branch and link, so we should be careful
     FP, // frame pointer / g15
     PFP, // previous frame pointer / r0 [r0 not accepted by assemblers]
     SP, // stack pointer / r1 [r1 not accepted by assemblers]
     RIP, // return instruction pointer / r2 [r2 not accepted by assemblers]
   )>;

def GPROperand : RegisterOperand<GPR>;

// def GPRl : RegisterClass<"I960", [v2i32], 32
/// @todo add support for describing long words via register pairs (has special alignment requirements)
/// @todo add support for describing triple words via registers triples (aligned to four register bounds)
/// @todo add support for describing quad words via registers quads (aligned)
/// @todo add support for describing the four 80-bit floating point registers
/// @todo add support for describing how the general purpose registers can be used in floating point operations of different sizes
/// @todo figure out how to describe the arithmetic controls, trace controls, and process controls

