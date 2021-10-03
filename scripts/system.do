onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/instr_in
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/Ext_addr_in
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/pcplusfour_in
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/rdat1_in
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/rdat2_in
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/dWEN_in
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/dREN_in
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/bne_s_in
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/beq_s_in
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/jal_s_in
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/jr_s_in
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/jump_s_in
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/lui_in
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/RegDst_in
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/ALUSrc_in
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/ALUctr_in
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/RegWr_in
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/MemWr_in
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/MemtoReg_in
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/halt_in
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/imm_addr_in
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/reg_rt_in
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/reg_rd_in
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/shift_amt_in
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/j_addr_in
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/funct_in
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/instr_out
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/Ext_addr_out
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/pcplusfour_out
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/rdat1_out
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/rdat2_out
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/dWEN_out
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/dREN_out
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/bne_s_out
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/beq_s_out
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/jal_s_out
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/jr_s_out
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/jump_s_out
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/lui_out
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/RegDst_out
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/ALUSrc_out
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/ALUctr_out
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/RegWr_out
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/MemWr_out
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/MemtoReg_out
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/halt_out
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/imm_addr_out
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/reg_rt_out
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/reg_rd_out
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/shift_amt_out
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/j_addr_out
add wave -noupdate -group deif /system_tb/DUT/CPU/DP/deif/funct_out
add wave -noupdate /system_tb/DUT/CPU/DP/rd
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/lui_in
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/MemtoReg_in
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/RegWr_in
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/halt_in
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/jal_s_out
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/lui_out
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/MemtoReg_out
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/RegWr_out
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/halt_out
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/pcplusfour_in
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/alu_portOut_in
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/instr_in
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/wdat_in
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/pcplusfour_out
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/instr_out
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/wdat_out
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/alu_portOut_out
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/imm_addr_in
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/imm_addr_out
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/wsel_in
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/shift_amt_in
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/wsel_out
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/shift_amt_out
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/funct_in
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/funct_out
add wave -noupdate -group mwif /system_tb/DUT/CPU/DP/mwif/jal_s_in
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/dREN_in
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/dWEN_in
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/bne_s_in
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/beq_s_in
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/jal_s_in
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/flagZero_in
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/lui_in
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/MemtoReg_in
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/RegWr_in
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/jump_s_in
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/jr_s_in
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/MemWr_in
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/halt_in
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/dREN_out
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/dWEN_out
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/bne_s_out
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/beq_s_out
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/jal_s_out
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/flagZero_out
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/lui_out
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/MemtoReg_out
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/RegWr_out
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/jump_s_out
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/jr_s_out
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/MemWr_out
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/halt_out
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/pcplusfour_in
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/rdat2_in
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/alu_portOut_in
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/instr_in
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/Ext_addr_in
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/rdat1_in
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/pcplusfour_out
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/rdat2_out
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/alu_portOut_out
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/instr_out
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/Ext_addr_out
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/rdat1_out
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/imm_addr_in
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/imm_addr_out
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/j_addr_in
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/j_addr_out
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/wsel_in
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/shift_amt_in
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/wsel_out
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/shift_amt_out
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/funct_in
add wave -noupdate -expand -group emif /system_tb/DUT/CPU/DP/emif/funct_out
add wave -noupdate /system_tb/DUT/CPU/DP/RF/regfile
add wave -noupdate -expand -group dp_variables /system_tb/DUT/CPU/DP/CLK
add wave -noupdate -expand -group dp_variables /system_tb/DUT/CPU/DP/nRST
add wave -noupdate -expand -group dp_variables /system_tb/DUT/CPU/DP/SignExt_addr
add wave -noupdate -expand -group dp_variables /system_tb/DUT/CPU/DP/ZeroExt_addr
add wave -noupdate -expand -group dp_variables /system_tb/DUT/CPU/DP/Ext_addr
add wave -noupdate -expand -group dp_variables /system_tb/DUT/CPU/DP/npc
add wave -noupdate -expand -group dp_variables /system_tb/DUT/CPU/DP/shift_left_1
add wave -noupdate -expand -group dp_variables /system_tb/DUT/CPU/DP/extended_address
add wave -noupdate -expand -group dp_variables /system_tb/DUT/CPU/DP/rd
add wave -noupdate -expand -group dp_variables /system_tb/DUT/CPU/DP/opinfetch
add wave -noupdate -expand -group dp_variables /system_tb/DUT/CPU/DP/opindecode
add wave -noupdate -expand -group dp_variables /system_tb/DUT/CPU/DP/opinexec
add wave -noupdate -expand -group dp_variables /system_tb/DUT/CPU/DP/opinmem
add wave -noupdate -expand -group dp_variables /system_tb/DUT/CPU/DP/opinwrback
add wave -noupdate -expand -group dp_variables /system_tb/DUT/CPU/DP/aluopinfetch
add wave -noupdate -expand -group dp_variables /system_tb/DUT/CPU/DP/aluopindecode
add wave -noupdate -expand -group dp_variables /system_tb/DUT/CPU/DP/aluopinexec
add wave -noupdate -expand -group dp_variables /system_tb/DUT/CPU/DP/aluopinmem
add wave -noupdate -expand -group dp_variables /system_tb/DUT/CPU/DP/aluopinwrback
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/halt
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/ihit
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/imemREN
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/imemaddr
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dhit
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/datomic
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemREN
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemWEN
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/flushed
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemload
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemstore
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemaddr
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
add wave -noupdate -group pcif /system_tb/DUT/CPU/DP/pcif/PCen
add wave -noupdate -group pcif /system_tb/DUT/CPU/DP/pcif/pc
add wave -noupdate -group pcif /system_tb/DUT/CPU/DP/pcif/pc_next
add wave -noupdate -group Hazard_unit /system_tb/DUT/CPU/DP/huif/PCWrite
add wave -noupdate -group Hazard_unit /system_tb/DUT/CPU/DP/huif/deif_MemtoReg
add wave -noupdate -group Hazard_unit /system_tb/DUT/CPU/DP/huif/deif_memWr
add wave -noupdate -group Hazard_unit /system_tb/DUT/CPU/DP/huif/emif_bneS
add wave -noupdate -group Hazard_unit /system_tb/DUT/CPU/DP/huif/emif_beqS
add wave -noupdate -group Hazard_unit /system_tb/DUT/CPU/DP/huif/emif_jS
add wave -noupdate -group Hazard_unit /system_tb/DUT/CPU/DP/huif/emif_jrS
add wave -noupdate -group Hazard_unit /system_tb/DUT/CPU/DP/huif/emif_jalS
add wave -noupdate -group Hazard_unit /system_tb/DUT/CPU/DP/huif/fdif_flush
add wave -noupdate -group Hazard_unit /system_tb/DUT/CPU/DP/huif/fdif_stall
add wave -noupdate -group Hazard_unit /system_tb/DUT/CPU/DP/huif/deif_stall
add wave -noupdate -group Hazard_unit /system_tb/DUT/CPU/DP/huif/deif_flush
add wave -noupdate -group Hazard_unit /system_tb/DUT/CPU/DP/huif/emif_flush
add wave -noupdate -group Hazard_unit /system_tb/DUT/CPU/DP/huif/emif_stall
add wave -noupdate -group Hazard_unit /system_tb/DUT/CPU/DP/huif/mwif_stall
add wave -noupdate -group Hazard_unit /system_tb/DUT/CPU/DP/huif/mwif_flush
add wave -noupdate -group Hazard_unit /system_tb/DUT/CPU/DP/huif/fdif_rs
add wave -noupdate -group Hazard_unit /system_tb/DUT/CPU/DP/huif/fdif_rt
add wave -noupdate -group Hazard_unit /system_tb/DUT/CPU/DP/huif/fdif_rd
add wave -noupdate -group Hazard_unit /system_tb/DUT/CPU/DP/huif/deif_rt
add wave -noupdate -group Hazard_unit /system_tb/DUT/CPU/DP/huif/deif_rd
add wave -noupdate -group Hazard_unit /system_tb/DUT/CPU/DP/huif/deif_rs
add wave -noupdate -group Hazard_unit /system_tb/DUT/CPU/DP/huif/emif_rt
add wave -noupdate -group Hazard_unit /system_tb/DUT/CPU/DP/huif/emif_rs
add wave -noupdate -group Hazard_unit /system_tb/DUT/CPU/DP/huif/emif_rd
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {200000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 334
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {706330 ps}
