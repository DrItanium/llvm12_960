// the design of the i960 actually enforces a calling convention so the lack of the EABI specification isn't that big of
// a deal.

// bits and pieces I have pulled from various locations
// - G14 is used for branch and link operations and is assumed to be zero on return from leaf procedures
// - parameters are passed to procedures through the global registers starting at g0 and going up.
// -- I am making a decision to preserve g14 for branch and link operations only
// Taken from: https://people.cs.clemson.edu/~mark/subroutines/i960.html
// g0-g3  - parameters 0-3 / return words 0-3
// g4-g7  - parameters 4-7 / temporaries
// g8-g12 - preserved across call if not used for parameters
// g13 - structure return pointer
// g14 - argument block pointer / leaf return address (hardware)
// fp (g15) - frame pointer (hardware, aligned on 16-byte boundaries)
// pfp (r0) - previous frame pointer (hardware)
// sp (r1) - stack pointer (hardware)
// rip (r2) - return instruction pointer (hardware)
// r3-r15 - available as locals for subroutine


def CC_I960 : CallingConv<[
CCIfType<[i1, i8, i16], CCPromoteToType<i32>>,
CCIfSRet<CCIfType<[i32], CCAssignToReg<[G13]>>>,
CCIfType<[i32,i64,f32,f64], CCAssignToReg<[G0,G1,G2,G3,G4,G5,G6,G7,G8,G9,G10,G11,G12,G13]>>, // use globals registers for parameter passing
CCAssignToStack<4, 4>>;

// this isn't totally consistent, if G8-G12 are used for parameter passing then no need to preserve
def CSR_I960 : CalleeSavedRegs<(add G8, G9, G10, G11, G12)>;
