module shifternotime(
input clk, reborn, parachute, turbulence,
output reg flying, output reg falling, output reg if_alive
);
parameter S_Fly = 0;
parameter S_Fall = 1;
parameter S_Survived = 2;
parameter S_Dead = 3;
reg [1:0]state, next;
//state reg
always@(*)begin
if (reborn)
    state = S_Fly;
else 
    state = next;
end

//output logic
always@(*)begin
case(state)
    S_Fly:{flying, falling, if_alive} = 3'b101;
    S_Fall:{flying, falling, if_alive} = 3'b011;
    S_Survived:{flying, falling, if_alive} = 3'b001;
    S_Dead :{flying, falling, if_alive} = 3'b000;
    endcase
end
//next state logic
always@(*)begin
case(state)
    S_Fly:
        if(turbulence)  next = S_Fall;
        else    next = S_Fly;
    S_Fall:
        if(turbulence)  next = S_Dead;
        else if(parachute) next = S_Survived;
        else if(~parachute && ~turbulence) #3000000 next = S_Dead;
    S_Survived:
        begin
        next<= S_Survived;
        end
    S_Dead:
        begin
        next<= S_Dead;
        end
endcase
end
endmodule