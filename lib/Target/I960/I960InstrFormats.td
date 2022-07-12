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

class COBRFormat<bits<8> opcode,
dag outs, dag ins, string asmstr, list<dag> pattern, InstrItInClass itin = NoItinerary> : InstI960_1Word<outs, ins, asmstr, pattern, itin> {
    bits<13> displacement;
    bits<1> m1;
    bits<5> src2;
    bits<5> src1;
    let Inst{31-24} = opcode;
    let Inst{23-19} = src1;
    let Inst{18-14} = src2;
    let Inst{13} = m1;
    // note that the bottom two bits of the displacement are always zero!
    let Inst{12-2} = displacement{12-2};
    let Inst{1-0} = 0b00;
}

class CTRLFormat<bits<8> opcode,
dag outs, dag ins, string asmstr, list<dag> pattern, InstrItInClass itin = NoItinerary> : InstI960_1Word<outs, ins, asmstr, pattern, itin> {
    // note that the bottom two bits of the displacement are always zero!
    bits<24> displacement;
    let Inst{31-24} = opcode;
    let Inst{23-2} = displacement{23-2};
    let Inst{1-0} = 0b00;
}

class MEMAFormat_RegisterIndirectWithOffset<bits<8> opcode,
      dag outs, dag ins, string asmstr, list<dag> pattern, InstrItInClass itin = NoItinerary> :
      InstI960_1Word<outs, ins, asmstr, pattern, init> 
{
  bits<12> offset;
  bits<5> abase;
  bits<5> srcDest;

  let Inst{31-24} = opcode;
  let Inst{23-19} = srcDest;
  let Inst{18-14} = abase;
  let Inst{13-12} = 0b10;
  let Inst{11-0} = offset;
}

class MEMAFormat_AbsoluteOffset<bits<8> opcode,
      dag outs, dag ins, string asmstr, list<dag> pattern, InstrItInClass itin = NoItinerary> :
      InstI960_1Word<outs, ins, asmstr, pattern, init> 
{
  bits<12> offset;
  bits<5> srcDest;

  let Inst{31-24} = opcode;
  let Inst{23-19} = srcDest;
  let Inst{18-14} = 0;
  let Inst{13-12} = 0b00;
  let Inst{11-0} = offset;
}

class MEMBFormat_RegisterIndirect<bits<8> opcode,
      dag outs, dag ins, string asmstr, list<dag> pattern, InstrItInClass itin = NoItinerary> :
      InstI960_1Word<outs, ins, asmstr, pattern, init> 
{
  bits<5> abase;
  bits<5> srcDest;

  let Inst{31-24} = opcode;
  let Inst{23-19} = srcDest;
  let Inst{18-14} = abase;
  let Inst{13-10} = 0b0100;
  let Inst{9-0} = 0;
}

class MEMBFormat_RegisterIndirectWithIndex<bits<8> opcode,
      dag outs, dag ins, string asmstr, list<dag> pattern, InstrItInClass itin = NoItinerary> :
      InstI960_1Word<outs, ins, asmstr, pattern, init> 
{
  bits<5> index;
  bits<5> scale;
  bits<5> abase;
  bits<5> srcDest;

  let Inst{31-24} = opcode;
  let Inst{23-19} = srcDest;
  let Inst{18-14} = abase;
  let Inst{13-10} = 0b0111;
  let Inst{9-7} = scale;
  let Inst{6-5} = 0b00;
  let Inst{4-0} = index;
}

class MEMBFormat_IPWithDisplacement<bits<8> opcode,
      dag outs, dag ins, string asmstr, list<dag> pattern, InstrItInClass itin = NoItinerary> :
      InstI960_2Word<outs, ins, asmstr, pattern, init> 
{
  bits<5> srcDest;
  bits<32> displacement;
  let Inst{63-32} = displacement;
  let Inst{31-24} = opcode;
  let Inst{23-19} = srcDest;
  let Inst{18-14} = 0;
  let Inst{13-10} = 0b0111;
  let Inst{9-0} = 0;
}

class MEMBFormat_AbsoluteDisplacement<bits<8> opcode,
      dag outs, dag ins, string asmstr, list<dag> pattern, InstrItInClass itin = NoItinerary> :
      InstI960_2Word<outs, ins, asmstr, pattern, init> 
{
  bits<5> srcDest;
  bits<32> displacement;
  let Inst{63-32} = displacement;
  let Inst{31-24} = opcode;
  let Inst{23-19} = srcDest;
  let Inst{18-14} = 0;
  let Inst{13-10} = 0b1100;
  let Inst{9-0} = 0;
}

class MEMBFormat_RegisterIndirectWithDisplacement<bits<8> opcode,
      dag outs, dag ins, string asmstr, list<dag> pattern, InstrItInClass itin = NoItinerary> :
      InstI960_2Word<outs, ins, asmstr, pattern, init> 
{
  bits<5> srcDest;
  bits<5> abase;
  bits<32> displacement;
  let Inst{63-32} = displacement;
  let Inst{31-24} = opcode;
  let Inst{23-19} = srcDest;
  let Inst{18-14} = abase;
  let Inst{13-10} = 0b1101;
  let Inst{9-0} = 0;
}

class MEMBFormat_IndexWithDisplacement<bits<8> opcode,
      dag outs, dag ins, string asmstr, list<dag> pattern, InstrItInClass itin = NoItinerary> :
      InstI960_2Word<outs, ins, asmstr, pattern, init> 
{
  bits<5> srcDest;
  bits<3> scale;
  bits<5> index;
  bits<32> displacement;
  let Inst{63-32} = displacement;
  let Inst{31-24} = opcode;
  let Inst{23-19} = srcDest;
  let Inst{18-14} = 0;
  let Inst{13-10} = 0b1110;
  let Inst{9-7} = scale;
  let Inst{6-5} = 0b00;
  let Inst{4-0} = index;
}

class MEMBFormat_RegisterIndirectwithIndexAndDisplacement<bits<8> opcode,
      dag outs, dag ins, string asmstr, list<dag> pattern, InstrItInClass itin = NoItinerary> :
      InstI960_2Word<outs, ins, asmstr, pattern, init> 
{
  bits<5> srcDest;
  bits<5> abase;
  bits<3> scale;
  bits<5> index;
  bits<32> displacement;
  let Inst{63-32} = displacement;
  let Inst{31-24} = opcode;
  let Inst{23-19} = srcDest;
  let Inst{18-14} = abase;
  let Inst{13-10} = 0b1111;
  let Inst{9-7} = scale;
  let Inst{6-5} = 0b00;
  let Inst{4-0} = index;
}
