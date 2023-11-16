This repository is part of the evaluation artifact for [START](https://arxiv.org/abs/2308.14889), a Sclable Tracker for Any Rowhammer Threshold, which will appear at [HPCA 2024](https://www.hpca-conf.org/2024/). 

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

### Build ChampSim3

* `git clone https://github.com/Anish-Saxena/rowhammer_champsim champsim`
* `cd champsim`
*  `./set_paths.sh`

