// Includes simulation model of DesignWare. 
// If do synthesis, please comments all simulation model
`include "/usr/local/synopsys/Design_Compiler/K-2015.06-SP5-5/dw/sim_ver/DW01_addsub.v"
`include "/usr/local/synopsys/Design_Compiler/K-2015.06-SP5-5/dw/sim_ver/DW02_mult.v"
`include "/usr/local/synopsys/Design_Compiler/K-2015.06-SP5-5/dw/sim_ver/DW_div.v"
`include "/usr/local/synopsys/Design_Compiler/K-2015.06-SP5-5/dw/sim_ver/DW_sqrt.v"
`include "/usr/local/synopsys/Design_Compiler/K-2015.06-SP5-5/dw/sim_ver/DW_shifter.v"
`define DATA_WIDTH 64

 module alu (dataout, datain_A, datain_B, f_code, subfield_selection, c_out_msb);
    input [0:`DATA_WIDTH - 1] datain_A, datain_B; // Data inputs A and B 
    input [0:5] f_code; // 6-bit function code for R-Type instructions.
    input [0:1] subfield_selection; // 2-bit WW Bits
    output  c_out_msb;
    output reg [0:`DATA_WIDTH - 1] dataout; // Output of the ALU

    localparam TC = 1'b0; // 0 = unsigned; 1= signed based on Designware Manual

    // Func codes for R-Type Instructions
    localparam  VAND = 6'b000001,
                VOR = 6'b000010,
                VXOR = 6'b000011,
                VNOT = 6'b000100,
                VMOV = 6'b000101, // only carry datain_A to output
                VADD = 6'b000110,
                VSUB = 6'b000111,
                VMULEU = 6'b001000,
                VMULOU = 6'b001001,
                VSLL = 6'b001010,
                VSRL = 6'b001011,
                VSRA = 6'b001100,
                VRTTH = 6'b001101,
                VDIV = 6'b001110,
                VMOD = 6'b001111, 
                VSQEU = 6'b010000,
                VSQOU = 6'b010001,
                VSQRT = 6'b010010;

    // Participation field select mode
    localparam  b_mode = 2'b00, // byte mode
                h_mode = 2'b01, // half word mode
                w_mode = 2'b10, // word mode
                d_mode = 2'b11; // double word mode


//-----------------------------------------------------------------------------------------------------------------------
// Adders array supporting 64-bit VADD, VSUB
// also supporting selective execution based on subfield_selection 
// Design Ware used: eight 8-bit DW01_addsub
    wire [0:7] carry_in, carry_out;
    wire add_sub_sel; // 0 = ADD; 1 = SUB
    wire [0:63] result;

    assign add_sub_sel = (f_code == VADD) ? 1'b0 : 1'b1;

    DW01_addsub #( .width(8)) addsub_0 ( .A(datain_A[0:7]), .B(datain_B[0:7]), .CI(carry_in[0]), .CO(c_out_msb), .ADD_SUB(add_sub_sel), .SUM(result[0:7]));

    DW01_addsub #( .width(8)) addsub_1 ( .A(datain_A[8:15]), .B(datain_B[8:15]), .CI(carry_in[1]), .CO(carry_out[1]), .ADD_SUB(add_sub_sel), .SUM(result[8:15]));

    DW01_addsub #( .width(8)) addsub_2 ( .A(datain_A[16:23]), .B(datain_B[16:23]), .CI(carry_in[2]), .CO(carry_out[2]), .ADD_SUB(add_sub_sel), .SUM(result[16:23]));
    DW01_addsub #( .width(8)) addsub_3 ( .A(datain_A[24:31]), .B(datain_B[24:31]), .CI(carry_in[3]), .CO(carry_out[3]), .ADD_SUB(add_sub_sel), .SUM(result[24:31]));

    DW01_addsub #( .width(8)) addsub_4 ( .A(datain_A[32:39]), .B(datain_B[32:39]), .CI(carry_in[4]), .CO(carry_out[4]), .ADD_SUB(add_sub_sel), .SUM(result[32:39]));

    DW01_addsub #( .width(8)) addsub_5 ( .A(datain_A[40:47]), .B(datain_B[40:47]), .CI(carry_in[5]), .CO(carry_out[5]), .ADD_SUB(add_sub_sel), .SUM(result[40:47]));

    DW01_addsub #( .width(8)) addsub_6 ( .A(datain_A[48:55]), .B(datain_B[48:55]), .CI(carry_in[6]), .CO(carry_out[6]), .ADD_SUB(add_sub_sel), .SUM(result[48:55]));

    DW01_addsub #( .width(8)) addsub_7 ( .A(datain_A[56:63]), .B(datain_B[56:63]), .CI(carry_in[7]), .CO(carry_out[7]), .ADD_SUB(add_sub_sel), .SUM(result[56:63]));
    
    // Conditionaly connecting each 8-bit adder/subtractor
    assign carry_in[0] = (subfield_selection == b_mode) ? 1'b0 : carry_out[1];
    assign carry_in[1] = ((subfield_selection == b_mode) || (subfield_selection == h_mode)) ? 1'b0 : carry_out[2];
    assign carry_in[2] = (subfield_selection == b_mode) ? 1'b0 : carry_out[3];
    assign carry_in[3] = ((subfield_selection == b_mode) || (subfield_selection == h_mode) || (subfield_selection == w_mode)) ? 1'b0 : carry_out[4];
    assign carry_in[4] = (subfield_selection == b_mode) ? 1'b0 : carry_out[5];
    assign carry_in[5] = ((subfield_selection == b_mode) || (subfield_selection == h_mode)) ? 1'b0 : carry_out[6];
    assign carry_in[6] = (subfield_selection == b_mode) ? 1'b0 : carry_out[7];
    assign carry_in[7] = 1'b0;


//-----------------------------------------------------------------------------------------------------------------------
//  VMULEU, VMULOU, VSQEU, VSQOU 
// Design Ware used:    four 8-bit DW02_mult ||  two 16-bit DW02_mult || one 32-bit DW02_mult

    reg [0:31] multiplier_datain_A, multiplier_datain_B;
    wire [0:64] mult_result_b, mult_result_h, mult_result_w; 

    // Assign different parts to multiplier input
    // For example:
    //     If there is byte mode VMULEU, we assign even bytes to multiplier input
    //     If there is byte mode VMULOU, we assign odd bytes to multiplier input  
    always @(*)
    begin
        multiplier_datain_A = 32'bx;
        multiplier_datain_B = 32'bx;
        
        case(f_code)
            VMULEU :
                case(subfield_selection) 
                    b_mode : 
                    begin
                        multiplier_datain_A = {datain_A[0:7], datain_A[16:23], datain_A[32:39], datain_A[48:55]};
                        multiplier_datain_B = {datain_B[0:7], datain_B[16:23], datain_B[32:39], datain_B[48:55]};
                    end
                    h_mode :
                    begin
                        multiplier_datain_A = {datain_A[0:15], datain_A[32:47]};
                        multiplier_datain_B = {datain_B[0:15], datain_B[32:47]};
                    end
                    w_mode :
                    begin
                        multiplier_datain_A = datain_A[0:31];
                        multiplier_datain_B = datain_B[0:31];
                    end
                endcase

            VMULOU :
                case(subfield_selection) 
                    b_mode : 
                    begin
                        multiplier_datain_A = {datain_A[8:15], datain_A[24:31], datain_A[40:47], datain_A[56:63]};
                        multiplier_datain_B = {datain_B[8:15], datain_B[24:31], datain_B[40:47], datain_B[56:63]};
                    end
                    h_mode :
                    begin
                        multiplier_datain_A = {datain_A[16:31], datain_A[48:63]};
                        multiplier_datain_B = {datain_B[16:31], datain_B[48:63]};
                    end
                    w_mode :
                    begin
                        multiplier_datain_A = datain_A[32:63];
                        multiplier_datain_B = datain_B[32:63];
                    end
                endcase

            VSQEU :
                case(subfield_selection) 
                    b_mode : 
                    begin
                        multiplier_datain_A = {datain_A[0:7], datain_A[16:23], datain_A[32:39], datain_A[48:55]};
                        multiplier_datain_B = {datain_A[0:7], datain_A[16:23], datain_A[32:39], datain_A[48:55]};
                    end
                    h_mode : 
                    begin
                        multiplier_datain_A = {datain_A[0:15], datain_A[32:47]};
                        multiplier_datain_B = {datain_A[0:15], datain_A[32:47]};
                    end
                    w_mode : 
                    begin
                        multiplier_datain_A = datain_A[0:31];
                        multiplier_datain_B = datain_A[0:31];
                    end
                endcase

            VSQOU :
                case(subfield_selection) 
                    b_mode : 
                    begin
                        multiplier_datain_A = {datain_A[8:15], datain_A[24:31], datain_A[40:47], datain_A[56:63]};
                        multiplier_datain_B = {datain_A[8:15], datain_A[24:31], datain_A[40:47], datain_A[56:63]};
                    end
                    h_mode : 
                    begin
                        multiplier_datain_A = {datain_A[16:31], datain_A[48:63]};
                        multiplier_datain_B = {datain_A[16:31], datain_A[48:63]};
                    end
                    w_mode : 
                    begin
                        multiplier_datain_A = datain_A[32:63];
                        multiplier_datain_B = datain_A[32:63];
                    end
                endcase
        endcase
    end

    //  Multiplier array Instantiation:
    //  byte mode:
    DW02_mult #( .A_width(8), .B_width(8)) mult_b_0 ( .A(multiplier_datain_A[0:7]), .B(multiplier_datain_B[0:7]), .TC(TC), .PRODUCT(mult_result_b[0:15]));

    DW02_mult #( .A_width(8), .B_width(8)) mult_b_1 ( .A(multiplier_datain_A[8:15]), .B(multiplier_datain_B[8:15]), .TC(TC), .PRODUCT(mult_result_b[16:31]));

    DW02_mult #( .A_width(8), .B_width(8)) mult_b_2 ( .A(multiplier_datain_A[16:23]), .B(multiplier_datain_B[16:23]), .TC(TC), .PRODUCT(mult_result_b[32:47]));

    DW02_mult #( .A_width(8), .B_width(8)) mult_b_3 ( .A(multiplier_datain_A[24:31]), .B(multiplier_datain_B[24:31]), .TC(TC), .PRODUCT(mult_result_b[48:63]));

    //halfword  mode:
    DW02_mult #( .A_width(16), .B_width(16)) mult_h_0 ( .A(multiplier_datain_A[0:15]), .B(multiplier_datain_B[0:15]), .TC(TC), .PRODUCT(mult_result_h[0:31]));

    DW02_mult #( .A_width(16), .B_width(16)) mult_h_1 ( .A(multiplier_datain_A[16:31]), .B(multiplier_datain_B[16:31]), .TC(TC), .PRODUCT(mult_result_h[32:63]));

    //word mode:
    DW02_mult #( .A_width(32), .B_width(32)) mult_w_0 ( .A(multiplier_datain_A[0:31]), .B(multiplier_datain_B[0:31]), .TC(TC), .PRODUCT(mult_result_w[0:63]));

//-----------------------------------------------------------------------------------------------------------------------
//  VDIV, VMOD
// Design Ware used:    eight- 8-bit DW_div   four- 16-bit DW_div two- 32-bit DW_div    one- 64-bit DW_div

    wire [0:63] divisor, dividend;
    wire [0:63] quotient_b, quotient_h, quotient_w, quotient_d, remainder_b, remainder_h, remainder_w, remainder_d; 

    // Inputs for the divider
    assign dividend[0:63] = datain_A[0:63]; 
    
    // If Divider is not used then the divisior inputs should be "all 1s" to avoid /0 case
    assign divisor[0:63] = ((f_code == VDIV) || (f_code == VMOD)) ? datain_B[0:63] : {64{1'b1}}; 

    // divider instantiation
    //    For byte mode:
    DW_div #( .a_width(8), .b_width(8), .tc_mode(TC), .rem_mode(0) ) DW_div_b_0 ( .a(dividend[0:7]), .b(divisor[0:7]), .quotient(quotient_b[0:7]), .remainder(remainder_b[0:7]), .divide_by_0());
    
    DW_div #( .a_width(8), .b_width(8), .tc_mode(TC), .rem_mode(0) ) DW_div_b_1 ( .a(dividend[8:15]), .b(divisor[8:15]), .quotient(quotient_b[8:15]), .remainder(remainder_b[8:15]), .divide_by_0());

    DW_div #( .a_width(8), .b_width(8), .tc_mode(TC), .rem_mode(0) ) DW_div_b_2 ( .a(dividend[16:23]), .b(divisor[16:23]), .quotient(quotient_b[16:23]), .remainder(remainder_b[16:23]), .divide_by_0());

    DW_div #( .a_width(8), .b_width(8), .tc_mode(TC), .rem_mode(0) ) DW_div_b_3 ( .a(dividend[24:31]), .b(divisor[24:31]), .quotient(quotient_b[24:31]), .remainder(remainder_b[24:31]), .divide_by_0());

    DW_div #( .a_width(8), .b_width(8), .tc_mode(TC), .rem_mode(0) ) DW_div_b_4 ( .a(dividend[32:39]), .b(divisor[32:39]), .quotient(quotient_b[32:39]), .remainder(remainder_b[32:39]), .divide_by_0());

    DW_div #( .a_width(8), .b_width(8), .tc_mode(TC), .rem_mode(0) ) DW_div_b_5 ( .a(dividend[40:47]), .b(divisor[40:47]), .quotient(quotient_b[40:47]), .remainder(remainder_b[40:47]), .divide_by_0());

    DW_div #( .a_width(8), .b_width(8), .tc_mode(TC), .rem_mode(0) ) DW_div_b_6 ( .a(dividend[48:55]), .b(divisor[48:55]), .quotient(quotient_b[48:55]), .remainder(remainder_b[48:55]), .divide_by_0());

    DW_div #( .a_width(8), .b_width(8), .tc_mode(TC), .rem_mode(0) ) DW_div_b_7 ( .a(dividend[56:63]), .b(divisor[56:63]), .quotient(quotient_b[56:63]), .remainder(remainder_b[56:63]), .divide_by_0());

    //    half word 
    DW_div #( .a_width(16), .b_width(16), .tc_mode(TC), .rem_mode(0) ) DW_div_h_0 ( .a(dividend[0:15]), .b(divisor[0:15]), .quotient(quotient_h[0:15]), .remainder(remainder_h[0:15]), .divide_by_0());

    DW_div #( .a_width(16), .b_width(16), .tc_mode(TC), .rem_mode(0) ) DW_div_h_1 ( .a(dividend[16:31]), .b(divisor[16:31]), .quotient(quotient_h[16:31]), .remainder(remainder_h[16:31]), .divide_by_0());

    DW_div #( .a_width(16), .b_width(16), .tc_mode(TC), .rem_mode(0) ) DW_div_h_2 ( .a(dividend[32:47]), .b(divisor[32:47]), .quotient(quotient_h[32:47]), .remainder(remainder_h[32:47]), .divide_by_0());

    DW_div #( .a_width(16), .b_width(16), .tc_mode(TC), .rem_mode(0) ) DW_div_h_3 ( .a(dividend[48:63]), .b(divisor[48:63]), .quotient(quotient_h[48:63]), .remainder(remainder_h[48:63]), .divide_by_0());

    //     word 
    DW_div #( .a_width(32), .b_width(32), .tc_mode(TC), .rem_mode(0) ) DW_div_w_0 ( .a(dividend[0:31]), .b(divisor[0:31]), .quotient(quotient_w[0:31]), .remainder(remainder_w[0:31]), .divide_by_0());

    DW_div #( .a_width(32), .b_width(32), .tc_mode(TC), .rem_mode(0) ) DW_div_w_1 ( .a(dividend[32:63]), .b(divisor[32:63]), .quotient(quotient_w[32:63]), .remainder(remainder_w[32:63]), .divide_by_0());

    //  double word 
    DW_div #( .a_width(64), .b_width(64), .tc_mode(TC), .rem_mode(0) ) DW_div_d_0 ( .a(dividend[0:63]), .b(divisor[0:63]), .quotient(quotient_d[0:63]), .remainder(remainder_d[0:63]), .divide_by_0());

//-----------------------------------------------------------------------------------------------------------------------
// VSQRT
//     eight 8-bit DW_sqrt four 16-bit DW_sqrt two 32-bit DW_sqrt one 64-bit DW_sqrt

    wire [0:63] root_b, root_h, root_w, root_d; 

    //square root 
    //byte 
    DW_sqrt #( .width(8), .tc_mode(TC)) DW_sqrt_b_0 ( .a(datain_A[0:7]), .root(root_b[4:7]));
    assign root_b[0:3] = 0;

    DW_sqrt #( .width(8), .tc_mode(TC)) DW_sqrt_b_1 ( .a(datain_A[8:15]), .root(root_b[12:15]));
    assign root_b[8:11] = 0;  

    DW_sqrt #( .width(8), .tc_mode(TC)) DW_sqrt_b_2 ( .a(datain_A[16:23]), .root(root_b[20:23]));
    assign root_b[16:19] = 0; 

    DW_sqrt #( .width(8), .tc_mode(TC)) DW_sqrt_b_3 ( .a(datain_A[24:31]), .root(root_b[28:31]));
    assign root_b[24:27] = 0; 

    DW_sqrt #( .width(8), .tc_mode(TC)) DW_sqrt_b_4 ( .a(datain_A[32:39]), .root(root_b[36:39]));
    assign root_b[32:35] = 0; 

    DW_sqrt #( .width(8), .tc_mode(TC)) DW_sqrt_b_5 ( .a(datain_A[40:47]), .root(root_b[44:47]));
    assign root_b[40:43] = 0; 

    DW_sqrt #( .width(8), .tc_mode(TC)) DW_sqrt_b_6 ( .a(datain_A[48:55]), .root(root_b[52:55]));
    assign root_b[48:51] = 0; 

    DW_sqrt #( .width(8), .tc_mode(TC)) DW_sqrt_b_7 ( .a(datain_A[56:63]), .root(root_b[60:63]));
    assign root_b[56:59] = 0; 

    //half word 
    DW_sqrt #( .width(16), .tc_mode(TC)) DW_sqrt_h_0 ( .a(datain_A[0:15]), .root(root_h[8:15]));
    assign root_h[0:7] = 0; 

    DW_sqrt #( .width(16), .tc_mode(TC)) DW_sqrt_h_1 ( .a(datain_A[16:31]), .root(root_h[24:31]));
    assign root_h[16:23] = 0; 

    DW_sqrt #( .width(16), .tc_mode(TC)) DW_sqrt_h_2 ( .a(datain_A[32:47]), .root(root_h[40:47]));
    assign root_h[32:39] = 0; 

    DW_sqrt #( .width(16), .tc_mode(TC)) DW_sqrt_h_3 ( .a(datain_A[48:63]), .root(root_h[56:63]));
    assign root_h[48:55] = 0; 

    //word 
    DW_sqrt #( .width(32), .tc_mode(TC)) DW_sqrt_w_0 ( .a(datain_A[0:31]), .root(root_w[16:31]));
    assign root_w[0:15] = 0; 

    DW_sqrt #( .width(32), .tc_mode(TC)) DW_sqrt_w_1 ( .a(datain_A[32:63]), .root(root_w[48:63]));
    assign root_w[32:47] = 0; 

    //double word 
    DW_sqrt #( .width(64), .tc_mode(TC)) DW_sqrt_d_0 ( .a(datain_A[0:63]), .root(root_d[32:63]));
    assign root_d[0:31] = 0; 

//-----------------------------------------------------------------------------------------------------------------------
// VSLL, VSRL, VSRA
// Design Ware used:    eight 8-bit DW_shifter four 16-bit DW_shifter two 32-bit DW_shifter one 64-bit DW_shifter

    // shift value using signed numbers
    // shift length =  Log2(data_width) + 1;(inlude sign bit)
    reg [0:3]   shift_byte_0, shift_byte_1, shift_byte_2, shift_byte_3,
                shift_byte_4, shift_byte_5, shift_byte_6, shift_byte_7; // byte 
    reg [0:4]   shift_hword_0, shift_hword_1, shift_hword_2, shift_hword_3; //half word
    reg [0:5]   shift_word_0, shift_word_1; // word 
    reg [0:6]   shift_dword_0; // double word

    // Generates shift value
    always @(*)
    begin
        shift_byte_0 = 4'bx;
        shift_byte_1 = 4'bx;
        shift_byte_2 = 4'bx;
        shift_byte_3 = 4'bx;
        shift_byte_4 = 4'bx;
        shift_byte_5 = 4'bx;
        shift_byte_6 = 4'bx;
        shift_byte_7 = 4'bx;

        shift_hword_0 = 5'bx;
        shift_hword_1 = 5'bx;
        shift_hword_2 = 5'bx;
        shift_hword_3 = 5'bx;

        shift_word_0 = 6'bx;
        shift_word_1 = 6'bx;

        shift_dword_0 = 7'bx;

        case(subfield_selection)
            b_mode :
                if(f_code == VSLL)
                begin
                    shift_byte_0 = {1'b0, datain_B[5:7]};
                    shift_byte_1 = {1'b0, datain_B[13:15]};
                    shift_byte_2 = {1'b0, datain_B[21:23]};
                    shift_byte_3 = {1'b0, datain_B[29:31]};
                    shift_byte_4 = {1'b0, datain_B[37:39]};
                    shift_byte_5 = {1'b0, datain_B[45:47]};
                    shift_byte_6 = {1'b0, datain_B[53:55]};
                    shift_byte_7 = {1'b0, datain_B[61:63]};
                end
                else // right shift = 2's complement of shift value 
                begin
                    shift_byte_0 = ({1'b0, datain_B[5:7]} ^ 4'b1111) + 1;
                    shift_byte_1 = ({1'b0, datain_B[13:15]} ^ 4'b1111) + 1;
                    shift_byte_2 = ({1'b0, datain_B[21:23]} ^ 4'b1111) + 1;
                    shift_byte_3 = ({1'b0, datain_B[29:31]} ^ 4'b1111) + 1;
                    shift_byte_4 = ({1'b0, datain_B[37:39]} ^ 4'b1111) + 1;
                    shift_byte_5 = ({1'b0, datain_B[45:47]} ^ 4'b1111) + 1;
                    shift_byte_6 = ({1'b0, datain_B[53:55]} ^ 4'b1111) + 1;
                    shift_byte_7 = ({1'b0, datain_B[61:63]} ^ 4'b1111) + 1;
                end
            h_mode :
                if(f_code == VSLL)
                begin
                    shift_hword_0 = {1'b0, datain_B[12:15]};
                    shift_hword_1 = {1'b0, datain_B[28:31]};
                    shift_hword_2 = {1'b0, datain_B[44:47]};
                    shift_hword_3 = {1'b0, datain_B[60:63]};
                end
                else 
                begin
                    shift_hword_0 = ({1'b0, datain_B[12:15]} ^ 5'b1_1111) + 1;
                    shift_hword_1 = ({1'b0, datain_B[28:31]} ^ 5'b1_1111) + 1;
                    shift_hword_2 = ({1'b0, datain_B[44:47]} ^ 5'b1_1111) + 1;
                    shift_hword_3 = ({1'b0, datain_B[60:63]} ^ 5'b1_1111) + 1;
                end
            w_mode :
                if(f_code == VSLL)
                begin
                    shift_word_0 = {1'b0, datain_B[27:31]};
                    shift_word_1 = {1'b0, datain_B[59:63]};
                end
                else 
                begin
                    shift_word_0 = ({1'b0, datain_B[27:31]} ^ 6'b11_1111) + 1;
                    shift_word_1 = ({1'b0, datain_B[59:63]} ^ 6'b11_1111) + 1;
                end 
            d_mode :
                if(f_code == VSLL)
                    shift_dword_0 = {1'b0, datain_B[58:63]};
                else 
                    shift_dword_0 = ({1'b0, datain_B[58:63]} ^ 7'b111_1111) + 1;
        endcase
    end

    // 1 = signed ; 0 = unsigned; perform sign extension for signed right shift. 
    wire sign; 
    assign sign = (f_code == VSRA) ? 1'b1 : 1'b0;

    // shifter instantiations 
    // width --> Log2(data_width) + 1 ;; inv_mode -->  0 = normal input, 0 padding in output ;; sh_tc --> 1 = signed sh ;; sh_mode --> 1 = arithmetic shift mode

    wire [0:63] shifter_dataout_b, shifter_dataout_h, shifter_dataout_w, shifter_dataout_d; 
    // byte 
    DW_shifter #( .data_width(8), .sh_width(4), .inv_mode(0)     ) DW_shifter_b_0 ( .data_in(datain_A[0:7]), .data_tc(sign), .sh(shift_byte_0), .sh_tc(1'b1),         .sh_mode(1'b1), .data_out(shifter_dataout_b[0:7]));

    DW_shifter #( .data_width(8), .sh_width(4), .inv_mode(0) ) DW_shifter_b_1 ( .data_in(datain_A[8:15]), .data_tc(sign), .sh(shift_byte_1), .sh_tc(1'b1), .sh_mode(1'b1), .data_out(shifter_dataout_b[8:15]));

    DW_shifter #( .data_width(8), .sh_width(4), .inv_mode(0) ) DW_shifter_b_2 ( .data_in(datain_A[16:23]), .data_tc(sign), .sh(shift_byte_2), .sh_tc(1'b1), .sh_mode(1'b1), .data_out(shifter_dataout_b[16:23]));

    DW_shifter #( .data_width(8), .sh_width(4), .inv_mode(0) ) DW_shifter_b_3 ( .data_in(datain_A[24:31]), .data_tc(sign), .sh(shift_byte_3), .sh_tc(1'b1), .sh_mode(1'b1), .data_out(shifter_dataout_b[24:31]));

    DW_shifter #( .data_width(8), .sh_width(4), .inv_mode(0) ) DW_shifter_b_4 ( .data_in(datain_A[32:39]), .data_tc(sign), .sh(shift_byte_4), .sh_tc(1'b1), .sh_mode(1'b1), .data_out(shifter_dataout_b[32:39]));

    DW_shifter #( .data_width(8), .sh_width(4), .inv_mode(0) ) DW_shifter_b_5 ( .data_in(datain_A[40:47]), .data_tc(sign), .sh(shift_byte_5), .sh_tc(1'b1), .sh_mode(1'b1), .data_out(shifter_dataout_b[40:47]));

    DW_shifter #( .data_width(8), .sh_width(4), .inv_mode(0) ) DW_shifter_b_6 ( .data_in(datain_A[48:55]), .data_tc(sign), .sh(shift_byte_6), .sh_tc(1'b1), .sh_mode(1'b1), .data_out(shifter_dataout_b[48:55]));

    DW_shifter #( .data_width(8), .sh_width(4), .inv_mode(0) ) DW_shifter_b_7 ( .data_in(datain_A[56:63]), .data_tc(sign), .sh(shift_byte_7), .sh_tc(1'b1), .sh_mode(1'b1), .data_out(shifter_dataout_b[56:63]));

    //    half word 
    DW_shifter #( .data_width(16), .sh_width(5), .inv_mode(0) ) DW_shifter_h_0 ( .data_in(datain_A[0:15]), .data_tc(sign), .sh(shift_hword_0), .sh_tc(1'b1), .sh_mode(1'b1), .data_out(shifter_dataout_h[0:15]));

    DW_shifter #( .data_width(16), .sh_width(5), .inv_mode(0) ) DW_shifter_h_1 ( .data_in(datain_A[16:31]), .data_tc(sign), .sh(shift_hword_1), .sh_tc(1'b1), .sh_mode(1'b1), .data_out(shifter_dataout_h[16:31]));

    DW_shifter #( .data_width(16), .sh_width(5), .inv_mode(0) ) DW_shifter_h_2 ( .data_in(datain_A[32:47]), .data_tc(sign), .sh(shift_hword_2), .sh_tc(1'b1), .sh_mode(1'b1), .data_out(shifter_dataout_h[32:47]));

    DW_shifter #( .data_width(16), .sh_width(5), .inv_mode(0) ) DW_shifter_h_3 ( .data_in(datain_A[48:63]), .data_tc(sign), .sh(shift_hword_3), .sh_tc(1'b1), .sh_mode(1'b1), .data_out(shifter_dataout_h[48:63]));

    //     word
    DW_shifter #( .data_width(32), .sh_width(6), .inv_mode(0) ) DW_shifter_w_0 ( .data_in(datain_A[0:31]), .data_tc(sign), .sh(shift_word_0), .sh_tc(1'b1), .sh_mode(1'b1), .data_out(shifter_dataout_w[0:31]));

    DW_shifter #( .data_width(32), .sh_width(6), .inv_mode(0) ) DW_shifter_w_1 ( .data_in(datain_A[32:63]),  .data_tc(sign), .sh(shift_word_1), .sh_tc(1'b1), .sh_mode(1'b1), .data_out(shifter_dataout_w[32:63]));

    //    double word
    DW_shifter #( .data_width(64), .sh_width(7), .inv_mode(0) ) DW_shifter_d_0 ( .data_in(datain_A[0:63]), .data_tc(sign), .sh(shift_dword_0), .sh_tc(1'b1), .sh_mode(1'b1), .data_out(shifter_dataout_d[0:63]));

//-----------------------------------------------------------------------------------------------------------------------

    // Output MUX to select between ALU & MEM Results
    always @(*)
    begin
        //to prevent latches in the design
        dataout = {`DATA_WIDTH{1'bx}};
        
        case(f_code)

            //binary 
            VAND : 
                dataout = datain_A & datain_B;
            VOR :
                dataout = datain_A | datain_B;
            VXOR :
                dataout = datain_A ^ datain_B;
            VNOT :
                dataout = ~ datain_A;

            // MV
            VMOV :
                dataout = datain_A;
            
            // ARITHMETIC:
            VADD : 
                dataout[0:63] = result[0:63];

            VSUB : 
                dataout[0:63] = result[0:63];

            VMULEU : 
                case(subfield_selection)
                    b_mode : dataout[0:63] = mult_result_b[0:63];
                    h_mode : dataout[0:63] = mult_result_h[0:63];
                    w_mode : dataout[0:63] = mult_result_w[0:63];
                endcase

            VMULOU : 
                case(subfield_selection)
                    b_mode : dataout[0:63] = mult_result_b[0:63];
                    h_mode : dataout[0:63] = mult_result_h[0:63];
                    w_mode : dataout[0:63] = mult_result_w[0:63];
                endcase

            VSQEU : 
                case(subfield_selection)
                    b_mode : dataout[0:63] = mult_result_b[0:63];
                    h_mode : dataout[0:63] = mult_result_h[0:63];
                    w_mode : dataout[0:63] = mult_result_w[0:63];
                endcase

            VSQOU : 
                case(subfield_selection)
                    b_mode : dataout[0:63] = mult_result_b[0:63];
                    h_mode : dataout[0:63] = mult_result_h[0:63];
                    w_mode : dataout[0:63] = mult_result_w[0:63];
                endcase

            VDIV : 
                case(subfield_selection)
                    b_mode : dataout[0:63] = quotient_b[0:63];
                    h_mode : dataout[0:63] = quotient_h[0:63];
                    w_mode : dataout[0:63] = quotient_w[0:63];
                    d_mode : dataout[0:63] = quotient_d[0:63];
                endcase

            VMOD : 
                case(subfield_selection)
                    b_mode : dataout[0:63] = remainder_b[0:63];
                    h_mode : dataout[0:63] = remainder_h[0:63];
                    w_mode : dataout[0:63] = remainder_w[0:63];
                    d_mode : dataout[0:63] = remainder_d[0:63];
                endcase

            VSQRT : 
                case(subfield_selection)
                    b_mode : dataout[0:63] = root_b[0:63];
                    h_mode : dataout[0:63] = root_h[0:63];
                    w_mode : dataout[0:63] = root_w[0:63];
                    d_mode : dataout[0:63] = root_d[0:63];
                endcase

            // SHIFT
            VSLL : 
                case(subfield_selection)
                    b_mode : dataout[0:63] = shifter_dataout_b[0:63];
                    h_mode : dataout[0:63] = shifter_dataout_h[0:63];
                    w_mode : dataout[0:63] = shifter_dataout_w[0:63];
                    d_mode : dataout[0:63] = shifter_dataout_d[0:63];
                endcase

            VSRL : 
                case(subfield_selection)
                    b_mode : dataout[0:63] = shifter_dataout_b[0:63];
                    h_mode : dataout[0:63] = shifter_dataout_h[0:63];
                    w_mode : dataout[0:63] = shifter_dataout_w[0:63];
                    d_mode : dataout[0:63] = shifter_dataout_d[0:63];
                endcase
            
            VSRA : 
                case(subfield_selection)
                    b_mode : dataout[0:63] = shifter_dataout_b[0:63];
                    h_mode : dataout[0:63] = shifter_dataout_h[0:63];
                    w_mode : dataout[0:63] = shifter_dataout_w[0:63];
                    d_mode : dataout[0:63] = shifter_dataout_d[0:63];
                endcase

            VRTTH :
                case(subfield_selection)
                    b_mode :
                    begin
                        dataout[0:7] = {datain_A[4:7], datain_A[0:3]};
                        dataout[8:15] = {datain_A[12:15], datain_A[8:11]};
                        dataout[16:23] = {datain_A[20:23], datain_A[16:19]};
                        dataout[24:31] = {datain_A[28:31], datain_A[24:27]};
                        dataout[32:39] = {datain_A[36:39], datain_A[32:35]};
                        dataout[40:47] = {datain_A[44:47], datain_A[40:43]};
                        dataout[48:55] = {datain_A[52:55], datain_A[48:51]};
                        dataout[56:63] = {datain_A[60:63], datain_A[56:59]};
                    end
                    h_mode :
                    begin
                        dataout[0:15] = {datain_A[8:15], datain_A[0:7]};
                        dataout[16:31] = {datain_A[24:31], datain_A[16:23]};
                        dataout[32:47] = {datain_A[40:47], datain_A[32:39]};
                        dataout[48:63] = {datain_A[56:63], datain_A[48:55]};
                    end
                    w_mode :
                    begin
                        dataout[0:31] = {datain_A[16:31], datain_A[0:15]};
                        dataout[32:63] = {datain_A[48:63], datain_A[32:47]};
                    end
                    d_mode :
                        dataout[0:63] = {datain_A[32:63], datain_A[0:31]};
                endcase
        endcase
    end
//-----------------------------------------------------------------------------------------------------------------------
 endmodule
`undef DATA_WIDTH
