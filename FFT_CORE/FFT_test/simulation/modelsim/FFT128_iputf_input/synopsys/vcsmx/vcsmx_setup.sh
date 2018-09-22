
cp -f E:/Kolya/logic2/Spring2018_CMPN111/IP_Catalog/FFT_test/FFT/simulation/submodules/FFT_fft_ii_0_1n128cos.hex ./
cp -f E:/Kolya/logic2/Spring2018_CMPN111/IP_Catalog/FFT_test/FFT/simulation/submodules/FFT_fft_ii_0_2n128cos.hex ./
cp -f E:/Kolya/logic2/Spring2018_CMPN111/IP_Catalog/FFT_test/FFT/simulation/submodules/FFT_fft_ii_0_1n128sin.hex ./
cp -f E:/Kolya/logic2/Spring2018_CMPN111/IP_Catalog/FFT_test/FFT/simulation/submodules/FFT_fft_ii_0_2n128sin.hex ./
cp -f E:/Kolya/logic2/Spring2018_CMPN111/IP_Catalog/FFT_test/FFT/simulation/submodules/FFT_fft_ii_0_3n128cos.hex ./
cp -f E:/Kolya/logic2/Spring2018_CMPN111/IP_Catalog/FFT_test/FFT/simulation/submodules/FFT_fft_ii_0_3n128sin.hex ./

vhdlan -xlrm          "E:/Kolya/logic2/Spring2018_CMPN111/IP_Catalog/FFT_test/FFT/simulation/submodules/auk_dspip_text_pkg.vhd"                    -work fft_ii_0
vhdlan -xlrm          "E:/Kolya/logic2/Spring2018_CMPN111/IP_Catalog/FFT_test/FFT/simulation/submodules/auk_dspip_math_pkg.vhd"                    -work fft_ii_0
vhdlan -xlrm          "E:/Kolya/logic2/Spring2018_CMPN111/IP_Catalog/FFT_test/FFT/simulation/submodules/auk_dspip_lib_pkg.vhd"                     -work fft_ii_0
vhdlan -xlrm          "E:/Kolya/logic2/Spring2018_CMPN111/IP_Catalog/FFT_test/FFT/simulation/submodules/auk_dspip_roundsat.vhd"                    -work fft_ii_0
vhdlan -xlrm          "E:/Kolya/logic2/Spring2018_CMPN111/IP_Catalog/FFT_test/FFT/simulation/submodules/auk_dspip_avalon_streaming_sink.vhd"       -work fft_ii_0
vhdlan -xlrm          "E:/Kolya/logic2/Spring2018_CMPN111/IP_Catalog/FFT_test/FFT/simulation/submodules/auk_dspip_avalon_streaming_source.vhd"     -work fft_ii_0
vhdlan -xlrm          "E:/Kolya/logic2/Spring2018_CMPN111/IP_Catalog/FFT_test/FFT/simulation/submodules/auk_dspip_avalon_streaming_controller.vhd" -work fft_ii_0
vlogan +v2k -sverilog "E:/Kolya/logic2/Spring2018_CMPN111/IP_Catalog/FFT_test/FFT/simulation/submodules/FFT_fft_ii_0.sv"                           -work fft_ii_0
vhdlan -xlrm          "E:/Kolya/logic2/Spring2018_CMPN111/IP_Catalog/FFT_test/FFT/simulation/FFT.vhd"                                                            
