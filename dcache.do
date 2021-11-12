onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dcache_tb/CLK
add wave -noupdate /dcache_tb/nRST
add wave -noupdate -expand -group {to memory controller} /dcache_tb/cdif/dwait
add wave -noupdate -expand -group {to memory controller} /dcache_tb/cdif/dREN
add wave -noupdate -expand -group {to memory controller} /dcache_tb/cdif/ccsnoopaddr
add wave -noupdate -expand -group {to memory controller} /dcache_tb/cdif/dWEN
add wave -noupdate -expand -group {to memory controller} /dcache_tb/cdif/dload
add wave -noupdate -expand -group {to memory controller} /dcache_tb/cdif/dstore
add wave -noupdate -expand -group {to memory controller} /dcache_tb/cdif/daddr
add wave -noupdate -expand -group {to memory controller} /dcache_tb/cdif/ccwait
add wave -noupdate -expand -group {to memory controller} /dcache_tb/cdif/ccinv
add wave -noupdate -expand -group {to memory controller} /dcache_tb/cdif/ccwrite
add wave -noupdate -expand -group {to memory controller} /dcache_tb/cdif/cctrans
add wave -noupdate -expand -group {from datapath} /dcache_tb/dcif/halt
add wave -noupdate -expand -group {from datapath} /dcache_tb/dcif/ihit
add wave -noupdate -expand -group {from datapath} /dcache_tb/dcif/imemREN
add wave -noupdate -expand -group {from datapath} /dcache_tb/dcif/imemload
add wave -noupdate -expand -group {from datapath} /dcache_tb/dcif/imemaddr
add wave -noupdate -expand -group {from datapath} /dcache_tb/dcif/dhit
add wave -noupdate -expand -group {from datapath} /dcache_tb/dcif/datomic
add wave -noupdate -expand -group {from datapath} /dcache_tb/dcif/dmemREN
add wave -noupdate -expand -group {from datapath} /dcache_tb/dcif/dmemWEN
add wave -noupdate -expand -group {from datapath} /dcache_tb/dcif/flushed
add wave -noupdate -expand -group {from datapath} /dcache_tb/dcif/dmemload
add wave -noupdate -expand -group {from datapath} /dcache_tb/dcif/dmemstore
add wave -noupdate -expand -group {from datapath} /dcache_tb/dcif/dmemaddr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {13 ns} 0}
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
WaveRestoreZoom {0 ns} {54 ns}
