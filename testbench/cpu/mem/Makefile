SRCS=$(wildcard *.s)

MEMS=$(SRCS:.s=.mem) 
ARCH=mipsel-linux-gnu

info:
	@echo "Please use ./build.sh, do not make directly"

mem: $(MEMS) 

%.om: %.s
	$(ARCH)-as -mips32 -O0 -EB $< -o $@ 

%.mem: %.om
	$(ARCH)-objcopy --dump-section .text=/dev/stdout $< | xxd -c 4 -g 32 | cut -f 2 -d " " > $@

clean:
	rm *.mem *.ans || true
