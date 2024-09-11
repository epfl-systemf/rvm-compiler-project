# RVM Compiler Project

This repo contains code, materials, documentation for my project on writing software for the RISC-V Matrix accelerator (RVM) integrated into the X-HEEP. 
The primary resource for this ISA extension, holding the specification and all the toolchain components, [is hosted on github](https://github.com/esl-epfl/xheep_matrix_spec/tree/main). This repo serves more to document specific software case studies.

## Organization

* `src/`: the main code for this project, which includes several versions of a convolution routine written in different tools:
    * `src/conv1d/main.c`: hand-optimized routine
    * `src/conv1d/exo/`: Exo files to generate C
    * `src/optitrust-rvm/case_studies/conv1d/`: (in a git submodule) ocaml script to optimize routine from plain C with OptiTrust, though not fully working (see report)
* `experiments/`: various test files for different tools, not forming any 
* `report/`: technical report for the project
* `presentation/`: my presentation for the project along w/ code snippets I presented
