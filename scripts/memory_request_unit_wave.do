onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /memory_request_unit_tb/CLK
add wave -noupdate /memory_request_unit_tb/nRST
add wave -noupdate /memory_request_unit_tb/mruif/dhit
add wave -noupdate /memory_request_unit_tb/mruif/dmemREN
add wave -noupdate /memory_request_unit_tb/mruif/dmemWEN
add wave -noupdate /memory_request_unit_tb/mruif/dren
add wave -noupdate /memory_request_unit_tb/mruif/dwen
add wave -noupdate /memory_request_unit_tb/mruif/ihit
add wave -noupdate /memory_request_unit_tb/mruif/imemREN
add wave -noupdate /memory_request_unit_tb/mruif/iren
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {21 ns} 0}
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
WaveRestoreZoom {0 ns} {64 ns}
