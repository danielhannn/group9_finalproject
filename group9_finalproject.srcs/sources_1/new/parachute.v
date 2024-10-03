//do not modify this module
module game_module(
    input   clk   ,
    input   reborn   ,
    input   parachute  ,
    
    output  ground,
    output  flying ,
    output  falling ,
    output  alive   ,
    output  no_heartbeat,
    output  [3:0] led,
    output [6:0] seg
    
    
    );
    
    wire    clk_div ;
    
    fly s0(
    .clk    (clk_div),
	.reborn	(reborn),
    .parachute   (parachute),
    
    .flying (flying),
    .falling    (falling),
    .alive   (alive),
    .no_heartbeat   (no_heartbeat),
    .ground(ground),
    .seg(seg)
    );
    
    clk_div clk_div_0(
    .clk    (clk),
    .reborn    (reborn),
    .clk_div    (clk_div)
    );
    
    shifter shift_0(
    .clk(clk_div),
    .rst(reborn),
    .out(led)
    );
    
    
    
endmodule
