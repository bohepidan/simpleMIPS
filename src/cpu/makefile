SRCDIRS=./ fetch/ id/ ex/ mem/

SRCS=$(foreach dir,$(SRCDIRS),$(wildcard $(dir)*.v $(dir)*.vh))

info: 
	@echo Use make run

all: $(addprefix ../../testbench/cpu/outputs/, $(OBJS))

%: %.o
	../../testbench/cpu/outputs/$<

%.o: $(SRCS) ../../testbench/cpu/%.v
	iverilog -o ../../testbench/cpu/outputs/$@ $^ 

clean:
	rm -f ../../testbench/cpu/outputs/*.o
