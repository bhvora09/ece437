onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/DUT/CLK
add wave -noupdate -divider Core0
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/CLK
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/nRST
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/SignExt_addr
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/ZeroExt_addr
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/Ext_addr
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/npc
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/shift_left_1
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/extended_address
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/rd
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/halt
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/deif_flush
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/opinfetch
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/opindecode
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/opinexec
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/opinmem
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/opinwrback
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/aluopinfetch
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/aluopindecode
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/aluopinexec
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/aluopinmem
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/aluopinwrback
add wave -noupdate -group fdif0 /system_tb/DUT/CPU/DP0/fdif/instr_in
add wave -noupdate -group fdif0 /system_tb/DUT/CPU/DP0/fdif/pc_in
add wave -noupdate -group fdif0 /system_tb/DUT/CPU/DP0/fdif/pcplusfour_in
add wave -noupdate -group fdif0 /system_tb/DUT/CPU/DP0/fdif/ihit
add wave -noupdate -group fdif0 /system_tb/DUT/CPU/DP0/fdif/dhit
add wave -noupdate -group fdif0 /system_tb/DUT/CPU/DP0/fdif/stall
add wave -noupdate -group fdif0 /system_tb/DUT/CPU/DP0/fdif/instr_out
add wave -noupdate -group fdif0 /system_tb/DUT/CPU/DP0/fdif/pc_out
add wave -noupdate -group fdif0 /system_tb/DUT/CPU/DP0/fdif/pcplusfour_out
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/instr_in
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/Ext_addr_in
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/pcplusfour_in
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/rdat1_in
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/rdat2_in
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/pc_in
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/dWEN_in
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/dREN_in
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/bne_s_in
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/beq_s_in
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/jal_s_in
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/jr_s_in
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/jump_s_in
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/lui_in
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/RegDst_in
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/ALUSrc_in
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/RegWr_in
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/MemWr_in
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/MemtoReg_in
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/halt_in
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/imm_addr_in
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/reg_rs_in
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/reg_rt_in
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/reg_rd_in
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/shift_amt_in
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/j_addr_in
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/funct_in
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/opcode_in
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/ALUctr_in
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/instr_out
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/Ext_addr_out
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/pcplusfour_out
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/rdat1_out
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/rdat2_out
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/pc_out
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/dWEN_out
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/dREN_out
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/bne_s_out
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/beq_s_out
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/jal_s_out
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/jr_s_out
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/jump_s_out
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/lui_out
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/RegDst_out
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/ALUSrc_out
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/RegWr_out
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/MemWr_out
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/MemtoReg_out
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/halt_out
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/imm_addr_out
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/reg_rs_out
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/reg_rt_out
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/reg_rd_out
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/shift_amt_out
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/j_addr_out
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/funct_out
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/opcode_out
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/ALUctr_out
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/ihit
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/dhit
add wave -noupdate -group deif0 /system_tb/DUT/CPU/DP0/deif/stall
add wave -noupdate /system_tb/DUT/CPU/DP0/RF/regfile
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/dREN_in
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/dWEN_in
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/bne_s_in
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/beq_s_in
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/jal_s_in
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/flagZero_in
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/lui_in
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/MemtoReg_in
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/RegWr_in
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/jump_s_in
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/jr_s_in
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/ihit
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/dhit
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/MemWr_in
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/halt_in
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/stall
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/dREN_out
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/dREN
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/dWEN_out
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/dWEN
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/bne_s_out
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/beq_s_out
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/jal_s_out
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/flagZero_out
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/lui_out
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/MemtoReg_out
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/RegWr_out
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/jump_s_out
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/jr_s_out
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/MemWr_out
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/halt_out
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/pcplusfour_in
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/pc_in
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/rdat2_in
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/alu_portOut_in
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/instr_in
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/Ext_addr_in
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/rdat1_in
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/pcplusfour_out
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/pc_out
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/rdat2_out
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/alu_portOut_out
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/instr_out
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/Ext_addr_out
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/rdat1_out
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/imm_addr_in
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/imm_addr_out
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/j_addr_in
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/j_addr_out
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/wsel_in
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/shift_amt_in
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/reg_rs_in
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/reg_rt_in
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/reg_rd_in
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/wsel_out
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/shift_amt_out
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/reg_rs_out
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/reg_rt_out
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/reg_rd_out
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/opcode_in
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/opcode_out
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/funct_in
add wave -noupdate -group emif0 /system_tb/DUT/CPU/DP0/emif/funct_out
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/jal_s_in
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/lui_in
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/MemtoReg_in
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/RegWr_in
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/halt_in
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/ihit
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/dhit
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/stall
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/flush
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/jal_s_out
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/lui_out
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/MemtoReg_out
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/RegWr_out
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/halt_out
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/pcplusfour_in
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/pc_in
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/alu_portOut_in
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/instr_in
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/wdat_in
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/rdat2_in
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/pcplusfour_out
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/pc_out
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/instr_out
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/wdat_out
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/alu_portOut_out
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/rdat2_out
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/imm_addr_in
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/imm_addr_out
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/wsel_in
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/shift_amt_in
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/reg_rs_in
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/reg_rt_in
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/reg_rd_in
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/wsel_out
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/shift_amt_out
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/reg_rs_out
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/reg_rt_out
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/reg_rd_out
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/opcode_in
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/opcode_out
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/funct_in
add wave -noupdate -group mwif0 /system_tb/DUT/CPU/DP0/mwif/funct_out
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/iwait
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/dwait
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/iREN
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/dREN
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/dWEN
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/iload
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/dload
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/dstore
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/iaddr
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/daddr
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/ccwait
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/ccinv
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/ccwrite
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/cctrans
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/ccsnoopaddr
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/halt
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/ihit
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/imemREN
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/imemload
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/imemaddr
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/dhit
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/datomic
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/dmemREN
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/dmemWEN
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/flushed
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/dmemload
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/dmemstore
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/dmemaddr
add wave -noupdate -group icache0 /system_tb/DUT/CPU/CM0/ICACHE/CLK
add wave -noupdate -group icache0 /system_tb/DUT/CPU/CM0/ICACHE/nRST
add wave -noupdate -group icache0 /system_tb/DUT/CPU/CM0/ICACHE/hit
add wave -noupdate -group icache0 /system_tb/DUT/CPU/CM0/ICACHE/data
add wave -noupdate -group icache0 /system_tb/DUT/CPU/CM0/ICACHE/addr
add wave -noupdate -group icache0 /system_tb/DUT/CPU/CM0/ICACHE/frames
add wave -noupdate -group icache0 /system_tb/DUT/CPU/CM0/ICACHE/n_frames
add wave -noupdate -group icache0 /system_tb/DUT/CPU/CM0/ICACHE/frame
add wave -noupdate -group icache0 /system_tb/DUT/CPU/CM0/ICACHE/valid
add wave -noupdate -group icache0 /system_tb/DUT/CPU/CM0/ICACHE/iwait
add wave -noupdate -group icache0 /system_tb/DUT/CPU/CM0/ICACHE/s
add wave -noupdate -group icache0 /system_tb/DUT/CPU/CM0/ICACHE/nS
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/CLK
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/nRST
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/table1
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/temptable1
add wave -noupdate -group dcache0 -expand /system_tb/DUT/CPU/CM0/DCACHE/table2
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/temptable2
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/LRU
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/nLRU
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/dload1
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/dload2
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/dstore10
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/dstore11
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/dstore20
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/dstore21
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/tag1
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/tag2
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/index
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/a
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/b
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/i
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/ni
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/ndaddr
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/trans
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/write
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/state
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_state
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/daddr
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/saddr
add wave -noupdate -divider Core1
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/CLK
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/nRST
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/SignExt_addr
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/ZeroExt_addr
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/Ext_addr
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/npc
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/shift_left_1
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/extended_address
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/rd
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/halt
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/deif_flush
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/opinfetch
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/opindecode
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/opinexec
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/opinmem
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/opinwrback
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/aluopinfetch
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/aluopindecode
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/aluopinexec
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/aluopinmem
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/aluopinwrback
add wave -noupdate -group fdif1 /system_tb/DUT/CPU/DP1/fdif/instr_in
add wave -noupdate -group fdif1 /system_tb/DUT/CPU/DP1/fdif/pc_in
add wave -noupdate -group fdif1 /system_tb/DUT/CPU/DP1/fdif/pcplusfour_in
add wave -noupdate -group fdif1 /system_tb/DUT/CPU/DP1/fdif/ihit
add wave -noupdate -group fdif1 /system_tb/DUT/CPU/DP1/fdif/dhit
add wave -noupdate -group fdif1 /system_tb/DUT/CPU/DP1/fdif/stall
add wave -noupdate -group fdif1 /system_tb/DUT/CPU/DP1/fdif/instr_out
add wave -noupdate -group fdif1 /system_tb/DUT/CPU/DP1/fdif/pc_out
add wave -noupdate -group fdif1 /system_tb/DUT/CPU/DP1/fdif/pcplusfour_out
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/instr_in
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/Ext_addr_in
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/pcplusfour_in
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/rdat1_in
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/rdat2_in
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/pc_in
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/dWEN_in
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/dREN_in
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/bne_s_in
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/beq_s_in
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/jal_s_in
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/jr_s_in
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/jump_s_in
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/lui_in
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/RegDst_in
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/ALUSrc_in
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/RegWr_in
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/MemWr_in
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/MemtoReg_in
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/halt_in
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/imm_addr_in
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/reg_rs_in
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/reg_rt_in
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/reg_rd_in
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/shift_amt_in
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/j_addr_in
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/funct_in
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/opcode_in
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/ALUctr_in
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/instr_out
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/Ext_addr_out
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/pcplusfour_out
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/rdat1_out
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/rdat2_out
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/pc_out
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/dWEN_out
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/dREN_out
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/bne_s_out
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/beq_s_out
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/jal_s_out
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/jr_s_out
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/jump_s_out
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/lui_out
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/RegDst_out
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/ALUSrc_out
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/RegWr_out
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/MemWr_out
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/MemtoReg_out
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/halt_out
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/imm_addr_out
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/reg_rs_out
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/reg_rt_out
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/reg_rd_out
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/shift_amt_out
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/j_addr_out
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/funct_out
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/opcode_out
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/ALUctr_out
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/ihit
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/dhit
add wave -noupdate -group deif1 /system_tb/DUT/CPU/DP1/deif/stall
add wave -noupdate /system_tb/DUT/CPU/DP1/RF/regfile
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/dREN_in
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/dWEN_in
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/bne_s_in
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/beq_s_in
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/jal_s_in
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/flagZero_in
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/lui_in
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/MemtoReg_in
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/RegWr_in
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/jump_s_in
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/jr_s_in
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/ihit
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/dhit
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/MemWr_in
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/halt_in
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/stall
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/dREN_out
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/dREN
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/dWEN_out
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/dWEN
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/bne_s_out
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/beq_s_out
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/jal_s_out
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/flagZero_out
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/lui_out
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/MemtoReg_out
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/RegWr_out
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/jump_s_out
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/jr_s_out
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/MemWr_out
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/halt_out
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/pcplusfour_in
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/pc_in
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/rdat2_in
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/alu_portOut_in
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/instr_in
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/Ext_addr_in
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/rdat1_in
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/pcplusfour_out
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/pc_out
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/rdat2_out
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/alu_portOut_out
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/instr_out
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/Ext_addr_out
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/rdat1_out
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/imm_addr_in
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/imm_addr_out
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/j_addr_in
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/j_addr_out
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/wsel_in
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/shift_amt_in
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/reg_rs_in
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/reg_rt_in
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/reg_rd_in
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/wsel_out
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/shift_amt_out
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/reg_rs_out
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/reg_rt_out
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/reg_rd_out
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/opcode_in
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/opcode_out
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/funct_in
add wave -noupdate -group emif1 /system_tb/DUT/CPU/DP1/emif/funct_out
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/jal_s_in
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/lui_in
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/MemtoReg_in
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/RegWr_in
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/halt_in
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/ihit
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/dhit
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/stall
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/flush
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/jal_s_out
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/lui_out
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/MemtoReg_out
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/RegWr_out
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/halt_out
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/pcplusfour_in
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/pc_in
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/alu_portOut_in
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/instr_in
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/wdat_in
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/rdat2_in
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/pcplusfour_out
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/pc_out
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/instr_out
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/wdat_out
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/alu_portOut_out
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/rdat2_out
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/imm_addr_in
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/imm_addr_out
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/wsel_in
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/shift_amt_in
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/reg_rs_in
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/reg_rt_in
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/reg_rd_in
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/wsel_out
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/shift_amt_out
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/reg_rs_out
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/reg_rt_out
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/reg_rd_out
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/opcode_in
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/opcode_out
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/funct_in
add wave -noupdate -group mwif1 /system_tb/DUT/CPU/DP1/mwif/funct_out
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/iwait
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/dwait
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/iREN
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/dREN
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/dWEN
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/iload
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/dload
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/dstore
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/iaddr
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/daddr
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/ccwait
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/ccinv
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/ccwrite
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/cctrans
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/ccsnoopaddr
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/halt
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/ihit
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/imemREN
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/imemload
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/imemaddr
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dhit
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/datomic
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dmemREN
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dmemWEN
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/flushed
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dmemload
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dmemstore
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dmemaddr
add wave -noupdate -group icache1 /system_tb/DUT/CPU/CM1/ICACHE/CLK
add wave -noupdate -group icache1 /system_tb/DUT/CPU/CM1/ICACHE/nRST
add wave -noupdate -group icache1 /system_tb/DUT/CPU/CM1/ICACHE/hit
add wave -noupdate -group icache1 /system_tb/DUT/CPU/CM1/ICACHE/data
add wave -noupdate -group icache1 /system_tb/DUT/CPU/CM1/ICACHE/addr
add wave -noupdate -group icache1 /system_tb/DUT/CPU/CM1/ICACHE/frames
add wave -noupdate -group icache1 -expand /system_tb/DUT/CPU/CM1/ICACHE/n_frames
add wave -noupdate -group icache1 -expand /system_tb/DUT/CPU/CM1/ICACHE/frame
add wave -noupdate -group icache1 /system_tb/DUT/CPU/CM1/ICACHE/valid
add wave -noupdate -group icache1 /system_tb/DUT/CPU/CM1/ICACHE/iwait
add wave -noupdate -group icache1 /system_tb/DUT/CPU/CM1/ICACHE/s
add wave -noupdate -group icache1 /system_tb/DUT/CPU/CM1/ICACHE/nS
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/CLK
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/nRST
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/table1
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/temptable1
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/table2
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/temptable2
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/LRU
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/nLRU
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/dload1
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/dload2
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/dstore10
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/dstore11
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/dstore20
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/dstore21
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/tag1
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/tag2
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/index
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/a
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/b
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/i
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/ni
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/ndaddr
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/trans
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/write
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/state
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_state
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/daddr
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/saddr
add wave -noupdate -divider {Bus and Ram}
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/iwait
add wave -noupdate -expand -group ccif -expand /system_tb/DUT/CPU/ccif/dwait
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/iREN
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/dREN
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/dWEN
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/iload
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/dload
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/dstore
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/iaddr
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/daddr
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ccwait
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ccinv
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ccwrite
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/cctrans
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ccsnoopaddr
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ramWEN
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ramREN
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ramstate
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ramaddr
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ramstore
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ramload
add wave -noupdate -expand -group {Bus controller} /system_tb/DUT/CPU/CC/CLK
add wave -noupdate -expand -group {Bus controller} /system_tb/DUT/CPU/CC/nRST
add wave -noupdate -expand -group {Bus controller} /system_tb/DUT/CPU/CC/s
add wave -noupdate -expand -group {Bus controller} /system_tb/DUT/CPU/CC/nS
add wave -noupdate -expand -group {Bus controller} /system_tb/DUT/CPU/CC/trans0
add wave -noupdate -expand -group {Bus controller} /system_tb/DUT/CPU/CC/trans_from0
add wave -noupdate -expand -group {Bus controller} /system_tb/DUT/CPU/CC/trans1
add wave -noupdate -expand -group {Bus controller} /system_tb/DUT/CPU/CC/trans_from1
add wave -noupdate -expand -group {Bus controller} /system_tb/DUT/CPU/CC/write0
add wave -noupdate -expand -group {Bus controller} /system_tb/DUT/CPU/CC/write_from0
add wave -noupdate -expand -group {Bus controller} /system_tb/DUT/CPU/CC/write1
add wave -noupdate -expand -group {Bus controller} /system_tb/DUT/CPU/CC/write_from1
add wave -noupdate -expand -group {Bus controller} /system_tb/DUT/CPU/CC/busread0
add wave -noupdate -expand -group {Bus controller} /system_tb/DUT/CPU/CC/busrd0
add wave -noupdate -expand -group {Bus controller} /system_tb/DUT/CPU/CC/busread1
add wave -noupdate -expand -group {Bus controller} /system_tb/DUT/CPU/CC/busrd1
add wave -noupdate -expand -group {Bus controller} /system_tb/DUT/CPU/CC/buswrite0
add wave -noupdate -expand -group {Bus controller} /system_tb/DUT/CPU/CC/buswr0
add wave -noupdate -expand -group {Bus controller} /system_tb/DUT/CPU/CC/buswrite1
add wave -noupdate -expand -group {Bus controller} /system_tb/DUT/CPU/CC/buswr1
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/q
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/ramREN
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/ramWEN
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/ramaddr
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/ramstore
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/ramload
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/ramstate
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/memREN
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/memWEN
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/memaddr
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/memstore
add wave -noupdate -group syif /system_tb/syif/tbCTRL
add wave -noupdate -group syif /system_tb/syif/halt
add wave -noupdate -group syif /system_tb/syif/WEN
add wave -noupdate -group syif /system_tb/syif/REN
add wave -noupdate -group syif /system_tb/syif/addr
add wave -noupdate -group syif /system_tb/syif/store
add wave -noupdate -group syif /system_tb/syif/load
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {617623 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 300
configure wave -valuecolwidth 202
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {673950 ps}
