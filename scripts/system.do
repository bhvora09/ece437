onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/DUT/CPU/DP/nRST
add wave -noupdate /system_tb/DUT/CLK
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/iwait
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/dwait
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/iREN
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/dREN
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/dWEN
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/iload
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/dload
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/dstore
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/iaddr
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/daddr
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ccwait
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ccinv
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ccwrite
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/cctrans
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ccsnoopaddr
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ramWEN
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ramREN
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ramstate
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ramaddr
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ramstore
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ramload
add wave -noupdate -group DPvar /system_tb/DUT/CPU/DP/CLK
add wave -noupdate -group DPvar /system_tb/DUT/CPU/DP/nRST
add wave -noupdate -group DPvar /system_tb/DUT/CPU/DP/SignExt_addr
add wave -noupdate -group DPvar /system_tb/DUT/CPU/DP/ZeroExt_addr
add wave -noupdate -group DPvar /system_tb/DUT/CPU/DP/Ext_addr
add wave -noupdate -group DPvar /system_tb/DUT/CPU/DP/npc
add wave -noupdate -group DPvar /system_tb/DUT/CPU/DP/shift_left_1
add wave -noupdate -group DPvar /system_tb/DUT/CPU/DP/extended_address
add wave -noupdate -group DPvar /system_tb/DUT/CPU/DP/rd
add wave -noupdate -group DPvar /system_tb/DUT/CPU/DP/halt
add wave -noupdate -group DPvar /system_tb/DUT/CPU/DP/opinfetch
add wave -noupdate -group DPvar /system_tb/DUT/CPU/DP/opindecode
add wave -noupdate -group DPvar /system_tb/DUT/CPU/DP/opinexec
add wave -noupdate -group DPvar /system_tb/DUT/CPU/DP/opinmem
add wave -noupdate -group DPvar /system_tb/DUT/CPU/DP/opinwrback
add wave -noupdate -group DPvar /system_tb/DUT/CPU/DP/aluopinfetch
add wave -noupdate -group DPvar /system_tb/DUT/CPU/DP/aluopindecode
add wave -noupdate -group DPvar /system_tb/DUT/CPU/DP/aluopinexec
add wave -noupdate -group DPvar /system_tb/DUT/CPU/DP/aluopinmem
add wave -noupdate -group DPvar /system_tb/DUT/CPU/DP/aluopinwrback
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/opinfetch
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/aluopinfetch
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/pcif/pc
add wave -noupdate -group dcif /system_tb/DUT/CPU/dcif/halt
add wave -noupdate -group dcif -expand -group instr /system_tb/DUT/CPU/dcif/ihit
add wave -noupdate -group dcif -expand -group instr /system_tb/DUT/CPU/dcif/imemREN
add wave -noupdate -group dcif -expand -group instr /system_tb/DUT/CPU/dcif/imemload
add wave -noupdate -group dcif -expand -group instr /system_tb/DUT/CPU/dcif/imemaddr
add wave -noupdate -group dcif -expand -group data /system_tb/DUT/CPU/dcif/dhit
add wave -noupdate -group dcif -expand -group data /system_tb/DUT/CPU/dcif/dmemREN
add wave -noupdate -group dcif -expand -group data /system_tb/DUT/CPU/dcif/dmemWEN
add wave -noupdate -group dcif -expand -group data /system_tb/DUT/CPU/dcif/flushed
add wave -noupdate -group dcif -expand -group data /system_tb/DUT/CPU/dcif/dmemload
add wave -noupdate -group dcif -expand -group data /system_tb/DUT/CPU/dcif/dmemaddr
add wave -noupdate -group dcif -expand -group data /system_tb/DUT/CPU/dcif/dmemstore
add wave -noupdate -group dcif -expand -group data /system_tb/DUT/CPU/dcif/datomic
add wave -noupdate -group cif /system_tb/DUT/CPU/cif0/iwait
add wave -noupdate -group cif /system_tb/DUT/CPU/cif0/dwait
add wave -noupdate -group cif /system_tb/DUT/CPU/cif0/iREN
add wave -noupdate -group cif /system_tb/DUT/CPU/cif0/dREN
add wave -noupdate -group cif /system_tb/DUT/CPU/cif0/dWEN
add wave -noupdate -group cif /system_tb/DUT/CPU/cif0/iload
add wave -noupdate -group cif /system_tb/DUT/CPU/cif0/dload
add wave -noupdate -group cif /system_tb/DUT/CPU/cif0/dstore
add wave -noupdate -group cif /system_tb/DUT/CPU/cif0/iaddr
add wave -noupdate -group cif /system_tb/DUT/CPU/cif0/daddr
add wave -noupdate -group cif /system_tb/DUT/CPU/cif0/ccwait
add wave -noupdate -group cif /system_tb/DUT/CPU/cif0/ccinv
add wave -noupdate -group cif /system_tb/DUT/CPU/cif0/ccwrite
add wave -noupdate -group cif /system_tb/DUT/CPU/cif0/cctrans
add wave -noupdate -group cif /system_tb/DUT/CPU/cif0/ccsnoopaddr
add wave -noupdate -group RegisterFile /system_tb/DUT/CPU/DP/RF/CLK
add wave -noupdate -group RegisterFile /system_tb/DUT/CPU/DP/RF/nRST
add wave -noupdate -group RegisterFile /system_tb/DUT/CPU/DP/RF/regfile
add wave -noupdate -group RegisterFile /system_tb/DUT/CPU/DP/RF/regfile_next
add wave -noupdate -group RegisterFile /system_tb/DUT/CPU/DP/RF/rfif/WEN
add wave -noupdate -group RegisterFile /system_tb/DUT/CPU/DP/RF/rfif/wsel
add wave -noupdate -group RegisterFile /system_tb/DUT/CPU/DP/RF/rfif/rsel1
add wave -noupdate -group RegisterFile /system_tb/DUT/CPU/DP/RF/rfif/rsel2
add wave -noupdate -group RegisterFile /system_tb/DUT/CPU/DP/RF/rfif/wdat
add wave -noupdate -group RegisterFile /system_tb/DUT/CPU/DP/RF/rfif/rdat1
add wave -noupdate -group RegisterFile /system_tb/DUT/CPU/DP/RF/rfif/rdat2
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/flagNeg
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/flagZero
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/flagOvf
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/op
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/portA
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/portB
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/portOut
add wave -noupdate -group PC /system_tb/DUT/CPU/DP/pcif/PCen
add wave -noupdate -group PC /system_tb/DUT/CPU/DP/pcif/pc
add wave -noupdate -group PC /system_tb/DUT/CPU/DP/pcif/pc_next
add wave -noupdate -group HUIF /system_tb/DUT/CPU/DP/huif/PCWrite
add wave -noupdate -group HUIF /system_tb/DUT/CPU/DP/huif/deif_RegWr
add wave -noupdate -group HUIF /system_tb/DUT/CPU/DP/huif/deif_MemtoReg
add wave -noupdate -group HUIF /system_tb/DUT/CPU/DP/huif/decode_memWr
add wave -noupdate -group HUIF /system_tb/DUT/CPU/DP/huif/emif_MemtoReg
add wave -noupdate -group HUIF /system_tb/DUT/CPU/DP/huif/emif_RegWr
add wave -noupdate -group HUIF /system_tb/DUT/CPU/DP/huif/emif_bneS
add wave -noupdate -group HUIF /system_tb/DUT/CPU/DP/huif/emif_beqS
add wave -noupdate -group HUIF /system_tb/DUT/CPU/DP/huif/emif_jS
add wave -noupdate -group HUIF /system_tb/DUT/CPU/DP/huif/emif_jrS
add wave -noupdate -group HUIF /system_tb/DUT/CPU/DP/huif/emif_jalS
add wave -noupdate -group HUIF /system_tb/DUT/CPU/DP/huif/fdif_flush
add wave -noupdate -group HUIF /system_tb/DUT/CPU/DP/huif/fdif_stall
add wave -noupdate -group HUIF /system_tb/DUT/CPU/DP/huif/deif_stall
add wave -noupdate -group HUIF /system_tb/DUT/CPU/DP/huif/deif_flush
add wave -noupdate -group HUIF /system_tb/DUT/CPU/DP/huif/emif_flush
add wave -noupdate -group HUIF /system_tb/DUT/CPU/DP/huif/emif_stall
add wave -noupdate -group HUIF /system_tb/DUT/CPU/DP/huif/mwif_stall
add wave -noupdate -group HUIF /system_tb/DUT/CPU/DP/huif/mwif_flush
add wave -noupdate -group HUIF /system_tb/DUT/CPU/DP/huif/fdif_rs
add wave -noupdate -group HUIF /system_tb/DUT/CPU/DP/huif/fdif_rt
add wave -noupdate -group HUIF /system_tb/DUT/CPU/DP/huif/fdif_rd
add wave -noupdate -group HUIF /system_tb/DUT/CPU/DP/huif/deif_rt
add wave -noupdate -group HUIF /system_tb/DUT/CPU/DP/huif/deif_rd
add wave -noupdate -group HUIF /system_tb/DUT/CPU/DP/huif/deif_rs
add wave -noupdate -group HUIF /system_tb/DUT/CPU/DP/huif/emif_rt
add wave -noupdate -group HUIF /system_tb/DUT/CPU/DP/huif/emif_rs
add wave -noupdate -group HUIF /system_tb/DUT/CPU/DP/huif/emif_rd
add wave -noupdate -group HUIF /system_tb/DUT/CPU/DP/huif/deif_opcode
add wave -noupdate -group HUIF /system_tb/DUT/CPU/DP/huif/emif_opcode
add wave -noupdate -group FUIF /system_tb/DUT/CPU/DP/fuif/emif_RegWr
add wave -noupdate -group FUIF /system_tb/DUT/CPU/DP/fuif/mwif_RegWr
add wave -noupdate -group FUIF /system_tb/DUT/CPU/DP/fuif/emif_rd
add wave -noupdate -group FUIF /system_tb/DUT/CPU/DP/fuif/mwif_rd
add wave -noupdate -group FUIF /system_tb/DUT/CPU/DP/fuif/deif_rs
add wave -noupdate -group FUIF /system_tb/DUT/CPU/DP/fuif/deif_rt
add wave -noupdate -group FUIF /system_tb/DUT/CPU/DP/fuif/emif_portout
add wave -noupdate -group FUIF /system_tb/DUT/CPU/DP/fuif/mwif_portout
add wave -noupdate -group FUIF /system_tb/DUT/CPU/DP/fuif/Asel
add wave -noupdate -group FUIF /system_tb/DUT/CPU/DP/fuif/Bsel
add wave -noupdate -group FUIF /system_tb/DUT/CPU/DP/fuif/DataB
add wave -noupdate -group FUIF /system_tb/DUT/CPU/DP/fuif/DataA
add wave -noupdate -group FDIF /system_tb/DUT/CPU/DP/fdif/instr_in
add wave -noupdate -group FDIF /system_tb/DUT/CPU/DP/fdif/pc_in
add wave -noupdate -group FDIF /system_tb/DUT/CPU/DP/fdif/pcplusfour_in
add wave -noupdate -group FDIF /system_tb/DUT/CPU/DP/fdif/ihit
add wave -noupdate -group FDIF /system_tb/DUT/CPU/DP/fdif/dhit
add wave -noupdate -group FDIF /system_tb/DUT/CPU/DP/fdif/stall
add wave -noupdate -group FDIF /system_tb/DUT/CPU/DP/fdif/instr_out
add wave -noupdate -group FDIF /system_tb/DUT/CPU/DP/fdif/pc_out
add wave -noupdate -group FDIF /system_tb/DUT/CPU/DP/fdif/pcplusfour_out
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/instr_in
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/Ext_addr_in
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/pcplusfour_in
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/rdat1_in
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/rdat2_in
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/pc_in
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/dWEN_in
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/dREN_in
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/bne_s_in
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/beq_s_in
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/jal_s_in
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/jr_s_in
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/jump_s_in
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/lui_in
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/RegDst_in
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/ALUSrc_in
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/RegWr_in
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/MemWr_in
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/MemtoReg_in
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/halt_in
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/imm_addr_in
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/reg_rs_in
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/reg_rt_in
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/reg_rd_in
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/shift_amt_in
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/j_addr_in
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/funct_in
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/opcode_in
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/ALUctr_in
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/instr_out
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/Ext_addr_out
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/pcplusfour_out
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/rdat1_out
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/rdat2_out
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/pc_out
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/dWEN_out
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/dREN_out
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/bne_s_out
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/beq_s_out
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/jal_s_out
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/jr_s_out
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/jump_s_out
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/lui_out
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/RegDst_out
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/ALUSrc_out
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/RegWr_out
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/MemWr_out
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/MemtoReg_out
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/halt_out
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/imm_addr_out
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/reg_rs_out
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/reg_rt_out
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/reg_rd_out
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/shift_amt_out
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/j_addr_out
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/funct_out
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/opcode_out
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/ALUctr_out
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/ihit
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/dhit
add wave -noupdate -group DEIF /system_tb/DUT/CPU/DP/deif/stall
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/dREN_in
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/dWEN_in
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/bne_s_in
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/beq_s_in
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/jal_s_in
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/flagZero_in
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/lui_in
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/MemtoReg_in
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/RegWr_in
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/jump_s_in
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/jr_s_in
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/ihit
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/dhit
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/MemWr_in
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/halt_in
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/stall
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/dREN_out
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/dREN
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/dWEN_out
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/dWEN
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/bne_s_out
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/beq_s_out
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/jal_s_out
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/flagZero_out
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/lui_out
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/MemtoReg_out
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/RegWr_out
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/jump_s_out
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/jr_s_out
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/MemWr_out
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/halt_out
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/pcplusfour_in
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/pc_in
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/rdat2_in
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/alu_portOut_in
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/instr_in
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/Ext_addr_in
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/rdat1_in
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/pcplusfour_out
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/pc_out
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/rdat2_out
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/alu_portOut_out
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/instr_out
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/Ext_addr_out
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/rdat1_out
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/imm_addr_in
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/imm_addr_out
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/j_addr_in
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/j_addr_out
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/wsel_in
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/shift_amt_in
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/reg_rs_in
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/reg_rt_in
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/reg_rd_in
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/wsel_out
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/shift_amt_out
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/reg_rs_out
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/reg_rt_out
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/reg_rd_out
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/opcode_in
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/opcode_out
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/funct_in
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/funct_out
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/jal_s_in
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/lui_in
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/MemtoReg_in
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/RegWr_in
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/halt_in
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/ihit
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/dhit
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/stall
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/flush
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/jal_s_out
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/lui_out
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/MemtoReg_out
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/RegWr_out
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/halt_out
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/pcplusfour_in
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/pc_in
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/alu_portOut_in
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/instr_in
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/wdat_in
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/rdat2_in
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/pcplusfour_out
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/pc_out
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/instr_out
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/wdat_out
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/alu_portOut_out
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/rdat2_out
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/imm_addr_in
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/imm_addr_out
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/wsel_in
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/shift_amt_in
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/reg_rs_in
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/reg_rt_in
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/reg_rd_in
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/wsel_out
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/shift_amt_out
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/reg_rs_out
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/reg_rt_out
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/reg_rd_out
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/opcode_in
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/opcode_out
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/funct_in
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/funct_out
add wave -noupdate /system_tb/DUT/CPU/DP/opinfetch
add wave -noupdate /system_tb/DUT/CPU/DP/aluopinfetch
add wave -noupdate /system_tb/DUT/CPU/DP/opinmem
add wave -noupdate /system_tb/DUT/CPU/DP/aluopinmem
add wave -noupdate -expand -group hits /system_tb/DUT/CPU/dcif/ihit
add wave -noupdate -expand -group hits /system_tb/DUT/CPU/dcif/dhit
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/CLK
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/nRST
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/table1
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/temptable1
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/table2
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/temptable2
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/LRU
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/dload1
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/dload2
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/dstore10
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/dstore11
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/dstore20
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/dstore21
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/tag1
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/tag2
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/index
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/i
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/state
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/next_state
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/daddr
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/ICACHE/CLK
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/ICACHE/nRST
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/ICACHE/hit
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/ICACHE/data
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/ICACHE/addr
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/ICACHE/frames
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/ICACHE/n_frames
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/ICACHE/frame
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/ICACHE/valid
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/ICACHE/iwait
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/ICACHE/s
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/ICACHE/nS
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {587270 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 334
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {2698336 ps}
