onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fft128_tb/FFT_ins/Clk
add wave -noupdate /fft128_tb/FFT_ins/Rst
add wave -noupdate /fft128_tb/FFT_ins/state_reg
add wave -noupdate /fft128_tb/FFT_ins/state_next
add wave -noupdate /fft128_tb/FFT_ins/sink_ready
add wave -noupdate /fft128_tb/FFT_ins/sink_valid
add wave -noupdate /fft128_tb/FFT_ins/rden_sig
add wave -noupdate /fft128_tb/FFT_ins/sink_sop
add wave -noupdate /fft128_tb/FFT_ins/sink_eop
add wave -noupdate -radix unsigned /fft128_tb/FFT_ins/address_sig
add wave -noupdate -radix unsigned /fft128_tb/FFT_ins/sink_real
add wave -noupdate -radix unsigned /fft128_tb/FFT_ins/sink_imag
add wave -noupdate /fft128_tb/FFT_ins/wren_sig
add wave -noupdate /fft128_tb/FFT_ins/sink_error
add wave -noupdate /fft128_tb/FFT_ins/inverse
add wave -noupdate /fft128_tb/FFT_ins/source_imag
add wave -noupdate /fft128_tb/FFT_ins/source_real
add wave -noupdate /fft128_tb/FFT_ins/source_ready
add wave -noupdate /fft128_tb/FFT_ins/source_sop
add wave -noupdate /fft128_tb/FFT_ins/source_eop
add wave -noupdate /fft128_tb/FFT_ins/source_valid
add wave -noupdate /fft128_tb/FFT_ins/source_exp
add wave -noupdate /fft128_tb/FFT_ins/source_error
add wave -noupdate /fft128_tb/FFT_ins/Clk
add wave -noupdate /fft128_tb/FFT_ins/Rst
add wave -noupdate /fft128_tb/FFT_ins/state_reg
add wave -noupdate /fft128_tb/FFT_ins/state_next
add wave -noupdate /fft128_tb/FFT_ins/rden_sig
add wave -noupdate /fft128_tb/FFT_ins/sink_ready
add wave -noupdate /fft128_tb/FFT_ins/sink_valid
add wave -noupdate /fft128_tb/FFT_ins/sink_sop
add wave -noupdate -radix unsigned /fft128_tb/FFT_ins/address_sig
add wave -noupdate -radix unsigned /fft128_tb/FFT_ins/sink_real
add wave -noupdate -radix unsigned /fft128_tb/FFT_ins/sink_imag
add wave -noupdate /fft128_tb/FFT_ins/data_sig_img
add wave -noupdate /fft128_tb/FFT_ins/data_sig_real
add wave -noupdate /fft128_tb/FFT_ins/wren_sig
add wave -noupdate /fft128_tb/FFT_ins/sink_error
add wave -noupdate /fft128_tb/FFT_ins/inverse
add wave -noupdate /fft128_tb/FFT_ins/sink_eop
add wave -noupdate -radix unsigned /fft128_tb/FFT_ins/source_imag
add wave -noupdate -radix unsigned /fft128_tb/FFT_ins/source_real
add wave -noupdate /fft128_tb/FFT_ins/source_ready
add wave -noupdate /fft128_tb/FFT_ins/source_sop
add wave -noupdate /fft128_tb/FFT_ins/source_eop
add wave -noupdate /fft128_tb/FFT_ins/source_valid
add wave -noupdate /fft128_tb/FFT_ins/source_exp
add wave -noupdate /fft128_tb/FFT_ins/source_error
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {119217 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 112
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
WaveRestoreZoom {0 ps} {262500 ps}
