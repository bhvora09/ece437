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
add wave -noupdate -expand -group Datapath /system_tb/DUT/CPU/DP/opinfetch
add wave -noupdate -expand -group Datapath /system_tb/DUT/CPU/DP/aluopinfetch
add wave -noupdate -expand -group Datapath /system_tb/DUT/CPU/DP/pcif/pc
add wave -noupdate -expand -group dcif /system_tb/DUT/CPU/dcif/halt
add wave -noupdate -expand -group dcif -expand -group instr /system_tb/DUT/CPU/dcif/ihit
add wave -noupdate -expand -group dcif -expand -group instr /system_tb/DUT/CPU/dcif/imemREN
add wave -noupdate -expand -group dcif -expand -group instr /system_tb/DUT/CPU/dcif/imemload
add wave -noupdate -expand -group dcif -expand -group instr /system_tb/DUT/CPU/dcif/imemaddr
add wave -noupdate -expand -group dcif -expand -group data /system_tb/DUT/CPU/dcif/dhit
add wave -noupdate -expand -group dcif -expand -group data /system_tb/DUT/CPU/dcif/dmemREN
add wave -noupdate -expand -group dcif -expand -group data /system_tb/DUT/CPU/dcif/dmemWEN
add wave -noupdate -expand -group dcif -expand -group data /system_tb/DUT/CPU/dcif/flushed
add wave -noupdate -expand -group dcif -expand -group data /system_tb/DUT/CPU/dcif/dmemload
add wave -noupdate -expand -group dcif -expand -group data /system_tb/DUT/CPU/dcif/dmemaddr
add wave -noupdate -expand -group dcif -expand -group data /system_tb/DUT/CPU/dcif/dmemstore
add wave -noupdate -expand -group dcif -expand -group data /system_tb/DUT/CPU/dcif/datomic
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/cif0/iwait
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/cif0/dwait
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/cif0/iREN
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/cif0/dREN
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/cif0/dWEN
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/cif0/iload
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/cif0/dload
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/cif0/dstore
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/cif0/iaddr
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/cif0/daddr
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/cif0/ccwait
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/cif0/ccinv
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/cif0/ccwrite
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/cif0/cctrans
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/cif0/ccsnoopaddr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1945580 ps} 0}
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
WaveRestoreZoom {1263150 ps} {2586150 ps}
