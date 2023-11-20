// Register File
// Last Updated: 11/05/2023

module register_file (
    clk, reset,
    write_enb, data_in, pppsel, addr_wr, // write port
    data_out_0, addr_rd_0, // read port 0
    data_out_1, addr_rd_1 // read port 1
);

	parameter DEPTH = 32;
	parameter DATAWIDTH = 64;
	parameter ADDRWIDTH = 5;

    input clk, reset;
    input write_enb; // Write Enable for allowing writes
    input [0:2] pppsel; // 3bits control signal used for selective writing
    input [0:DATAWIDTH - 1] data_in; // Data input port for writing port
    input [0:ADDRWIDTH - 1] addr_wr; // write address for data writing

    input [0:ADDRWIDTH - 1] addr_rd_0, addr_rd_1; // read address for read port 0 and port 1
    output reg [0:DATAWIDTH - 1] data_out_0, data_out_1; // data output for read port 0 and port1

//-----------------------------------------------------------------------------------------------------------------------
    // Selective writing mode
    localparam  a_mode = 3'b000,
                u_mode = 3'b001,
                d_mode = 3'b010,
                e_mode = 3'b011,
                o_mode = 3'b100;

//-----------------------------------------------------------------------------------------------------------------------
    // Memory unit
    // We don't need to inplement $0
    reg [0:DATAWIDTH - 1] mem [DEPTH - 1:1];

//-----------------------------------------------------------------------------------------------------------------------
    // Read data
    // Assume this regfile supports internal forwarding
    always @(*)
    begin
        // Note that: if source register is $0, internal forwarding is meaningless
        if(addr_rd_0 == 0)
            data_out_0 = 0;
        else
        begin
            data_out_0 = mem[addr_rd_0];

            // if read address match with write address and there will be a writing operartion in current clock
            // I will forward the writing data to data output of reading port
            // Forward data to reading port 0
            if((write_enb == 1) && (addr_wr == addr_rd_0))
            begin
                case(pppsel)
                    a_mode :
                        data_out_0[0:63] = data_in[0:63];
                    u_mode :
                        data_out_0[0:31] = data_in[0:31];
                    d_mode :
                        data_out_0[32:63] = data_in[32:63];
                    e_mode :
                    begin
                        data_out_0[0+:8] = data_in[0+:8];
                        data_out_0[16+:8] = data_in[16+:8];
                        data_out_0[32+:8] = data_in[32+:8];
                        data_out_0[48+:8] = data_in[48+:8];
                    end
                    o_mode :
                    begin
                        data_out_0[8+:8] = data_in[8+:8];
                        data_out_0[24+:8] = data_in[24+:8];
                        data_out_0[40+:8] = data_in[40+:8];
                        data_out_0[56+:8] = data_in[56+:8];
                    end
                endcase
            end
        end

        if(addr_rd_1 == 0)
            data_out_1 = 0;
        else
        begin
            data_out_1 = mem[addr_rd_1];

            // Forward data to reading port 0
            if((write_enb == 1) && (addr_wr == addr_rd_1))
            begin
                case(pppsel)
                    a_mode :
                        data_out_1[0:63] = data_in[0:63];
                    u_mode :
                        data_out_1[0:31] = data_in[0:31];
                    d_mode :
                        data_out_1[32:63] = data_in[32:63];
                    e_mode :
                    begin
                        data_out_1[0+:8] = data_in[0+:8];
                        data_out_1[16+:8] = data_in[16+:8];
                        data_out_1[32+:8] = data_in[32+:8];
                        data_out_1[48+:8] = data_in[48+:8];
                    end
                    o_mode :
                    begin
                        data_out_1[8+:8] = data_in[8+:8];
                        data_out_1[24+:8] = data_in[24+:8];
                        data_out_1[40+:8] = data_in[40+:8];
                        data_out_1[56+:8] = data_in[56+:8];
                    end
                endcase
            end
        end

    end
//-----------------------------------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------------------------------
    // Data writing
    always @(posedge clk)
    begin : sequential
        reg [0:5] count;
        if(reset) // clear all contents during reset
            for(count = 1; count < DEPTH; count = count + 1)
                mem[count] <= 0;
        else
            if((write_enb == 1) && (addr_wr != 0))
                case(pppsel)
                    a_mode : // write whole 64 bits (DW)
                        mem[addr_wr] <= data_in;
                    u_mode : // write the upper 32 bits
                        mem[addr_wr][0+:32] <= data_in[0+:32];
                    d_mode : // write the lower 32 bits
                        mem[addr_wr][32+:32] <= data_in[32+:32];
                    e_mode : // write even bytes
                    begin
                        mem[addr_wr][0+:8] <= data_in[0+:8];
                        mem[addr_wr][16+:8] <= data_in[16+:8];
                        mem[addr_wr][32+:8] <= data_in[32+:8];
                        mem[addr_wr][48+:8] <= data_in[48+:8];
                    end
                    o_mode : // write odd bytes
                    begin
                        mem[addr_wr][8+:8] <= data_in[8+:8];
                        mem[addr_wr][24+:8] <= data_in[24+:8];
                        mem[addr_wr][40+:8] <= data_in[40+:8];
                        mem[addr_wr][56+:8] <= data_in[56+:8];
                    end
                endcase
    end
//-----------------------------------------------------------------------------------------------------------------------
endmodule
