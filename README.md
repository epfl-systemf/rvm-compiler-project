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

## Building

Start with the instructions in the xheep_matrix_spec repo: https://github.com/esl-epfl/xheep_matrix_spec/blob/main/BUILDING.md. I will assume you have completed this and your tools are located at `$RISCV`.

### TVM & Exo

Two of the tools I used, TVM and Exo, have specific Python version constraints. This makes 3.9 and 3.10 some of the only Python versions that work with both. I suggest Python 3.10, and using [Miniforge](https://github.com/conda-forge/miniforge) to keep a separate environment. With miniforge installed and activated in the shell (`(base)` prefix in the prompt), run a command like this to make the environment:

```bash
mamba create -n rvm python=3.10
```

Next, activate and install the `requirements.txt` from this repo:

```bash
conda activate rvm
pip install -r requirements.txt
```

This will install the specific versions of TVM & Exo we have used in the project.
If these are the only tools you are interested in, skip the next section and jump directly to [Makefile](#makefile) to see how to build the code in this repo.

### OptiTrust

This section discusses setting up OptiTrust, another tool that was investigated. It relies on a number of OCaml dependencies so I have opted to give it a docker image for testing. However, OptiTrust has a number of interactive features that are awkward to use if it is setup in a container (for example opening the diff for a rewrite in the browser from VS Code.) If you want use these features, I suggest that you attempt set it up locally, following the [upstream setup documentation](https://github.com/charguer/optitrust).

First, make sure you have either cloned this repo recurisvely (`git clone --recursive`) or initialized all submodules (in the repo directory, once cloned):

```bash
git submodule init
git submodule update
```

This will clone the repo `optitrust-rvm` in `src/`. 

### Makefile

