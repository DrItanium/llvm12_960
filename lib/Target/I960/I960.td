//===----------------------------------------------------------------------===//
//
// This is the top level entry point for the I960 target.
//
//===----------------------------------------------------------------------===//

include "llvm/Target/Target.td"

include "I960RegisterInfo.td"
include "I960CallingConv.td"
include "I960Schedule.td"
include "I960InstrFormats.td"
include "I960InstrInfo.td"

// i960 is split into several architectures which are supersets of the previous one. Order is:
// 1) Core (integer instructions)
// 2) Numerics (Floating Point + Decimal operations) [i960SB, i960KB, i960MC, and i960MX are the only known processors to support this]
// 3) Protected (Memory managmenet, process scheduling) [i960MC and i960MX were the only ones to ever support this]
// 4) Extended (tagged memory + unknown...)... will never be supported due to lack of documentation on the MX processors

// There are also extensions to the core instruction set that were added with the later J series chips. Lack of easily
// testable hardware makes these extended instructions difficult to support.

// the S series processors also have their own "synmov" instructions which seem to be the precursor to the later
// syscall instruction introduced in the J series.

// Original core architecture only (i960SA minus the synmovldx operations)
def : ProcessorModel<"generic", I960SchedModel, []>;
// Core + Sx specific synchronized move instructions for IACs
// def : ProcessorModel<"i960SA", I960SchedModel, []>;
// the SB processor supports the Numerics architecture (FPU + Decimal operations) + Core architecture
// def : ProcessorModel<"i960SB", I960SchedModel, []>;
// @todo add the other machine definitions

