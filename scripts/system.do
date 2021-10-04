onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/DUT/CPU/DP/CLK
add wave -noupdate /system_tb/DUT/CPU/DP/nRST
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/PC_INIT
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/SignExt_addr
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/ZeroExt_addr
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/Ext_addr
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/npc
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/shift_left_1
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/extended_address
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/rd
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/opinfetch
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/opindecode
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/opinexec
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/opinmem
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/opinwrback
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/aluopinfetch
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/aluopindecode
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/aluopinexec
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/aluopinmem
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/aluopinwrback
add wave -noupdate -group DPIF /system_tb/DUT/CPU/DP/dpif/halt
add wave -noupdate -group DPIF /system_tb/DUT/CPU/DP/dpif/ihit
add wave -noupdate -group DPIF /system_tb/DUT/CPU/DP/dpif/imemREN
add wave -noupdate -group DPIF /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate -group DPIF /system_tb/DUT/CPU/DP/dpif/imemaddr
add wave -noupdate -group DPIF /system_tb/DUT/CPU/DP/dpif/dhit
add wave -noupdate -group DPIF /system_tb/DUT/CPU/DP/dpif/datomic
add wave -noupdate -group DPIF /system_tb/DUT/CPU/DP/dpif/dmemREN
add wave -noupdate -group DPIF /system_tb/DUT/CPU/DP/dpif/dmemWEN
add wave -noupdate -group DPIF /system_tb/DUT/CPU/DP/dpif/flushed
add wave -noupdate -group DPIF /system_tb/DUT/CPU/DP/dpif/dmemload
add wave -noupdate -group DPIF /system_tb/DUT/CPU/DP/dpif/dmemstore
add wave -noupdate -group DPIF /system_tb/DUT/CPU/DP/dpif/dmemaddr
add wave -noupdate -group ALUIF /system_tb/DUT/CPU/DP/aluif/flagNeg
add wave -noupdate -group ALUIF /system_tb/DUT/CPU/DP/aluif/flagZero
add wave -noupdate -group ALUIF /system_tb/DUT/CPU/DP/aluif/flagOvf
add wave -noupdate -group ALUIF /system_tb/DUT/CPU/DP/aluif/op
add wave -noupdate -group ALUIF /system_tb/DUT/CPU/DP/aluif/portA
add wave -noupdate -group ALUIF /system_tb/DUT/CPU/DP/aluif/portB
add wave -noupdate -group ALUIF /system_tb/DUT/CPU/DP/aluif/portOut
add wave -noupdate -group CUIF /system_tb/DUT/CPU/DP/cuif/instr
add wave -noupdate -group CUIF /system_tb/DUT/CPU/DP/cuif/ALUctr
add wave -noupdate -group CUIF /system_tb/DUT/CPU/DP/cuif/funct
add wave -noupdate -group CUIF /system_tb/DUT/CPU/DP/cuif/opcode
add wave -noupdate -group CUIF /system_tb/DUT/CPU/DP/cuif/reg_rs
add wave -noupdate -group CUIF /system_tb/DUT/CPU/DP/cuif/reg_rt
add wave -noupdate -group CUIF /system_tb/DUT/CPU/DP/cuif/reg_rd
add wave -noupdate -group CUIF /system_tb/DUT/CPU/DP/cuif/RegDst
add wave -noupdate -group CUIF /system_tb/DUT/CPU/DP/cuif/RegWr
add wave -noupdate -group CUIF /system_tb/DUT/CPU/DP/cuif/MemWr
add wave -noupdate -group CUIF /system_tb/DUT/CPU/DP/cuif/MemtoReg
add wave -noupdate -group CUIF /system_tb/DUT/CPU/DP/cuif/ExtOp
add wave -noupdate -group CUIF /system_tb/DUT/CPU/DP/cuif/ALUSrc
add wave -noupdate -group CUIF /system_tb/DUT/CPU/DP/cuif/jal_s
add wave -noupdate -group CUIF /system_tb/DUT/CPU/DP/cuif/dREN
add wave -noupdate -group CUIF /system_tb/DUT/CPU/DP/cuif/dWEN
add wave -noupdate -group CUIF /system_tb/DUT/CPU/DP/cuif/halt
add wave -noupdate -group CUIF /system_tb/DUT/CPU/DP/cuif/beq_s
add wave -noupdate -group CUIF /system_tb/DUT/CPU/DP/cuif/bne_s
add wave -noupdate -group CUIF /system_tb/DUT/CPU/DP/cuif/jump_s
add wave -noupdate -group CUIF /system_tb/DUT/CPU/DP/cuif/jr_s
add wave -noupdate -group CUIF /system_tb/DUT/CPU/DP/cuif/lui
add wave -noupdate -group CUIF /system_tb/DUT/CPU/DP/cuif/imm_addr
add wave -noupdate -group CUIF /system_tb/DUT/CPU/DP/cuif/j_addr
add wave -noupdate -group CUIF /system_tb/DUT/CPU/DP/cuif/shift_amt
add wave -noupdate -group PC /system_tb/DUT/CPU/DP/pcif/PCen
add wave -noupdate -group PC /system_tb/DUT/CPU/DP/pcif/pc
add wave -noupdate -group PC /system_tb/DUT/CPU/DP/pcif/pc_next
add wave -noupdate -group RFIF /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate -group RFIF /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate -group RFIF /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate -group RFIF /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate -group RFIF /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate -group RFIF /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate -group RFIF /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate -group RFIF /system_tb/DUT/CPU/DP/RF/regfile
add wave -noupdate -group RFIF /system_tb/DUT/CPU/DP/RF/regfile_next
add wave -noupdate -expand -group FDIF /system_tb/DUT/CPU/DP/fdif/ihit
add wave -noupdate -expand -group FDIF /system_tb/DUT/CPU/DP/fdif/dhit
add wave -noupdate -expand -group FDIF /system_tb/DUT/CPU/DP/fdif/instr_in
add wave -noupdate -expand -group FDIF /system_tb/DUT/CPU/DP/fdif/instr_out
add wave -noupdate -expand -group FDIF /system_tb/DUT/CPU/DP/fdif/pc_in
add wave -noupdate -expand -group FDIF /system_tb/DUT/CPU/DP/fdif/pcplusfour_in
add wave -noupdate -expand -group FDIF /system_tb/DUT/CPU/DP/fdif/pc_out
add wave -noupdate -expand -group FDIF /system_tb/DUT/CPU/DP/fdif/pcplusfour_out
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/instr_in
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/Ext_addr_in
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/pcplusfour_in
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/rdat1_in
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/rdat2_in
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/pc_in
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/dWEN_in
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/dREN_in
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/bne_s_in
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/beq_s_in
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/jal_s_in
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/jr_s_in
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/jump_s_in
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/lui_in
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/RegDst_in
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/ALUSrc_in
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/RegWr_in
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/MemWr_in
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/MemtoReg_in
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/halt_in
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/imm_addr_in
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/reg_rs_in
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/reg_rt_in
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/reg_rd_in
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/shift_amt_in
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/j_addr_in
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/funct_in
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/opcode_in
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/ALUctr_in
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/instr_out
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/Ext_addr_out
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/pcplusfour_out
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/rdat1_out
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/rdat2_out
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/pc_out
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/dWEN_out
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/dREN_out
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/bne_s_out
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/beq_s_out
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/jal_s_out
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/jr_s_out
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/jump_s_out
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/lui_out
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/RegDst_out
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/ALUSrc_out
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/RegWr_out
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/MemWr_out
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/MemtoReg_out
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/halt_out
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/imm_addr_out
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/reg_rs_out
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/reg_rt_out
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/reg_rd_out
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/shift_amt_out
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/j_addr_out
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/funct_out
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/opcode_out
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/ALUctr_out
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/ihit
add wave -noupdate -expand -group DEIF /system_tb/DUT/CPU/DP/deif/dhit
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
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/dREN_out
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/dWEN_out
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
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/wsel_out
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/shift_amt_out
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/reg_rs_out
add wave -noupdate -group EMIF /system_tb/DUT/CPU/DP/emif/reg_rt_out
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
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/wsel_out
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/shift_amt_out
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/reg_rs_out
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/reg_rt_out
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/opcode_in
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/opcode_out
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/funct_in
add wave -noupdate -group MWIF /system_tb/DUT/CPU/DP/mwif/funct_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {764087580 ps} 0}
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
WaveRestoreZoom {0 ps} {1377180 ns}
