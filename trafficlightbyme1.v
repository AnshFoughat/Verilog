// ////////////////////////traffic lights 
`define Red 2'b00
`define Green 2'b11
`define Yellow 2'b01
////////////////////////state transisitions 
`define s0  3'b000//highway on gg country off
`define s1  3'b001//highway on 
`define s2  3'b010
`define s3  3'b011
`define s4  3'b100
`define s5  3'b101

////////////////////////Delays
`define YellowtoRed  7
`define RedtoGreen   7
`define s0tos1   9
`define s1tos2   7
`define s3tos4   9
/////////////////////////true and false

`define TRUE 1'b1
`define FALSE 1'b0

module first(hwy, country, X, B, clock, clear, hours, minutes, char, is_true,is_true1);

output reg [1:0] hwy, country;////////////green yellow red
// reg [1:0] hwy, country;
input X;//for the traffic in day 
input B;//for the a b c in night
input clock,clear;
reg [2:0] state;
reg [2:0] next_state;

/////////////////////////////////////////////////////////
input [4:0] hours;   
input [5:0] minutes; 
/////////////////////////////////////////////////////////
input [7:0] char;  
output is_true;  
// output is_true1;
output wire is_true1 

initial begin
    state = `s0;
    next_state = `s0;
    hwy=`Green;
    country=`Red;

end

always @(posedge clock) begin///this is created so that on every state it check clock
    state=next_state;
end

always @(state) begin////////this how the state changes
    case(state)
        `s0: begin
            hwy=`Green;
            country=`Red;
        end
        `s1: begin
            hwy=`Green;
            country=`Red;
        end
        `s2: begin
            hwy=`Yellow;
            country=`Red;
        end
        
        `s3: begin
            hwy=`Red;
            country=`Green;
        end
        `s4: begin
            hwy=`Red;
            country=`Yellow;
        end
    endcase
end


// reg char_is_true;
// wire char_is_true;

char_detector char_det_inst(
    .char(char),
    .is_true1(is_true1)  // Connect to wire instead of reg
);


 always @(state or clear or X  or is_true1) begin
        if ((hours >= 5 && hours < 9) || (hours == 9 && minutes == 0))            
            if(clear)
                next_state = `s0;
            else 
                case (state) 
                    `s0: if(X)begin
                            repeat(`s0tos1)@(posedge clock);
                            next_state = `s1;
                        end    
                        else if (is_true1)begin
                            next_state = `s2;
                        end else begin
                            next_state = `s0;
                        end
                    `s1: begin
                        repeat(`s1tos2)@(posedge clock);
                            next_state=`s2;
                    end      
                    `s2: begin
                        repeat(`YellowtoRed)@(posedge clock);
                            next_state=`s3;
                    end    
                    `s3: begin
                        repeat(`s3tos4)@(posedge clock);
                            next_state=`s4;
                    end
                    `s4: begin
                        repeat(`YellowtoRed)@(posedge clock);
                            next_state=`s0;
                    end
                    default: next_state=`s0;
                endcase            
        else    
            if(clear)
                next_state = `s0;
            else 
                case (state)
                    `s0: if(is_true1)begin
                            next_state=`s2;
                        end else begin
                            next_state=`s0;
                        end    
                    `s2: begin
                        repeat(`YellowtoRed)@(posedge clock);
                            next_state=`s4;
                    end    
                    `s4: begin
                        repeat(`YellowtoRed)@(posedge clock);
                            next_state=`s0;
                    end
                default: next_state=`s0;
            endcase
                
end
endmodule

