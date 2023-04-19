SRCDIR=../../src/cpu
SUBDIRS=./ fetch/ id/ ex/ mem/
SRCDIRS=$(foreach dir, $(SUBDIRS), $(wildcard $(SRCDIR)/$(dir)))

SRCS=$(foreach dir,$(SRCDIRS),$(wildcard $(dir)*.v $(dir)*.vh))
OBJS=$(SRCS:.v=.o)

info: 
	@echo Use make run
	@echo $(SRCDIRS)
	@echo $(SRCS)

all: $(addprefix ./outputs/, $(OBJS))

run: link
	./outputs/a.out

link: $(SRCS)
	iverilog -o ./outputs/a.out $^ 

./outputs/%.o: %.v
	iverilog -o $@ $<

clean:
	rm -f ./outputs/*.o