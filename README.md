# START: Scalable Tracking for Any Rowhammer Threshold

This repository is part of the evaluation artifact for the [START](https://arxiv.org/abs/2308.14889) paper, which will appear at [HPCA 2024](https://www.hpca-conf.org/2024/). 

## Introduction

Experiments in the START paper are conducted using [ChampSim](https://github.com/ChampSim/ChampSim), a cycle-level multi-core simulator, interfaced with [DRAMSim3](https://github.com/umd-memsys/DRAMsim3), a detailed memory system simulator. The trace download and jobfile management is borrowed from the infrastructure used in [Pythia](https://github.com/CMU-SAFARI/Pythia). Accordingly, the code and experimentation framework of START has been partitioned into 3 repositories for modularity. 

This repository hosts the ChampSim simulator codebase for START, Hydra, and Ideal trackers using victim-refresh mitigation with configurable blast-radius. 

**NOTE:** The documentation is common across all 3 repositories, so feel free to start here.

## System Requirements

   - **SW Dependencies** 
     - Tested with cmake XYZ, g++ XYZ, md5sum XYZ, perl XYZ, megatools 1.11.0, and Python XYZ.
   - **Benchmark Dependencies** 
     - Publicly available ChampSim-compatible traces of SPEC2017, LIGRA, PARSEC, and CloudSuite workloads.
   - **HW Dependencies** 
     - A scale-out system like many-core server or HPC cluster.
     - Our experiments were performed on the [PACE](https://pace.gatech.edu) cluster at Georgia Tech.
     - Most configurations run simulations for 28 workloads for about 6 hours on average (with one workload per core).
     - Overall, there are 48 configurations, requiring about 8,900 core-hours to replicate all results (about 1-2 days on four 64-core servers).

**NOTE:** If compute resources are limited, we consider the key results of the paper to be those displayed in Figure 6 and Figure 16, which correspond to 9 configurations, requiring about 2,000 core-hours (about 1-2 days on a 64-core server).

## Compilation Steps

The expected directory structure is:

```
start_hpca24_ae
|-dramsim3
|-champsim
|-experiments
```

* `mkdir start_hpca24_ae`

### Build DRAMSim3

* `git clone https://github.com/Anish-Saxena/rowhammer_dramsim3 dramsim3`
* `cd dramsim3`
* `mkdir build && cd build && cmake ..`
* `make -j8`
* `cd ..`

### Setup ChampSim Build Environment

* `git clone https://github.com/Anish-Saxena/rowhammer_champsim champsim`
* `cd champsim`
*  `./set_paths.sh`

### Compile One Configuration for Testing

* `./config.py configs/8C_16W.json`
* `make -j8`
* `cd ..`

Ensure that the compilation completes without error. 

**Common Error**: The compiler may not be able to link the dramsim3 library. If so, check that the path is correctly set in `config.py` (search for LDLIBS). 

### Download Traces

* `git clone https://github.com/Anish-Saxena/rowhammer_pythia experiments`
* `cd experiments`
* `source setvars.sh`
* `mkdir traces`
* `cd scripts/`
* `perl download_traces.pl --csv START_traces.csv --dir ../traces/`
* `cd ../traces/`
* `md5sum -c ../scripts/START_traces.md5`
* `cd ../../`

The 44 traces might take an hour or more to download, depending both on the host network bandwidth and bandwidth allocation provided by Megatools (for LIGRA and PARSEC traces). Ensure that the checksum passes for all traces.

**Common Error**: If Megatools does not work, download the latest megatools utility for the relevant platform from [Megatools Builds](https://megatools.megous.com/builds/builds/), untar it (`tar -xvf <filename`), and update the `megatool_exe` parameter in `download_traces.pl`.

### Update LD_LIBARY_PATH

DRAMSim3 is loaded as a dynamically linked library and requires updating `LD_LIBRARY_PATH` variable. We recommend appending the updated variable to `bashrc` as well as all job-files used to launch experiments.

- Update `LD_LIBRARY_PATH` in current terminal session: `export LD_LIBRARY_PATH=<path-to-dramsim3-directory>:$LD_LIBRARY_PATH`
- Append updated variable to bashrc: `echo "export LD_LIBRARY_PATH=<path-to-dramsim3-directory>:$LD_LIBRARY_PATH" >> ~/.bashrc`

### Test Setup with Dummy Run

* `cd champsim/bin/`
* `./8C_16WLLC --simulation_instruction=100000 --warmup_instructions=1000000 -traces $PYTHIA_HOME/traces/602.gcc_s-1850B.champsimtrace.xz`

Running this trace for 100K warmup and 100K simulation instructions should take about a minute. Ensure that the simulation completes successfully (you will see simulation statistics in stdout).

**Common Error:** If the loader is unable to find the dramsim3 library, please ensure the updated `LD_LIBRARY_PATH` variable is available in the execution environment (like, if srun-like commands are used). A simple workaround is to create a script that exports this variable and then runs the executable. 
