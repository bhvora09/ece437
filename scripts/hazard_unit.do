onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /hazard_unit_tb/PROG/tb_test_num
add wave -noupdate /hazard_unit_tb/PROG/tb_test_case
add wave -noupdate -expand -group in /hazard_unit_tb/huif/deif_MemtoReg
add wave -noupdate -expand -group in /hazard_unit_tb/huif/deif_memWr
add wave -noupdate -expand -group in -group {jump and branch} /hazard_unit_tb/huif/emif_bneS
add wave -noupdate -expand -group in -group {jump and branch} /hazard_unit_tb/huif/emif_beqS
add wave -noupdate -expand -group in -group {jump and branch} /hazard_unit_tb/huif/emif_jS
add wave -noupdate -expand -group in -group {jump and branch} /hazard_unit_tb/huif/emif_jrS
add wave -noupdate -expand -group in -group {jump and branch} /hazard_unit_tb/huif/emif_jalS
add wave -noupdate -expand -group in -group register /hazard_unit_tb/huif/fdif_rs
add wave -noupdate -expand -group in -group register /hazard_unit_tb/huif/fdif_rt
add wave -noupdate -expand -group in -group register /hazard_unit_tb/huif/deif_rt
add wave -noupdate -expand -group in -group register /hazard_unit_tb/huif/deif_rd
add wave -noupdate -expand -group in -group register /hazard_unit_tb/huif/deif_rs
add wave -noupdate -expand -group in -group register /hazard_unit_tb/huif/emif_rt
add wave -noupdate -expand -group in -group register /hazard_unit_tb/huif/emif_rd
add wave -noupdate -expand -group out /hazard_unit_tb/huif/PCWrite
add wave -noupdate -expand -group out -group {flush stall} /hazard_unit_tb/huif/fdif_flush
add wave -noupdate -expand -group out -group {flush stall} /hazard_unit_tb/huif/fdif_stall
add wave -noupdate -expand -group out -group {flush stall} /hazard_unit_tb/huif/deif_stall
add wave -noupdate -expand -group out -group {flush stall} /hazard_unit_tb/huif/deif_flush
add wave -noupdate -expand -group out -group {flush stall} /hazard_unit_tb/huif/emif_flush
add wave -noupdate -expand -group out -group {flush stall} /hazard_unit_tb/huif/emif_stall
add wave -noupdate -expand -group out -group {flush stall} /hazard_unit_tb/huif/mwif_stall
add wave -noupdate -expand -group out -group {flush stall} /hazard_unit_tb/huif/mwif_flush
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2 ns} 0}
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
WaveRestoreZoom {0 ns} {5 ns}
