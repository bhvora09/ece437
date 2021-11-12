onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /forwarding_unit_tb/PROG/tb_test_num
add wave -noupdate /forwarding_unit_tb/PROG/tb_test_case
add wave -noupdate -expand -group IN /forwarding_unit_tb/DUT/fuif/emif_RegWr
add wave -noupdate -expand -group IN /forwarding_unit_tb/DUT/fuif/mwif_RegWr
add wave -noupdate -expand -group IN /forwarding_unit_tb/DUT/fuif/emif_rd
add wave -noupdate -expand -group IN /forwarding_unit_tb/DUT/fuif/mwif_rd
add wave -noupdate -expand -group IN /forwarding_unit_tb/DUT/fuif/deif_rs
add wave -noupdate -expand -group IN /forwarding_unit_tb/DUT/fuif/deif_rt
add wave -noupdate -expand -group IN /forwarding_unit_tb/DUT/fuif/emif_portout
add wave -noupdate -expand -group IN /forwarding_unit_tb/DUT/fuif/mwif_portout
add wave -noupdate -expand -group OUT /forwarding_unit_tb/DUT/fuif/Asel
add wave -noupdate -expand -group OUT /forwarding_unit_tb/DUT/fuif/Bsel
add wave -noupdate -expand -group OUT /forwarding_unit_tb/DUT/fuif/DataB
add wave -noupdate -expand -group OUT /forwarding_unit_tb/DUT/fuif/DataA
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1648 ns} 0}
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
WaveRestoreZoom {0 ns} {17282 ns}
