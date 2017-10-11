//8-bit Ripple Carry Adder for CO Demo
module ripple_carry_adder (sum,carry,a,b,cin);
output [7:0] sum;
output carry;
input [7:0] a;
input [7:0] b;
input cin;
wire [6:0] c;
// 8 instances of individual full adder blocks
FA FA0 (.s(sum[0]),.co(c[0]),.a(a[0]),.b(b[0]),.ci(cin));
FA FA1 (.s(sum[1]),.co(c[1]),.a(a[1]),.b(b[1]),.ci(c[0]));
FA FA2 (.s(sum[2]),.co(c[2]),.a(a[2]),.b(b[2]),.ci(c[1]));
FA FA3 (.s(sum[3]),.co(c[3]),.a(a[3]),.b(b[3]),.ci(c[2]));
FA FA4 (.s(sum[4]),.co(c[4]),.a(a[4]),.b(b[4]),.ci(c[3]));
FA FA5 (.s(sum[5]),.co(c[5]),.a(a[5]),.b(b[5]),.ci(c[4]));
FA FA6 (.s(sum[6]),.co(c[6]),.a(a[6]),.b(b[6]),.ci(c[5]));
FA FA7 (.s(sum[7]),.co(carry),.a(a[7]),.b(b[7]),.ci(c[6]));
endmodule
// module declaration for FA.
module FA (s,co,a,b,ci);
output s,co;
input a,b,ci;
wire ps,pc0,pc1;
//2 instances of individual half adders
HA HA0 (.ip1(a),.ip2(b),.hs(ps),.hc(pc0));
HA HA1 (.ip1(ps),.ip2(ci),.hs(s),.hc(pc1));
or (co,pc0,pc1);
endmodule
module HA (ip1,ip2,hs,hc);
output hs,hc;
input ip1,ip2;
xor (hs,ip1,ip2);
and (hc,ip1,ip2);
endmodule
// Test bench for Full Adder
module testbench;
wire [7:0] sum;
wire carry;
reg cin;
reg [7:0] a;
reg [7:0] b;
ripple_carry_adder r1 (.sum(sum),.carry(carry),.a(a),.b(b),.cin(cin));
initial begin
$dumpfile("testbench.vcd");
 $dumpvars(0,testbench);
a= 8'b0; b= 8'b0; cin=1'b1;
#5 //Delay of 5 clock cycles.
a= 8'b00001111; b= 8'b00000010; cin=1'b1;
#5
a= 8'b01010101; b= 8'b10101010; cin=1'b0; 
#5
a= 8'b11111111; b= 8'b00001111; cin=1'b0;
end
initial $monitor ($time, " Sum = %d",sum, " Carry = %d",carry);
endmodule
