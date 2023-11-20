
# NC-Sim Command File
# TOOL:	ncsim(64)	15.20-s079
#
#
# You can restore this configuration with:
#
#      ncsim -64BIT -STATUS -NOCOPYRIGHT -MESSAGES -NCFATAL INVSUP -NOWARN DLBRLK -TCL -NOLOG -NOKEY work.tb_cmp_basic_check -input /home/viterbi/09/patilss/EE577B/Project/Phase3/basiccheck.tcl
#

set tcl_prompt1 {puts -nonewline "ncsim> "}
set tcl_prompt2 {puts -nonewline "> "}
set vlog_format %h
set vhdl_format %v
set real_precision 6
set display_unit auto
set time_unit module
set heap_garbage_size -200
set heap_garbage_time 0
set assert_report_level note
set assert_stop_level error
set autoscope yes
set assert_1164_warnings yes
set pack_assert_off {}
set severity_pack_assert_off {note warning}
set assert_output_stop_level failed
set tcl_debug_level 0
set relax_path_name 1
set vhdl_vcdmap XX01ZX01X
set intovf_severity_level ERROR
set probe_screen_format 0
set rangecnst_severity_level ERROR
set textio_severity_level ERROR
set vital_timing_checks_on 1
set vlog_code_show_force 0
set assert_count_attempts 1
set tcl_all64 false
set tcl_runerror_exit false
set assert_report_incompletes 0
set show_force 1
set force_reset_by_reinvoke 0
set tcl_relaxed_literal 0
set probe_exclude_patterns {}
set probe_packed_limit 4k
set probe_unpacked_limit 16k
set assert_internal_msg no
set svseed 1
set assert_reporting_mode 0
alias iprof profile
database -open -shm -into waves.shm waves -default
probe -create -database waves tb_cmp_basic_check.CMP.cpu0.prog_counter tb_cmp_basic_check.CMP.cpu0.clk tb_cmp_basic_check.CMP.cpu0.inst_from_imem tb_cmp_basic_check.CMP.cpu0.data_from_dmem tb_cmp_basic_check.CMP.cpu0.nicEn tb_cmp_basic_check.CMP.cpu0.nicWrEn tb_cmp_basic_check.CMP.cpu0.nic_d_out tb_cmp_basic_check.CMP.cpu0.RF_wr_datain_EXM tb_cmp_basic_check.CMP.m1.nic00.inp_buffer tb_cmp_basic_check.CMP.cpu0.nic_d_in tb_cmp_basic_check.CMP.m1.nic00.addr tb_cmp_basic_check.CMP.m1.nic00.clk tb_cmp_basic_check.CMP.m1.nic00.d_in tb_cmp_basic_check.CMP.m1.nic00.d_out tb_cmp_basic_check.CMP.m1.nic00.net_do tb_cmp_basic_check.CMP.m1.nic00.net_do_rev tb_cmp_basic_check.CMP.m1.nic00.net_polarity tb_cmp_basic_check.CMP.m1.nic00.net_ri tb_cmp_basic_check.CMP.m1.nic00.net_ro tb_cmp_basic_check.CMP.m1.nic00.net_si tb_cmp_basic_check.CMP.m1.nic00.net_so tb_cmp_basic_check.CMP.m1.nic00.nicEn tb_cmp_basic_check.CMP.m1.nic00.nicEnWr tb_cmp_basic_check.CMP.m1.nic00.out_buffer tb_cmp_basic_check.CMP.m1.nic00.out_sts tb_cmp_basic_check.CMP.m1.nic00.reset tb_cmp_basic_check.CMP.cpu0.RF_read_dataout0 tb_cmp_basic_check.CMP.cpu0.RF_read_dataout0_mux tb_cmp_basic_check.CMP.m1.r00.ipbuf_even_pe.buf_in tb_cmp_basic_check.CMP.m1.r00.ipbuf_even_pe.buf_out tb_cmp_basic_check.CMP.m1.r01.reqgen_west.req_east tb_cmp_basic_check.CMP.m1.r00.ipbuf_even_pe.clk tb_cmp_basic_check.CMP.m1.r00.ipbuf_even_pe.flag tb_cmp_basic_check.CMP.m1.r00.ipbuf_even_pe.isfull tb_cmp_basic_check.CMP.m1.r00.ipbuf_even_pe.reset tb_cmp_basic_check.CMP.m1.r00.ipbuf_even_pe.write_en tb_cmp_basic_check.CMP.m1.r00.dataout_east tb_cmp_basic_check.CMP.m1.r01.dataout_peout tb_cmp_basic_check.CMP.m1.r01.reqgen_west.req_peout tb_cmp_basic_check.CMP.m1.nic01.net_di tb_cmp_basic_check.CMP.m1.nic01.inp_sts tb_cmp_basic_check.CMP.m1.nic01.inp_buffer tb_cmp_basic_check.CMP.m1.nic01.d_out tb_cmp_basic_check.CMP.cpu1.RF_wr_datain_EXM tb_cmp_basic_check.CMP.cpu1.nic_d_out tb_cmp_basic_check.CMP.cpu1.nicEn tb_cmp_basic_check.CMP.cpu1.RF_write_datain_WB
probe -create -database waves tb_cmp_basic_check.CMP.cpu1.Register_File.mem

simvision -input basiccheck.tcl.svcf
