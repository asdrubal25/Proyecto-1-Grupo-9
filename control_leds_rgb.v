`timescale 1ns / 1ps
////////////////////////////////////////////////////////////
//control de led, muestra en la FPGA el mismo color que en pantalla
module control_leds_rgb(
    input sw1, sw2,sw3,
    output led_r, led_g, led_b
    );
    
    assign led_r=sw1;
    assign led_g=sw2;
    assign led_b=sw3;
    
endmodule
