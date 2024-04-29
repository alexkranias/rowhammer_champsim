#!/bin/bash

# Create log_results directory if it doesn't exist
mkdir -p log_results

spec_base_dir="/trace2/ChampSim/dpc3"
parsec_base_dir="/trace2/ChampSim/parsec/PARSEC-2.1"
ligra_base_dir="/trace2/ChampSim/ligra"

spec_tests=("600.perlbench_s-210B.champsimtrace.xz" "602.gcc_s-1850B.champsimtrace.xz" "603.bwaves_s-2931B.champsimtrace.xz" "605.mcf_s-994B.champsimtrace.xz" "607.cactuBSSN_s-2421B.champsimtrace.xz" "619.lbm_s-2677B.champsimtrace.xz"
            "620.omnetpp_s-141B.champsimtrace.xz" "621.wrf_s-6673B.champsimtrace.xz" "623.xalancbmk_s-592B.champsimtrace.xz" "625.x264_s-20B.champsimtrace.xz" "627.cam4_s-490B.champsimtrace.xz" "628.pop2_s-17B.champsimtrace.xz"
            "631.deepsjeng_s-928B.champsimtrace.xz" "638.imagick_s-824B.champsimtrace.xz" "641.leela_s-800B.champsimtrace.xz" "644.nab_s-7928B.champsimtrace.xz" "648.exchange2_s-1247B.champsimtrace.xz" "649.fotonik3d_s-10881B.champsimtrace.xz"
            "654.roms_s-1007B.champsimtrace.xz" "657.xz_s-3167B.champsimtrace.xz")

parsec_tests=("parsec_2.1.blackscholes.simlarge.prebuilt.drop_3000M.length_250M.champsimtrace.xz" "parsec_2.1.bodytrack.simlarge.prebuilt.drop_3500M.length_250M.champsimtrace.xz"
              "parsec_2.1.canneal.simlarge.prebuilt.drop_4500M.length_250M.champsimtrace.xz" "parsec_2.1.dedup.simlarge.prebuilt.drop_7250M.length_250M.champsimtrace.xz"
              "parsec_2.1.facesim.simlarge.prebuilt.drop_1500M.length_250M.champsimtrace.xz" "parsec_2.1.fluidanimate.simlarge.prebuilt.drop_9500M.length_250M.champsimtrace.xz"
              "parsec_2.1.raytrace.simlarge.prebuilt.drop_23500M.length_250M.champsimtrace.xz" "parsec_2.1.streamcluster.simlarge.prebuilt.drop_14750M.length_250M.champsimtrace.xz"
              "parsec_2.1.swaptions.simlarge.prebuilt.drop_5250M.length_250M.champsimtrace.xz" "parsec_2.1.vips.simlarge.prebuilt.drop_27250M.length_250M.champsimtrace.xz")

ligra_tests=("ligra_BellmanFord.com-lj.ungraph.gcc_6.3.0_O3.drop_7500M.length_250M.champsimtrace.xz" "ligra_BFS-Bitvector.com-lj.ungraph.gcc_6.3.0_O3.drop_23000M.length_250M.champsimtrace.xz"
             "ligra_BFSCC.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M.champsimtrace.xz" "ligra_BFS.com-lj.ungraph.gcc_6.3.0_O3.drop_21500M.length_250M.champsimtrace.xz"
             "ligra_CF.com-lj.ungraph.gcc_6.3.0_O3.drop_184750M.length_250M.champsimtrace.xz" "ligra_Components.com-lj.ungraph.gcc_6.3.0_O3.drop_22750M.length_250M.champsimtrace.xz"
             "ligra_Components-Shortcut.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M.champsimtrace.xz" "ligra_MIS.com-lj.ungraph.gcc_6.3.0_O3.drop_21250M.length_250M.champsimtrace.xz"
             "ligra_PageRank.com-lj.ungraph.gcc_6.3.0_O3.drop_21750M.length_250M.champsimtrace.xz" "ligra_PageRankDelta.com-lj.ungraph.gcc_6.3.0_O3.drop_24000M.length_250M.champsimtrace.xz"
             "ligra_Radii.com-lj.ungraph.gcc_6.3.0_O3.drop_32000M.length_250M.champsimtrace.xz" "ligra_Triangle.com-lj.ungraph.gcc_6.3.0_O3.drop_25000M.length_250M.champsimtrace.xz")

# Iterate over the selected traces for each type of test
for trace_file in "${spec_tests[@]}"
do
    echo "$trace_file"
    # Set output log file path
    output_log="log_results/${trace_file}.log"

    # Run the command with different trace files and log outputs
    nohup bin/8C_16WLLC --warmup_instructions 50000000 --simulation_instructions 200000000 -traces "$spec_base_dir/$trace_file" a > "$output_log" &
done

for trace_file in "${parsec_tests[@]}"
do
    echo "$trace_file"
    # Set output log file path
    output_log="log_results/${trace_file}.log"

    # Run the command with different trace files and log outputs
    nohup bin/8C_16WLLC --warmup_instructions 50000000 --simulation_instructions 200000000 -traces "$parsec_base_dir/$trace_file" a > "$output_log" &
done

for trace_file in "${ligra_tests[@]}"
do
    echo "$trace_file"
    # Set output log file path
    output_log="log_results/${trace_file}.log"

    # Run the command with different trace files and log outputs
    nohup bin/8C_16WLLC --warmup_instructions 50000000 --simulation_instructions 200000000 -traces "$ligra_base_dir/$trace_file" a > "$output_log" &
done
