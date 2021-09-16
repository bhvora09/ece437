onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /control_unit_tb/CLK
add wave -noupdate /control_unit_tb/cuif/ALUctr
add wave -noupdate /control_unit_tb/cuif/ALUSrc
add wave -noupdate /control_unit_tb/cuif/dREN
add wave -noupdate /control_unit_tb/cuif/dWEN
add wave -noupdate /control_unit_tb/cuif/ExtOp
add wave -noupdate /control_unit_tb/cuif/instr
add wave -noupdate /control_unit_tb/cuif/iREN
add wave -noupdate /control_unit_tb/cuif/jal_s
add wave -noupdate /control_unit_tb/cuif/MemtoReg
add wave -noupdate /control_unit_tb/cuif/MemWr
add wave -noupdate /control_unit_tb/cuif/PCen
add wave -noupdate /control_unit_tb/cuif/PCsrc
add wave -noupdate /control_unit_tb/cuif/RegDst
add wave -noupdate /control_unit_tb/cuif/RegWr
add wave -noupdate /control_unit_tb/CUDUT/addr_w
add wave -noupdate /control_unit_tb/CUDUT/alu_op_w
add wave -noupdate /control_unit_tb/CUDUT/ALUop
add wave -noupdate /control_unit_tb/CUDUT/funct
add wave -noupdate /control_unit_tb/CUDUT/imm_addr
add wave -noupdate /control_unit_tb/CUDUT/imm_w
add wave -noupdate /control_unit_tb/CUDUT/itypeintru
add wave -noupdate /control_unit_tb/CUDUT/j_addr
add wave -noupdate /control_unit_tb/CUDUT/jtypeinstr
add wave -noupdate /control_unit_tb/CUDUT/opcode
add wave -noupdate /control_unit_tb/CUDUT/reg_rd
add wave -noupdate /control_unit_tb/CUDUT/reg_rs
add wave -noupdate /control_unit_tb/CUDUT/reg_rt
add wave -noupdate /control_unit_tb/CUDUT/rtypeinstr
add wave -noupdate /control_unit_tb/CUDUT/sham_w
add wave -noupdate /control_unit_tb/CUDUT/shift_amt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {193 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ns} {250 ns}
