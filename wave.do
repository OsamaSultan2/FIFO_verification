onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group clk/rst_n -color Gold /top/ifc/clk
add wave -noupdate -expand -group clk/rst_n -color Gold /top/ifc/rst_n
add wave -noupdate -expand -group inputs -color Cyan /top/ifc/wr_en
add wave -noupdate -expand -group inputs -color Cyan /top/ifc/rd_en
add wave -noupdate -expand -group inputs -color Cyan -radix unsigned /top/ifc/data_in
add wave -noupdate -expand -group outputs -radix unsigned /top/ifc/data_out
add wave -noupdate -expand -group outputs /top/ifc/wr_ack
add wave -noupdate -expand -group outputs /top/ifc/overflow
add wave -noupdate -expand -group outputs /top/ifc/underflow
add wave -noupdate -expand -group outputs /top/ifc/empty
add wave -noupdate -expand -group outputs /top/ifc/almostfull
add wave -noupdate -expand -group outputs /top/ifc/almostempty
add wave -noupdate -expand -group outputs /top/ifc/full
add wave -noupdate -expand -group reference -color Magenta -radix unsigned /top/monitor/scoreboard.data_out_ref
add wave -noupdate -expand -group reference -color Magenta /top/monitor/scoreboard.wr_ack_ref
add wave -noupdate -expand -group reference -color Magenta /top/monitor/scoreboard.overflow_ref
add wave -noupdate -expand -group reference -color Magenta /top/monitor/scoreboard.full_ref
add wave -noupdate -expand -group reference -color Magenta /top/monitor/scoreboard.empty_ref
add wave -noupdate -expand -group reference -color Magenta /top/monitor/scoreboard.almostfull_ref
add wave -noupdate -expand -group reference -color Magenta /top/monitor/scoreboard.almostempty_ref
add wave -noupdate -expand -group reference -color Magenta /top/monitor/scoreboard.underflow_ref
add wave -noupdate /top/monitor/cov_collect.F_cvg_txn.full
add wave -noupdate /top/RESET_OUT_CHK
add wave -noupdate /top/DUT/WR_ACK_CHK
add wave -noupdate /top/DUT/OVERFLOW_CHK
add wave -noupdate /top/DUT/UNDERFLOW_CHK
add wave -noupdate /top/DUT/FULL_CHK
add wave -noupdate /top/DUT/EMPTY_CHK
add wave -noupdate /top/DUT/ALMOST_FULL_CHK
add wave -noupdate /top/DUT/ALMOST_EMPTY_CHK
add wave -noupdate /top/DUT/WR_WRAP
add wave -noupdate /top/DUT/RD_WRAP
add wave -noupdate /top/DUT/THRESHOLD
add wave -noupdate /top/DUT/RESET_CHK/ASNYC_RST
add wave -noupdate /top/monitor/cov_collect.F_cvg_txn.wr_en
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {299971 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 309
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
WaveRestoreZoom {0 ns} {73 ns}
