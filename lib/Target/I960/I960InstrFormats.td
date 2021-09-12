// i960 instructions come in two different sizes: 4 bytes and 8 bytes with the majority of them being 4 bytes

class InstI960<dag outs, dag ins, string asmstr, list<dag> pattern, InstrItInClass itin = NoItinerary> : Instruction  {
    let Namespace = "I960";
    dag OutOperandList = outs;
    dag InOperandList = ins;
    let AsmStriong = asmstr;
    let Pattern = pattern;
    let DecoderNamespace = "I960";
    let Itinerary = itin;
}

class InstI960_1Word<dag outs, dag ins, string asmstr, list<dag> pattern, InstrItInClass itin = NoItinerary> : InstI960<outs, ins, asmstr, pattern, itin> {
    field bits<32> Inst;
    field bits<32> SoftFail = 0;
    let Size = 4;
}
class InstI960_2Word<dag outs, dag ins, string asmstr, list<dag> pattern, InstrItInClass itin = NoItinerary> : InstI960<outs, ins, asmstr, pattern, itin> {
    field bits<64> Inst;
    field bits<64> SoftFail = 0;
    let Size = 8;
}

class RegFormat<bits<12> opcode,
dag outs, dag ins, string asmstr, list<dag> pattern, InstrItInClass itin = NoItinerary> : InstI960_1Word<outs, ins, asmstr, pattern, itin> {
    bits<5> srcDest;
    bits<5> src2;
    bits<5> src1;
    bits<1> m1;
    bits<1> m2;
    bits<1> m3;
    bits<1> s1;
    bits<1> s2;

    let Inst{31-24} = opcode{11-4};
    let Inst{23-19} = srcDest;
    let Inst{18-14} = src2;
    let Inst{13} = m3;
    let Inst{12} = m2;
    let Inst{11} = m1;
    let Inst{10-7} = opcode{3-0};
    let Inst{6} = s2;
    let Inst{5} = s1;
    let Inst{4-0} = src1;
}
