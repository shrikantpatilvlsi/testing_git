// CPU Design
// Last updated: 11/05/2023

module cardinal_cpu (prog_counter_out, inst_from_imem, data_from_dmem, addr_to_dmem, data_to_dmem, dmem_En, dmem_WrEn, clk, reset, nic_addr, nic_d_in, nic_d_out, nicEn, nicWrEn);

    output [0:31] prog_counter_out; // address sent to imem
    output [0:31] addr_to_dmem; 	// address going from processor to data memory
    output [0:63] data_to_dmem; 	// data output from processor to data memory

 	//port mappings between NIC and processor
 	output [0:1] 	nic_addr;
	output [0:63] 	nic_d_in;
	output 			nicEn;
	output			nicWrEn;

	input 	[0:63]	nic_d_out;

 	// enbale signal of data memory
    output dmem_En;
	output dmem_WrEn;

    input [0:31] inst_from_imem; 	// instruction coming from imem
    input [0:63] data_from_dmem; 	// data from data memory
    input clk, reset;

    reg branch_taken_ID;
    reg [0:31] branch_addr_ID;

    // 6-bit opcode definition
    parameter  R_TYPE_ALU  = 6'b101010, // R-type ALU operations
               R_TYPE_BEZ  = 6'b100010, // branch equal zero
               R_TYPE_BNEZ = 6'b100011, // branch not equal zero
               R_TYPE_NOP  = 6'b111100, // NOP
               M_TYPE_LD   = 6'b100000, // load
               M_TYPE_SD   = 6'b100001, // store
			   // ENHANCEMENT1 - checks Stuck-at-0s at ALU_output
			   R_TYPE_TEST = 6'b110011;	// test instruction

    // selective execution mode
    parameter  ppp_a_mode = 3'b000,
               ppp_u_mode = 3'b001,
               ppp_d_mode = 3'b010,
               ppp_e_mode = 3'b011,
               ppp_o_mode = 3'b100;

//**********************************************//
// 	   				IF stage					//
//**********************************************//

    reg [0:31] prog_counter; // program counter
    reg [0:31] IF_ID_reg; 	 // IF and ID stage register
	reg flush_flag;			 // Used to flush the instruction if branch is taken
							 // we flush by replacing the fetched instruction by
							 // VNOP in the ID stage

    always @(posedge clk) begin
        if(reset) 					prog_counter <= 0;
        else begin
        	if(branch_taken_ID) 	prog_counter <= branch_addr_ID;
         	else 					prog_counter <= prog_counter + 4;
		end
    end

    assign prog_counter_out = prog_counter;

    reg  [0:5] opcode_ID;

    // IF/ID stage register
    always @(posedge clk) begin
        if(reset) begin
			IF_ID_reg <= 0;
			flush_flag <= 0;
		end
        else begin
			IF_ID_reg <= inst_from_imem;
			if (((opcode_ID == R_TYPE_BEZ) || (opcode_ID == R_TYPE_BNEZ)) && branch_taken_ID)
				flush_flag <= 1;
			else
				flush_flag <= 0;
		end
    end


//**********************************************//
// 	   				ID stage					//
//**********************************************//

    wire [0:4] rd_ID, ra_ID, rb_ID;
    wire [0:2] ppp_ID;
    wire [0:1] ww_ID;
    wire [0:5] func_code_ID; 	// function code
    wire [0:15] immed_addr_ID;  // immediate address

    //nic control signals
    wire nic_enb;

	// Injecting NOP instuction if we set the flag to flush
	always @* begin
		if (flush_flag)	opcode_ID = R_TYPE_NOP;
		else			opcode_ID = IF_ID_reg[0:5];
	end

    assign rd_ID  = IF_ID_reg[6 :10];
    assign ra_ID  = IF_ID_reg[11:15];
    assign rb_ID  = IF_ID_reg[16:20];
    assign ppp_ID = (opcode_ID == M_TYPE_LD) ? 3'b000 : IF_ID_reg[21:23];
    assign ww_ID  = IF_ID_reg[24:25];
    assign func_code_ID  = IF_ID_reg[26:31];
    assign immed_addr_ID = IF_ID_reg[16:31];

	//Assign statements for NIC control
	assign nic_enb = IF_ID_reg[16] & IF_ID_reg[17];

    reg [0:4] RF_read_addr0, RF_read_addr1;
    wire [0:63] RF_read_dataout0, RF_read_dataout1;

    wire RF_WrEn_WB;
    wire [0:2] ppp_WB;
    wire [0:4] RF_write_addr_WB;
    wire [0:63] RF_write_datain_WB;

    //******* Register File *********//
    register_file Register_File
    (
        .clk(clk),
        .reset(reset),

        .write_enb(RF_WrEn_WB),
        .data_in(RF_write_datain_WB),
        .pppsel(ppp_WB),
        .addr_wr(RF_write_addr_WB),

        .addr_rd_0(RF_read_addr0),
        .addr_rd_1(RF_read_addr1),
        .data_out_0(RF_read_dataout0),
        .data_out_1(RF_read_dataout1)
    );


    //******* Control unit *********//
    reg dmem_En_ID, dmem_WriteEn_ID, RF_WriteEn_ID;
	reg nicEn_ID, nicWrEn_ID;


    always @* begin
        dmem_En_ID 		= 0;
        dmem_WriteEn_ID = 0;
        RF_WriteEn_ID 	= 0;
	    nicEn_ID			= 0;
	    nicWrEn_ID			= 0;
        case(opcode_ID)
            R_TYPE_ALU :
                RF_WriteEn_ID = 1;
            M_TYPE_LD :
            begin
	            if(nic_enb) begin
		            nicEn_ID=1;
		            nicWrEn_ID=0;
		            RF_WriteEn_ID = 1;
	            end else begin
                	RF_WriteEn_ID = 1;
                	dmem_En_ID = 1;
		        end
            end
            M_TYPE_SD :
            begin
            	if (nic_enb) begin
	            	nicEn_ID=1;
	            	nicWrEn_ID=1;
            	end else begin
            		dmem_En_ID   = 1;
            		dmem_WriteEn_ID = 1;
            	end
            end
            R_TYPE_TEST:
                RF_WriteEn_ID = 1;
        endcase
    end

    always @* begin
        RF_read_addr1 = rb_ID;

		// if VSD or Branches, we have rd as source
        if((opcode_ID == M_TYPE_SD) || (opcode_ID == R_TYPE_BEZ) || (opcode_ID == R_TYPE_BNEZ))
            RF_read_addr0 = rd_ID;
        else
            RF_read_addr0 = ra_ID;
    end


    //******* Hazard Detection Unit (HDU) *********//
    // compare rD of senior with sources of junior in ID stage
    reg hazard_det_ra_ID, hazard_det_rb_ID;
    wire RF_WriteEn_EXM;
    wire [0:4] rd_EXM;
    always @* begin
        hazard_det_ra_ID = 0;
        hazard_det_rb_ID = 0;
        if((RF_WriteEn_EXM == 1) && (rd_EXM != 0)) begin
            if(rd_EXM == RF_read_addr0)		hazard_det_ra_ID = 1;
            if(rd_EXM == RF_read_addr1)		hazard_det_rb_ID = 1;
        end
    end


	//******* Forwarding MUX logic *********//
    reg [0:63] RF_read_dataout0_mux, RF_read_dataout1_mux;
    reg [0:63] RF_wr_datain_EXM;
    wire [0:2] ppp_EXM;
    always @* begin
        RF_read_dataout0_mux = RF_read_dataout0;
        RF_read_dataout1_mux = RF_read_dataout1;

		// Based on the PPP value of the senior,
		// we forward only those many bits that are getting written
        if(hazard_det_ra_ID == 1)
            case(ppp_EXM)
                ppp_a_mode :
                    RF_read_dataout0_mux[0:63] = RF_wr_datain_EXM[0:63];
                ppp_u_mode :
                    RF_read_dataout0_mux[0:31] = RF_wr_datain_EXM[0:31];
                ppp_d_mode :
                    RF_read_dataout0_mux[32:63] = RF_wr_datain_EXM[32:63];
                ppp_e_mode :
                begin
                    RF_read_dataout0_mux[0:7]   = RF_wr_datain_EXM[0:7];
                    RF_read_dataout0_mux[16:23] = RF_wr_datain_EXM[16:23];
                    RF_read_dataout0_mux[32:39] = RF_wr_datain_EXM[32:39];
                    RF_read_dataout0_mux[48:55] = RF_wr_datain_EXM[48:55];
                end
                ppp_o_mode :
                begin
                    RF_read_dataout0_mux[8:15]  = RF_wr_datain_EXM[8:15];
                    RF_read_dataout0_mux[24:31] = RF_wr_datain_EXM[24:31];
                    RF_read_dataout0_mux[40:47] = RF_wr_datain_EXM[40:47];
                    RF_read_dataout0_mux[56:63] = RF_wr_datain_EXM[56:63];
                end
            endcase

        if(hazard_det_rb_ID == 1)
            case(ppp_EXM)
                ppp_a_mode :
                    RF_read_dataout1_mux[0:63] = RF_wr_datain_EXM[0:63];
                ppp_u_mode :
                    RF_read_dataout1_mux[0:31] = RF_wr_datain_EXM[0:31];
                ppp_d_mode :
                    RF_read_dataout1_mux[32:63] = RF_wr_datain_EXM[32:63];
                ppp_e_mode :
                begin
                    RF_read_dataout1_mux[0:7]   = RF_wr_datain_EXM[0:7];
                    RF_read_dataout1_mux[16:23] = RF_wr_datain_EXM[16:23];
                    RF_read_dataout1_mux[32:39] = RF_wr_datain_EXM[32:39];
                    RF_read_dataout1_mux[48:55] = RF_wr_datain_EXM[48:55];
                end
                ppp_o_mode :
                begin
                    RF_read_dataout1_mux[8:15]  = RF_wr_datain_EXM[8:15];
                    RF_read_dataout1_mux[24:31] = RF_wr_datain_EXM[24:31];
                    RF_read_dataout1_mux[40:47] = RF_wr_datain_EXM[40:47];
                    RF_read_dataout1_mux[56:63] = RF_wr_datain_EXM[56:63];
                end
            endcase
    end


    // branch_taken_ID and branch_addr_ID
    always @* begin
        branch_taken_ID = 0;
        branch_addr_ID = {16'b0, immed_addr_ID};	// PC = 32, thus 32bit branch addr

        if((opcode_ID == R_TYPE_BEZ)  && (RF_read_dataout0_mux == 0))
            branch_taken_ID = 1;

        if((opcode_ID == R_TYPE_BNEZ) && (RF_read_dataout0_mux != 0))
            branch_taken_ID = 1;
    end


	// Dmem related signals
    assign dmem_En 		= dmem_En_ID;
    assign dmem_WrEn 	= dmem_WriteEn_ID;
    assign addr_to_dmem = {16'b0, immed_addr_ID};
    assign data_to_dmem = RF_read_dataout0_mux;
    assign nic_d_in		= RF_read_dataout0_mux;

    // ID/EX_MEM stage register
    reg [0:147] ID_EXM_reg;

    always @(posedge clk) begin
        if(reset)	  ID_EXM_reg <= 0;
        else begin
        	ID_EXM_reg[0  :  63] <= RF_read_dataout0_mux;
        	ID_EXM_reg[64 : 127] <= RF_read_dataout1_mux;
        	ID_EXM_reg[128: 132] <= rd_ID;
        	ID_EXM_reg[133: 135] <= ppp_ID;
        	ID_EXM_reg[136: 137] <= ww_ID;
        	ID_EXM_reg[138: 143] <= func_code_ID;
        	ID_EXM_reg[144: 145] <= {dmem_En_ID, RF_WriteEn_ID};
	        ID_EXM_reg[146: 147] <= {nicEn_ID,nicWrEn_ID};
        end
    end

//**********************************************//
// 	   			EX_MEM stage					//
//**********************************************//

    wire dmem_En_EXM;
    wire [0:5] func_code_EXM;
    wire [0:1] ww_EXM;
    wire nicEn_EXM;
    wire nicWrEn_EXM;

    assign rd_EXM = ID_EXM_reg[128:132];
    assign ppp_EXM = ID_EXM_reg[133:135];
    assign ww_EXM = ID_EXM_reg[136:137];
    assign func_code_EXM = ID_EXM_reg[138:143];
    assign {dmem_En_EXM, RF_WriteEn_EXM} = ID_EXM_reg[144:145];
    assign {nicEn_EXM,nicWrEn_EXM} = ID_EXM_reg[146: 147];


    //Data from NIC is loaded or stored in EX Stage
    assign nicEn 	= nicEn_EXM;
    assign nicWrEn 	= nicWrEn_EXM;

    // Instantiation of ALU
    wire [0:63] ALU_datain_A, ALU_datain_B, ALU_out_EXM;
	// Pulling this ALU_cout for detecting overflow
	wire ALU_cout;
    assign {ALU_datain_A, ALU_datain_B} = ID_EXM_reg[0:127];
    alu ALU_Instance
    (
        .dataout(ALU_out_EXM),
        .datain_A(ALU_datain_A),
        .datain_B(ALU_datain_B),
        .f_code(func_code_EXM),
        .subfield_selection(ww_EXM),
		.c_out_msb(ALU_cout)
    );


    // Either ALU Result or Load Memory
    always @* begin
        RF_wr_datain_EXM = ALU_out_EXM;
	    if(nicEn_EXM)	RF_wr_datain_EXM = nic_d_out;
        if(dmem_En_EXM == 1)	RF_wr_datain_EXM = data_from_dmem[0:63];
    end


    // EX_MEM/WB stage register
    reg [0:72] EXM_WB_reg;
    always @(posedge clk) begin
        if(reset)	EXM_WB_reg <= 0;
        else begin
        	EXM_WB_reg[0 :63]  <= RF_wr_datain_EXM[0:63];
        	EXM_WB_reg[   64]  <= RF_WriteEn_EXM;
        	EXM_WB_reg[65:67]  <= ppp_EXM;
        	EXM_WB_reg[68:72]  <= rd_EXM;
        end
    end
	reg overflow_reg;
    localparam  VADD = 6'b000110;
	//** Unsigned Addition Overflow Detection Logic ***//
	always @ (posedge clk) begin
		if (reset)	overflow_reg <= 1'b0;
		if ((func_code_EXM == VADD) && (ALU_cout))
			overflow_reg <= 1'b1;
		else
			overflow_reg <= 1'b0;
	end
//**********************************************//
// 	   				WB stage					//
//**********************************************//

    assign RF_WrEn_WB = EXM_WB_reg[64];
    assign RF_write_addr_WB = EXM_WB_reg[68:72];
    assign ppp_WB = EXM_WB_reg[65:67];
    assign RF_write_datain_WB = EXM_WB_reg[0:63];

endmodule
