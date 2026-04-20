# Makefile
# See https://docs.cocotb.org/en/stable/quickstart.html for more info

# defaults
SIM ?= icarus
FST ?= -fst # Use more efficient FST format
TOPLEVEL_LANG ?= verilog
SRC_DIR = $(PWD)/../src
PROJECT_SOURCES = tt_um_dream_risc_v_top.v adbg_config.sv apb_bus.sv axi_bus.sv cluster_clock_gating.sv cluster_clock_inverter.sv cluster_clock_mux2.sv config.sv core_top.sv debug_bus.sv zeroriscy_alu.sv zeroriscy_compressed_decoder.sv zeroriscy_config.sv zeroriscy_controller.sv zeroriscy_core.sv zeroriscy_cs_registers.sv zeroriscy_debug_unit.sv zeroriscy_decoder.sv zeroriscy_defines.sv zeroriscy_ex_block.sv zeroriscy_fetch_fifo.sv zeroriscy_id_stage.sv zeroriscy_if_stage.sv zeroriscy_int_controller.sv zeroriscy_load_store_unit.sv zeroriscy_multdiv_fast.sv zeroriscy_multdiv_slow.sv zeroriscy_prefetch_buffer.sv zeroriscy_register_file_ff.sv

ifneq ($(GATES),yes)

# RTL simulation:
SIM_BUILD				= sim_build/rtl
VERILOG_SOURCES += $(addprefix $(SRC_DIR)/,$(PROJECT_SOURCES))

else

# Gate level simulation:
SIM_BUILD				= sim_build/gl
COMPILE_ARGS    += -DGL_TEST
COMPILE_ARGS    += -DFUNCTIONAL
COMPILE_ARGS    += -DUSE_POWER_PINS
COMPILE_ARGS    += -DSIM
COMPILE_ARGS    += -DUNIT_DELAY=\#1
VERILOG_SOURCES += $(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/verilog/primitives.v
VERILOG_SOURCES += $(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v

# this gets copied in by the GDS action workflow
VERILOG_SOURCES += $(PWD)/gate_level_netlist.v

endif

# Allow sharing configuration between design and testbench via `include`:
COMPILE_ARGS 		+= -I$(SRC_DIR)

# Include the testbench sources:
VERILOG_SOURCES += $(PWD)/tb.v
TOPLEVEL = tb

# List test modules to run, separated by commas and without the .py suffix:
COCOTB_TEST_MODULES = test

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim
