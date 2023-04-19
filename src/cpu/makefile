SRCDIRS=./ fetch/ id/ ex/ mem/

SRCS=$(foreach dir,$(SRCDIRS),$(wildcard $(dir)*.v $(dir)*.vh))

info: 
	@echo Use make run
	@echo $(SRCDIRS)
	@echo $(SRCS)

all: $(addprefix ./outputs/, $(OBJS))

run: link
	./outputs/a.out

link: $(SRCS)
	iverilog -o ./outputs/a.out $^ 

clean:
	rm -f ./outputs/*.o