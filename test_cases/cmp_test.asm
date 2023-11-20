F0000000  // NOP  // Program for single packet read and write from processor       
81400000  // load datamem[0] into R10    			//load packet to be sent out in register file
81600001  // load datamem[1] into R11    			//load packet to be sent out in register file
81800002  // load datamem[2] into R12   			//load packet to be sent out in register file
81B00003  // load datamem[3] into R13   			//load packet to be sent out in register file
81C00004  // load datamem[4] into R14   			//load packet to be sent out in register file
81E00005  // load datamem[5] into R15   			//load packet to be sent out in register file
82000006  // load datamem[6] into R16   			//load packet to be sent out in register file	
82200007  // load datamem[7] into R17   			//load packet to be sent out in register file
82400008  // load datamem[8] into R18   			//load packet to be sent out in register file
82600009  // load datamem[9] into R19   			//load packet to be sent out in register file
8280000A  // load datamem[10] into R20   			//load packet to be sent out in register file
82A0000B  // load datamem[11] into R21   			//load packet to be sent out in register file
82C0000C  // load datamem[12] into R22   			//load packet to be sent out in register file
82E0000D  // load datamem[13] into R23   			//load packet to be sent out in register file
8300000E  // load datamem[14] into R24   			//load packet to be sent out in register file __to all 15
8020C003  // load NIC[3] into R1  					//read the output channel status register -- output channel: CPU->NIC
8C200010  // VBNEZ r1, 4                    //if full, read again until empty
8540C002  // store r10 into NIC[2]					//send packet out to NIC
8020C003  // load NIC[3] into r1  					//read the output channel status register
8C20001c  // VBNEZ r1, 7                    //if full, read again until empty
8560C002  // store r11 into NIC[2]					//send packet out to NIC
8020C003  // load NIC[3] into r1  					//read the output channel status register
8C200028  // VBNEZ R1, 10                   //if full, read again until empty
8580C002  // store R12 into NIC[2]				//send packet out to NIC
8020C003  // load NIC[3] into R1  					//read the output channel status register -- output channel: CPU->NIC
8C200010  // VBNEZ r1, 4                    //if full, read again until empty
85A0C002  // store r13 into NIC[2]					//send packet out to NIC
8020C003  // load NIC[3] into R1  					//read the output channel status register -- output channel: CPU->NIC
8C200010  // VBNEZ r1, 4                    //if full, read again until empty
85C0C002  // store r14 into NIC[2]					//send packet out to NIC
8020C003  // load NIC[3] into R1  					//read the output channel status register -- output channel: CPU->NIC
8C200010  // VBNEZ r1, 4                    //if full, read again until empty
85E0C002  // store r15 into NIC[2]					//send packet out to NIC
8020C003  // load NIC[3] into R1  					//read the output channel status register -- output channel: CPU->NIC
8C200010  // VBNEZ r1, 4                    //if full, read again until empty
8600C002  // store r16 into NIC[2]					//send packet out to NIC
8020C003  // load NIC[3] into R1  					//read the output channel status register -- output channel: CPU->NIC
8C200010  // VBNEZ r1, 4                    //if full, read again until empty
8620C002  // store r17 into NIC[2]					//send packet out to NIC
8020C003  // load NIC[3] into R1  					//read the output channel status register -- output channel: CPU->NIC
8C200010  // VBNEZ r1, 4                    //if full, read again until empty
8640C002  // store r18 into NIC[2]					//send packet out to NIC
8020C003  // load NIC[3] into R1  					//read the output channel status register -- output channel: CPU->NIC
8C200010  // VBNEZ r1, 4                    //if full, read again until empty
8660C002  // store r19 into NIC[2]					//send packet out to NIC
8020C003  // load NIC[3] into R1  					//read the output channel status register -- output channel: CPU->NIC
8C200010  // VBNEZ r1, 4                    //if full, read again until empty
8680C002  // store r20 into NIC[2]					//send packet out to NIC
8020C003  // load NIC[3] into R1  					//read the output channel status register -- output channel: CPU->NIC
8C200010  // VBNEZ r1, 4                    //if full, read again until empty
86A0C002  // store r21 into NIC[2]					//send packet out to NIC
8020C003  // load NIC[3] into R1  					//read the output channel status register -- output channel: CPU->NIC
8C200010  // VBNEZ r1, 4                    //if full, read again until empty
86C0C002  // store r22 into NIC[2]					//send packet out to NIC
8020C003  // load NIC[3] into R1  					//read the output channel status register -- output channel: CPU->NIC
8C200010  // VBNEZ r1, 4                    //if full, read again until empty
86E0C002  // store r23 into NIC[2]					//send packet out to NIC
8020C003  // load NIC[3] into R1  					//read the output channel status register -- output channel: CPU->NIC
8C200010  // VBNEZ r1, 4                    //if full, read again until empty
8700C002  // store r24 into NIC[2]					//send packet out to NIC
8040C001  // load NIC[1] into R2					//read the input channel status register
88400034  // VBEZ R2, 13                  //if empty, read again
8060C000  // store NIC[0] into R3	// LW
8040C001  // load NIC[1] into R2					//read the input channel status register
88400040  // VBEZ R2, 16
8080C000  // store NIC[0] into R4	// LW
8040C001  // load NIC[1] into R2					//read the input channel status register
8840004C  // VBEZ R2, 19
80A0C000  // store NIC[0] into R5
8040C001  // load NIC[1] into R2					//read the input channel status register
8840004C  // VBEZ R2, 19
80C0C000  // store NIC[0] into R6
8040C001  // load NIC[1] into R2					//read the input channel status register
8840004C  // VBEZ R2, 19
80E0C000  // store NIC[0] into R7
8040C001  // load NIC[1] into R2					//read the input channel status register
8840004C  // VBEZ R2, 19
8100C000  // store NIC[0] into R8
8040C001  // load NIC[1] into R2					//read the input channel status register
8840004C  // VBEZ R2, 19
8120C000  // store NIC[0] into R9
8040C001  // load NIC[1] into R2					//read the input channel status register
8840004C  // VBEZ R2, 19
8140C000  // store NIC[0] into R10
8040C001  // load NIC[1] into R2					//read the input channel status register
8840004C  // VBEZ R2, 19
8160C000  // store NIC[0] into R11
8040C001  // load NIC[1] into R2					//read the input channel status register
8840004C  // VBEZ R2, 19
8180C000  // store NIC[0] into R12
8040C001  // load NIC[1] into R2					//read the input channel status register
8840004C  // VBEZ R2, 19
81A0C000  // store NIC[0] into R13
8040C001  // load NIC[1] into R2					//read the input channel status register
8840004C  // VBEZ R2, 19
81C0C000  // store NIC[0] into R14
8040C001  // load NIC[1] into R2					//read the input channel status register
8840004C  // VBEZ R2, 19
81E0C000  // store NIC[0] into R15
8040C001  // load NIC[1] into R2					//read the input channel status register
8840004C  // VBEZ R2, 19
8200C000  // store NIC[0] into R16
8040C001  // load NIC[1] into R2					//read the input channel status register
8840004C  // VBEZ R2, 19
8220C000  // store NIC[0] into R17
8460000F  // VSD R3, 15                    //write R3 to datamem[15], data=mem[0]
84800010  // VSD R4, 16                    //write R4 to datamem[16], data=mem[0]
84A00020  // VSD R5, 17                    //write R5 to datamem[17], data=mem[0]
84C00030  // VSD R6, 18                    //write R6 to datamem[17], data=mem[0]
84E00040  // VSD R7, 19                    //write R7 to datamem[17], data=mem[0]
85000050  // VSD R8, 20                    //write R8 to datamem[17], data=mem[0]
85200060  // VSD R9, 21                    //write R5 to datamem[17], data=mem[0]
85400070  // VSD R10, 22                   //write R5 to datamem[17], data=mem[0]
85600080  // VSD R11, 23                   //write R5 to datamem[17], data=mem[0]
85800090  // VSD R12, 24                   //write R5 to datamem[17], data=mem[0]
85A000A0  // VSD R13, 25                   //write R5 to datamem[17], data=mem[0]
85C000B0  // VSD R14, 26                   //write R5 to datamem[17], data=mem[0]
85E000C0  // VSD R15, 27                   //write R5 to datamem[17], data=mem[0]
860000D0  // VSD R16, 28                   //write R5 to datamem[17], data=mem[0]
862000E0  // VSD R17, 29                   //write R5 to datamem[17], data=mem[0]
00000000  // NOP End Program 
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000