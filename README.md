# RVM Compiler Project

This repo contains code, materials, documentation for my project on writing software for the RISC-V Matrix accelerator (RVM) integrated into the X-HEEP. 
The primary resource for this ISA extension, holding the specification and all the toolchain components, [is hosted on github](https://github.com/esl-epfl/xheep_matrix_spec/tree/main). Meanwhile, the X-HEEP hardware (and versions of the software designed to run specifically in the X-HEEP environment rather than simulation) is in its own repo. This repo serves more to document specific software case studies.

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

This will clone the repo `optitrust-rvm` in `src/`.  Next, build the docker image. I am assuming you have access to docker as your own user. For this you generally need to add yourself to the docker group (`sudo usermod -aG docker <your-user>`). Don't just run the following commands as sudo, otherwise you'll have to run all the `lit` tests as sudo as well and it will be a mess.

```bash
cd src/optitrust-rvm
./build-docker.sh
```

While still in the same directory, you can do `./run-docker.sh case_studies/conv1d/conv1d.ml` to make sure things are working as intended.

### LLVM tools

These are needed for the `lit` unit tests below. The easiest way to get `lit` is through the package manager. Make sure you are in the python environment setup earlier:

```
pip install lit
```

For `FileCheck`, it is easiest get it from [LLVM build directory](src/optitrust-rvm/case_studies/conv1d/conv1d.ml) you set up earlier. Copy the `FileCheck` binary in the `bin/` folder to somewhere in your path, e.g.

```bash
cd ~/work/xheep_matrix_spec/temp/llvm-build/ # just an example
cp bin/FileCheck $RISCV/bin/
```

### Makefile

The makefile in the root of this repo contains a number of automated tests. The first is just a simple "integration test" for the convolution routine that makes sure that both the handwritten and Exo versions of the code produce the same output as the expected value (generated by a Python script). The target is `make conv1d_integration`. 
**This assumes you have $RISCV/bin in $PATH, or wherever your tools are installed from the first step!**
Here is what you could expect the output to look like.

```bash
$ make conv1d_integration
make[1]: Entering directory '/home/julien/EPFL/SystemF/rvm_compiler_project/src/conv1d'
make[1]: '/home/julien/EPFL/SystemF/rvm_compiler_project/out/conv1d.elf' is up to date.
make[1]: Leaving directory '/home/julien/EPFL/SystemF/rvm_compiler_project/src/conv1d'
handwritten err: 0
exo err: 0
2350 ticks
93797 cycles
93799 instructions
0.99 CPI
```

Next, there are a number of tests using the LLVM unit test tool `lit`, to make sure that the output from the tools lines up with what I have locally. I assume that you have installed the requisite tools in the previous step and that they are available in `$PATH`. The target is `make lit_tests`. You should see an output like this:

```bash 
$ make lit_tests
lit src/conv1d/exo/conv1d.py \
        src/optitrust-rvm/case_studies/conv1d/conv1d.ml -v
-- Testing: 2 tests, 2 workers --
PASS: RVM Tests :: src/optitrust-rvm/case_studies/conv1d/conv1d.ml (1 of 2)
PASS: RVM Tests :: src/conv1d/exo/conv1d.py (2 of 2)

Testing Time: 3.39s

Total Discovered Tests: 2
  Passed: 2 (100.00%)
```

If there are problems, `lit` should print out what wrong executing the test.

