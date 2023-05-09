SRCDIRS=./ fetch/ id/ ex/ mem/
TESTFILES= $(notdir $(basename $(wildcard ../../testbench/cpu/*.v)))
SRCS=$(foreach dir,$(SRCDIRS),$(wildcard $(dir)*.v $(dir)*.vh))

info: 
	@echo Try make $(TESTFILES)

%: %.o
	../../testbench/cpu/outputs/$<

%.o: $(SRCS) ../../testbench/cpu/%.v
	iverilog -o ../../testbench/cpu/outputs/$@ $^ 

clean:
	rm -f ../../testbench/cpu/outputs/*.o
