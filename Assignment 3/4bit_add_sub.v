//4-bit Adder/Subtractor 

// module for adder_subtracter
module adder_subtractor (result,carry,overflow,a,b,control);
output [3:0] result;
output carry;
output overflow;
input [3:0] a;
input [3:0] b;
input control;
wire [2:0] c;
wire [3:0] b_;
ones_compliment OC1(.b_(b_),.b(b),.control(control));

// 4 instances of individual full adder blocks
FA FA0 (.s(result[0]),.co(c[0]),.a(a[0]),.b_(b_[0]),.ci(control));
FA FA1 (.s(result[1]),.co(c[1]),.a(a[1]),.b_(b_[1]),.ci(c[0]));
FA FA2 (.s(result[2]),.co(c[2]),.a(a[2]),.b_(b_[2]),.ci(c[1]));
FA FA3 (.s(result[3]),.co(carry),.a(a[3]),.b_(b_[3]),.ci(c[2]));

//Checking for overflow
xor(overflow,carry,c[2]);

endmodule

// module declaration for taking one's compliment in case of subtraction
module ones_compliment (b_,b,control);
output [3:0] b_;
input [3:0] b;
input control;
xor (b_[0],b[0],control);
xor (b_[1],b[1],control);
xor (b_[2],b[2],control);
xor (b_[3],b[3],control);
endmodule

// module declaration for FA
module FA (s,co,a,b_,ci);
output s,co;
input a,b_,ci;
wire ps,pc0,pc1;

//2 instances of individual half adders
HA HA0 (.ip1(a),.ip2(b_),.hs(ps),.hc(pc0));
HA HA1 (.ip1(ps),.ip2(ci),.hs(s),.hc(pc1));
or (co,pc0,pc1);
endmodule

// module declaration for HA
module HA (ip1,ip2,hs,hc);
output hs,hc;
input ip1,ip2;
xor (hs,ip1,ip2);
and (hc,ip1,ip2);
endmodule

// Test bench for Full Adder
module testbench;
wire [3:0] result;
wire carry;
wire overflow;
reg control;
reg [3:0] a;
reg [3:0] b;

adder_subtractor r1 (.result(result),.carry(carry),.overflow(overflow),.a(a),.b(b),.control(control));

initial begin

$dumpfile("testbench.vcd");
 $dumpvars(0,testbench);

a= 4'b0; b= 4'b0; control=1'b1;
#5 //Delay of 5 clock cycles.
a= 4'b0011; b= 4'b0010; control=1'b1;
#5
a= 4'b0101; b= 4'b1010; control=1'b1; 
#5
a= 4'b1111; b= 4'b0011; control=1'b0;

end

initial $monitor (" Control bit : %b",control, " A = %b",a, " B = %b",b, " Result = %b",result, " Carry = %d",carry, " Overflow bit = %d",overflow);

endmodule
