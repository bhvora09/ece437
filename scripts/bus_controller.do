onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /bus_controller_tb/CLK
add wave -noupdate /bus_controller_tb/nRST
add wave -noupdate -radix decimal /bus_controller_tb/PROG/tb_test_num
add wave -noupdate -divider {New Divider}
add wave -noupdate -expand -group CCIF -expand -group Icache -color Orange -radix binary /bus_controller_tb/DUT/ccif/iREN
add wave -noupdate -expand -group CCIF -expand -group Icache -color Orange -radix hexadecimal /bus_controller_tb/DUT/ccif/iaddr
add wave -noupdate -expand -group CCIF -expand -group Icache -color Orange -radix hexadecimal /bus_controller_tb/DUT/ccif/iload
add wave -noupdate -expand -group CCIF -expand -group Icache -color Orange -radix binary /bus_controller_tb/DUT/ccif/iwait
add wave -noupdate -expand -group CCIF -divider {New Divider}
add wave -noupdate -expand -group CCIF -expand -group Dcache -color Cyan -radix binary /bus_controller_tb/DUT/ccif/dwait
add wave -noupdate -expand -group CCIF -expand -group Dcache -color Cyan -radix binary /bus_controller_tb/DUT/ccif/dREN
add wave -noupdate -expand -group CCIF -expand -group Dcache -color Cyan -radix binary /bus_controller_tb/DUT/ccif/dWEN
add wave -noupdate -expand -group CCIF -expand -group Dcache -color Cyan -radix hexadecimal /bus_controller_tb/DUT/ccif/dload
add wave -noupdate -expand -group CCIF -expand -group Dcache -color Cyan -radix hexadecimal /bus_controller_tb/DUT/ccif/dstore
add wave -noupdate -expand -group CCIF -expand -group Dcache -color Cyan -radix hexadecimal -childformat {{{/bus_controller_tb/DUT/ccif/daddr[1]} -radix hexadecimal} {{/bus_controller_tb/DUT/ccif/daddr[0]} -radix hexadecimal}} -expand -subitemconfig {{/bus_controller_tb/DUT/ccif/daddr[1]} {-color Cyan -height 16 -radix hexadecimal} {/bus_controller_tb/DUT/ccif/daddr[0]} {-color Cyan -height 16 -radix hexadecimal}} /bus_controller_tb/DUT/ccif/daddr
add wave -noupdate -expand -group CCIF -divider {New Divider}
add wave -noupdate -expand -group CCIF -expand -group {Cache Control} -color {Medium Violet Red} -radix binary /bus_controller_tb/DUT/ccif/ccwait
add wave -noupdate -expand -group CCIF -expand -group {Cache Control} -color {Medium Violet Red} -radix binary /bus_controller_tb/DUT/ccif/ccinv
add wave -noupdate -expand -group CCIF -expand -group {Cache Control} -color {Medium Violet Red} -radix binary -childformat {{{/bus_controller_tb/DUT/ccif/ccwrite[1]} -radix binary} {{/bus_controller_tb/DUT/ccif/ccwrite[0]} -radix binary}} -subitemconfig {{/bus_controller_tb/DUT/ccif/ccwrite[1]} {-color {Medium Violet Red} -height 16 -radix binary} {/bus_controller_tb/DUT/ccif/ccwrite[0]} {-color {Medium Violet Red} -height 16 -radix binary}} /bus_controller_tb/DUT/ccif/ccwrite
add wave -noupdate -expand -group CCIF -expand -group {Cache Control} -color {Medium Violet Red} -radix binary /bus_controller_tb/DUT/ccif/cctrans
add wave -noupdate -expand -group CCIF -expand -group {Cache Control} -color {Medium Violet Red} -radix hexadecimal /bus_controller_tb/DUT/ccif/ccsnoopaddr
add wave -noupdate -expand -group CCIF -divider {New Divider}
add wave -noupdate -expand -group CCIF -expand -group RAM -expand -group RamOut -color Gold /bus_controller_tb/DUT/ccif/ramstate
add wave -noupdate -expand -group CCIF -expand -group RAM -expand -group RamOut -color Gold /bus_controller_tb/DUT/ccif/ramload
add wave -noupdate -expand -group CCIF -expand -group RAM -expand -group RamIn -color Gold /bus_controller_tb/DUT/ccif/ramWEN
add wave -noupdate -expand -group CCIF -expand -group RAM -expand -group RamIn -color Gold /bus_controller_tb/DUT/ccif/ramREN
add wave -noupdate -expand -group CCIF -expand -group RAM -expand -group RamIn -color Gold -radix hexadecimal /bus_controller_tb/DUT/ccif/ramaddr
add wave -noupdate -expand -group CCIF -expand -group RAM -expand -group RamIn -color Gold -radix hexadecimal /bus_controller_tb/DUT/ccif/ramstore
add wave -noupdate -divider {New Divider}
add wave -noupdate -expand -group STATES /bus_controller_tb/DUT/s
add wave -noupdate -expand -group STATES /bus_controller_tb/DUT/nS
add wave -noupdate -expand -group {dirty and valid bits} /bus_controller_tb/DUT/buswr1
add wave -noupdate -expand -group {dirty and valid bits} /bus_controller_tb/DUT/buswr0
add wave -noupdate -expand -group {dirty and valid bits} /bus_controller_tb/DUT/busrd1
add wave -noupdate -expand -group {dirty and valid bits} /bus_controller_tb/DUT/busrd0
add wave -noupdate -expand -group {dirty and valid bits} /bus_controller_tb/DUT/write1
add wave -noupdate -expand -group {dirty and valid bits} /bus_controller_tb/DUT/write0
add wave -noupdate -expand -group {dirty and valid bits} /bus_controller_tb/DUT/trans1
add wave -noupdate -expand -group {dirty and valid bits} /bus_controller_tb/DUT/trans0
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {255279 ps} 0}
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
WaveRestoreZoom {114544 ps} {400920 ps}
