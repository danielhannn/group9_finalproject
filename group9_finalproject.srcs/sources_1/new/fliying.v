
module fly(
input clk, reborn, parachute,
output reg flying, output reg falling, output reg ground, output reg alive, output reg no_heartbeat,
output reg [6:0]seg
);
parameter S_Fly = 3'b000;
parameter S_Fall = 3'b001;
parameter S_Survived = 3'b010;
parameter S_Dead = 3'b101;

reg [2:0]state, next;
reg [3:0]countdown;
reg [2:0]count;
reg [3:0] i;


always@(posedge reborn or posedge clk)begin

if (reborn) begin
    state <= S_Fly;
    countdown <= 5;
    i <= count+2;
end
else begin
    state <= next;
    if(countdown > 0) begin
        if(count < 7)
            count <= count+1;
        else
            count <= 0;
        countdown <= countdown-1;
    end
    else begin
        if(count < 7)
            count <= count+1;
        else
            count <= 0;
        countdown <= countdown-1;
        countdown <= i; 
    end      
end

end


//output logic
always@(*)begin
case(state)
    S_Fly:{flying, falling, ground, alive, no_heartbeat}        = 5'b10010;
    S_Fall:{flying, falling, ground, alive, no_heartbeat}       = 5'b01010;
    S_Survived:{flying, falling, ground, alive, no_heartbeat}   = 5'b00110;
    S_Dead :{flying, falling, ground, alive, no_heartbeat}      = 5'b00101;
    endcase
end
always@(countdown)begin
if(state == S_Fly) 
    seg = 7'b0000000;
else if(state == S_Dead)
    seg = 7'b0111111;
else if(state == S_Survived)
    seg = 7'b1111100;
else begin
case(countdown)
    0:
        seg = 7'b0111111;
    1:
        seg = 7'b0110000;
    2:
        seg = 7'b1011011;
    3:
        seg = 7'b1001111;
    4:
        seg = 7'b1100110;
    5:
        seg = 7'b1101101;
    6:
        seg = 7'b1111100;
    7:
        seg = 7'b0100111;
    8:
        seg = 7'b1111111;
    9:
        seg = 7'b1101111;
endcase
end
end

//next state logic
always@(countdown or reborn or parachute)begin

case(state)
    S_Fly:begin
        if(countdown == 0)
            next = S_Fall;
        else
            next = S_Fly;

    end
    S_Fall:begin
        if(countdown == 0)  next = S_Dead;
        else if(parachute) next = S_Survived;
        else next = S_Fall;
    end
    S_Survived:
        begin
        next = S_Survived;
        end
    S_Dead:
        begin
        next = S_Dead;
        end
endcase

end
endmodule