#***************************************************#
# Clean Work Library
#***************************************************#
if [file exists "work"] {vdel -all}
vlib work

#***************************************************#
# Start a new Transcript File
#***************************************************#
#transcript file log/fifo_run_log.log
# better make one for each test

#***************************************************#
# Compile RTL and TB files
#***************************************************#
vlog -f add_sub_dut.f
vlog -f add_sub_tb.f

#***************************************************#
# Optimizing Design with vopt
#***************************************************#
vopt add_sub_top -o top_opt -debugdb  +acc +cover=sbecf+Add_Sub(rtl).

#***************************************************#
# Simulation of a Test
#***************************************************#
#********************************** RANDOM TEST ***********************************#
transcript file log/add_sub_config.log
vsim top_opt -c -assertdebug -debugDB -fsmdebug -coverage +UVM_TESTNAME=add_sub_random_test
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all
coverage attribute -name TESTNAME -value add_sub_config
coverage save coverage/add_sub_config.ucdb


#***************************************************#
# Close the Transcript file
#***************************************************#
transcript file ()


#***************************************************#
# save the coverage in text files
#***************************************************#

vcover report coverage/add_sub_config.ucdb -details -assert  -output coverage/assertions.txt
vcover report coverage/add_sub_config.ucdb  -output coverage/code_coverage.txt