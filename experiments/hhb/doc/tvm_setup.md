Following steps assume you have the RISCV toolchain already set up and in the PATH. 
`$SF_ROOT` points to some directory that you are using to install things for the project, I personally have the riscv toolchain under $SF_ROOT/opt/xuantie-gnu-toolchain/ so that is why you will see the paths in the steps below. I have also set the variable $RISCV to this path, which is referenced in the steps.

# T-HEAD TVM stack install 
based on https://www.yuque.com/za4k4z/kvkcoh/si807e7x7efgbccx

Make sure you are in the same source directory when cloning these repos. TVM's script is hardcoded to reference csi-nn2 one directory above. So you should have `src/{csi-nn2, tvm}`.

* Clone csi-nn2
	* `git clone -b matrix-extension --recursive https://github.com/T-head-Semi/csi-nn2.git`
	* Edit Makefile: Comment out: `-cp csky_build/libshl_* install_nn2/lib -rf`
* Install TVM
	* Clone repo
		* `git clone -b matrix-extension --recursive https://github.com/T-head-Semi/tvm.git`
	* Build CSI-NN2
		* Modify `scripts/build_csi.sh` so it has this in the main section:
		 ```
		make nn2_ref_x86
		make nn2_rvm
		make install_nn2
		```
		* run the script
	* Build C++ code
		* Need these deps according to yuque guide:
			* `sudo apt-get install -y python3 python3-dev python3-setuptools gcc libtinfo-dev zlib1g-dev build-essential cmake libedit-dev libxml2-dev llvm`
		* `cd tvm`
		* `mkdir build`
		* `cd build`
		* `cp ../cmake/config.cmake .`
		* `cmake ..`
		* `make -j$(nproc)`
	 * Build python packages
		 * Go to `python` directory inside tvm
		 * Change `setup.py` line 228 to `__version__ = "2.1.0"`
		 * `python3 setup.py bdist_wheel --plat-name=manylinux1_x86_64`
		 * `pip install dist/*.whl`
		 * Go out one directory to `thead`
		 * Change setup.py line 23 to `__version__ = "2.1.0"`
		 * `python3 setup.py bdist_wheel`
		 * `pip install dist/*.whl`
	 * Install CSI-NN2
		 * Go out of TVM directory and into cloned csi-nn2 dir
		 * There should be an `install_nn2` directory created from building it earlier
		 * Copy `lib/`  and `include/` inside the install directory to $RISCV 

if HHB gives GLIBCXX error when running:
```
sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
sudo apt install -y g++-11
```
# install zlib, libpng, libjpeg

* Download latest source archives (links not provided, this is all very stable slow-moving software)

* Configure line for zlib, libpng, libjpeg
```
CHOST=riscv64 CC=$SF_ROOT/opt/xuantie-riscv-toolchain/bin/riscv64-unknown-linux-gnu-gcc LDFLAGS=-L$SF_ROOT/opt/xuantie-riscv-toolchain/lib/ CPPFLAGS=-I$SF_ROOT/opt/xuantie-riscv-toolchain/include/ CFLAGS=-I$SF_ROOT/opt/xuantie-riscv-toolchain/include/  ./configure --prefix=$SF_ROOT/opt/xuantie-riscv-toolchain/ --host=riscv64-unknown-linux-gnu
```
(drop the --host option for zlib)

* `make`, `make install` as usual, for jpeg also do `make install-lib`


```
riscv64-unknown-linux-gnu-gcc -O0 -g3 -march=rv64gcv_zfh_xtheadc -mabi=lp64d -I$SF_ROOT/opt/xuantie-riscv-toolchain/include -o c_runtime  main.c model.c io.c process.c -L$SF_ROOT/opt/xuantie-riscv-toolchain/lib -ljpeg -lpng -lz -lstdc++ -lshl_rvm -lm -static -Wl,--gc-sections
```

