set link_library {* lsi_10k.db dw_foundation.sldb}
set target_library {lsi_10k.db}
analyze –format sverilog { fifo.v router.v port.v }
elaborate router
create_clock clk -period 25
set_max_area 25000
set_input_delay -clock clk 0 [all_inputs]
set_output_delay -clock clk 0 [all_outputs]
compile
report_area
report_timing
write -f verilog -hier -out gate.v