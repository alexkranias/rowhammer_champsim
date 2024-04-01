#!/bin/bash

# Create log_results directory if it doesn't exist
mkdir -p log_results

# Define the list of trace files to select from
tests=("602.gcc_s-1850B.champsimtrace.xz" "603.bwaves_s-2931B.champsimtrace.xz" "605.mcf_s-994B.champsimtrace.xz" "607.cactuBSSN_s-2421B.champsimtrace.xz"
       "620.omnetpp_s-141B.champsimtrace.xz" "621.wrf_s-6673B.champsimtrace.xz" "623.xalancbmk_s-592B.champsimtrace.xz" "628.pop2_s-17B.champsimtrace.xz"
       "649.fotonik3d_s-10881B.champsimtrace.xz" "654.roms_s-1007B.champsimtrace.xz")

# Print the selected traces
echo "Selected traces:"
for trace_file in "${tests[@]}"
do
    echo "$trace_file"
done

# Iterate over the selected traces
for trace_file in "${tests[@]}"
do
    # Set output log file path
    output_log="log_results/new_out_${trace_file}.log"

    # Run the command with different trace files and log outputs
    nohup bin/8C_16WLLC --warmup_instructions 50000000 --simulation_instructions 200000000 -traces "/trace2/ChampSim/dpc3/$trace_file" a > "$output_log" &
done