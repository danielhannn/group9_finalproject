module tb();
    reg clk = 0;
    reg reborn = 0;
    reg parachute = 0;
    wire flying, falling, ground, alive,  no_heartbeat;
    wire [6:0] seg;
    
    fly s0(
    .clk    (clk),
	.reborn	(reborn),
    .parachute   (parachute),
    
    .flying (flying),
    .falling    (falling),
    .ground (ground),
    .alive   (alive),
    .no_heartbeat (no_heartbeat),
    .seg(seg)
    );
    
    always #5 clk = ~clk;
    
    initial begin
        #10
        reborn = 1;
        #10
        reborn = 0;
        #50
        #100
        reborn = 1;
        #10
        reborn = 0;
        #50
        #40
        parachute = 1;
        #50
        reborn = 1;
        parachute = 0;
        #10
        reborn = 0;
        #50
        #60
        parachute = 1;
        #50
        $finish;
    end
endmodule
