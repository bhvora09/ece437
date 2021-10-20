onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /icache_tb/PROG/CLK
add wave -noupdate /icache_tb/PROG/nRST
add wave -noupdate -radix unsigned /icache_tb/PROG/tb_test_num
add wave -noupdate /icache_tb/PROG/tb_test_case
add wave -noupdate -expand -group internal /icache_tb/DUT/hit
add wave -noupdate -expand -group internal /icache_tb/DUT/data
add wave -noupdate -expand -group internal /icache_tb/DUT/addr
add wave -noupdate -expand -group internal /icache_tb/DUT/iwait
add wave -noupdate -expand -group internal /icache_tb/DUT/valid
add wave -noupdate -expand -group internal -expand -group frames /icache_tb/DUT/frame
add wave -noupdate -expand -group internal -expand -group frames /icache_tb/DUT/frames
add wave -noupdate -expand -group internal -expand -group frames /icache_tb/DUT/n_frames
add wave -noupdate -expand -group states /icache_tb/DUT/nS
add wave -noupdate -expand -group states /icache_tb/DUT/s
add wave -noupdate -expand -group ccif /icache_tb/ccif/iwait
add wave -noupdate -expand -group ccif /icache_tb/ccif/iREN
add wave -noupdate -expand -group ccif /icache_tb/ccif/iload
add wave -noupdate -expand -group ccif /icache_tb/ccif/iaddr
add wave -noupdate -expand -group dcif /icache_tb/dcif/ihit
add wave -noupdate -expand -group dcif /icache_tb/dcif/imemREN
add wave -noupdate -expand -group dcif /icache_tb/dcif/imemload
add wave -noupdate -expand -group dcif /icache_tb/dcif/imemaddr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {8 ns} 0}
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
WaveRestoreZoom {0 ns} {32 ns}
