verify: conv1d_integration lit_exo lit_optitrust

OUT = out

.PHONY: conv1d_integration lit_exo lit_optitrust

clean:
	rm -rf $(OUT)

conv1d_integration:
	@mkdir -p $(OUT)
	@make -C src/conv1d OUT=$(shell pwd)/$(OUT)
	@spike --isa=RV32IMC_xmatrix pk -s $(OUT)/conv1d.elf
	
lit_exo:
	lit src/conv1d/exo/conv1d.py

lit_optitrust:
	lit src/optitrust-rvm/case_studies/conv1d/conv1d.ml -v