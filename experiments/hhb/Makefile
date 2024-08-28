OUT = out
IMG = data/cat.jpg
QEMU_ARGS = -cpu rv64,x-v=true,vext_spec=v1.0,vlen=128,x-matrix=on,rlen=128 $(OUT)/c_runtime $(OUT)/hhb.bm $(OUT)/input.0.bin

.PHONY: run build clean model $(OUT)/c_runtime

run: $(OUT)/c_runtime
	qemu-riscv64 $(QEMU_ARGS)

run_dbg: $(OUT)/c_runtime
	qemu-riscv64 -g 2828 $(QEMU_ARGS) &
	riscv64-unknown-linux-gnu-gdb $< -ex "target remote 127.0.0.1:2828"

build: $(OUT)/c_runtime

$(OUT)/c_runtime:
	@mkdir -p $(OUT)
	riscv64-unknown-linux-gnu-gcc -O2 -march=rv64gcv_zfh_xtheadc -mabi=lp64d -I$(RISCV)/include -o $(OUT)/c_runtime \
	$(OUT)/main.c $(OUT)/model.c $(OUT)/io.c $(OUT)/process.c -L$(RISCV)/lib -ljpeg -lpng -lz -lstdc++ -lshl_rvm -lm -static -Wl,--gc-sections

model:
	rm -rf $(OUT)/
	hhb -C --model-file data/mobilenetv2-12.onnx -o $(OUT)/ --data-scale 0.017 --data-mean '124 117 104' --board rvm \
	--calibrate-dataset $(IMG) --input-name input --output-name output --input-shape '1 3 224 224' --quantization-scheme="float16" --pixel-format BGR --target-layout NHWC

model_caffe:
	rm -rf $(OUT)/
	PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python hhb -C --model-file ./data/mobilenet.prototxt ./data/mobilenet.caffemodel -o $(OUT)/ --data-scale 0.017 --data-mean '104 117 124' --board rvm --calibrate-dataset $(IMG)  --quantization-scheme="float16" --pixel-format BGR --target-layout NHWC

clean:
	rm -rf out/
