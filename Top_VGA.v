`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.02.2017 16:56:38
// Design Name: 
// Module Name: Top_VGA
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Top_VGA(
    input wire clk_100M, reset,
    input swt1,swt2,swt3,
    output wire vsync, hsync,
    output wire[2:0] rgb,
    output wire led_r, led_g, led_b
    );

////intanciación para prueba de leds en la fpga de la nexys4
control_leds_rgb leds(
    .sw1(swt1),
    .sw2(swt2),
    .sw3(swt3),
    .led_r(led_r),
    .led_g(led_g),
    .led_b(led_b)
    );
        
////Instanciación del clk
clk_50M divisorclk(
    .reset(reset),
    .clk_100M(clk_100M),
    .clk(clk)
    );

// declaracion de registros de colores
wire [9:0] pixel_x; 
wire [9:0] pixel_y;
wire video_onclk; 
wire pixel_tick;
reg [2:0] rgb_reg;
wire [2:0] rgb_next;

//Instanciacion del bloque sincronizador(func principales)
VGA_Sync VGA_Sync(
	.clk(clk), 
	.reset(reset), 
	.hsync(hsync), 
	.vsync(vsync), 
	.video_on(video_on), 
    .p_tick(pixel_tick),		
	.pixel_x(pixel_x),
	.pixel_y(pixel_y)
	);
	
// Instanciacion del bloque generador de texto
Generador_texto Generador_texto(
    .clk(clk), 
    .video_on(video_on), 
    .pixel_x(pixel_x), 
    .pixel_y(pixel_y), 
	.swt1(swt1), 
	.swt2(swt2), 
	.swt3(swt3),
	.rgb_text(rgb_next)
    );
	 
	 
// rgb buffer
   always @(negedge clk)
      if (pixel_tick)
         rgb_reg <= rgb_next;
   // output
   assign rgb = rgb_reg;
	 
endmodule 