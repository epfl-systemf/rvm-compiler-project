verify: conv1d_integration lit_tests

OUT = out

.PHONY: conv1d_integration lit_tests

clean:
	rm -rf $(OUT)

conv1d_integration:
	@mkdir -p $(OUT)
	@make -C src/conv1d OUT=$(shell pwd)/$(OUT)
	@spike --isa=RV32IMC_xmatrix pk -s $(OUT)/conv1d.elf
	
lit_tests:
	lit experiments/tvm/07_new_tensorize_matmul.py \
		src/conv1d/exo/conv1d.py \
		src/optitrust-rvm/case_studies/conv1d/conv1d.ml
