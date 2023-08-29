
parameter ADD = 8'b00000000;
parameter SUB = 8'b00000001;
parameter AND = 8'b00000010;
parameter CMP = 8'b00000011;
parameter XOR = 8'b00000100;
parameter TEST = 8'b00000101;
parameter OR = 8'b00000110;
parameter MVRR = 8'b00000111;
parameter DEC = 8'b00001000;
parameter INC = 8'b00001001;
parameter SHL = 8'b00001010;
parameter SHR = 8'b00001011;
parameter ADC = 8'b00001100;
parameter SBB = 8'b00001101;
parameter JR = 8'b01000000;
parameter JRC = 8'b01000100;
parameter JRNC = 8'b01000101;
parameter JRZ = 8'b01000110;
parameter JRNZ = 8'b01000111;
parameter JRS = 8'b01000001;
parameter JRNS = 8'b01000011;
parameter CLC = 16'b0111100000000000;
parameter STC = 16'b0111101000000000;
parameter JMPA = 16'b1000000000000000;
parameter LDRR = 8'b10000010;
parameter STRR = 8'b10000011;
parameter MVRD = 8'b10000001;
parameter NOP = 8'b11111111;


/*
一、
左移立即数，最后四位为左移次数，4位够0至15
SHL dr "00001010[u4][u4]",dr,data
SHR dr "00001011[u4][u4]",dr,data
1.ALU_IN_SEL2增加110，alu_a为sr，alu_b为立即数
或ALU_IN_SEL2改成000，alu里运算alu_b>>alu_a
2.改规则
【已实现】

二、nop指令
【已实现】

三、
堆栈pop，push，pushad，popad, r15当堆栈指针

push
AR<-SP, SP<-SP+1
MEM<-SR
PUSH sr "10001111[u4]xxxx",sr

pop
AR<-SP, SP<-SP-1
DR<-MEM
POP dr "10011111[u4]xxxx",dr

pushad
AR<-SP, SP<-SP+1
MEM<-cvzs
PUSHD ."10001110xxxxxxxx"

popad
AR<-SP, SP<-SP-1
cvzs<-MEM
POPD ."10011110xxxxxxxx"

六、
加、减、与、或、异或、立即数，16位以内，双字节指令
七、
call，retn
*/