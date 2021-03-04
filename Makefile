### Which object are we building?
name ?= $(firstword $(MAKECMDGOALS))
in ?= $(shell ls | grep -i $(name). | grep -P "txt|xml")

### Other flags
GCC_FLAGS = -Wall -Wextra

### Check for user arguments
ifeq ($(name),)
name := famTree
endif

ifeq ($(in),)
in := /dev/stdin
endif


## Targets

### Build Targets

$(name): $(name).tab.c $(name).yy.c grafos/grafos.c 
	gcc $(GCC_FLAGS) -o $(name) $(name).tab.c $(name).yy.c grafos/grafos.c -lm

$(name).yy.c: $(name).l $(name).tab.h
	flex -o $(name).yy.c $(name).l

$(name).tab.c $(name).tab.h: $(name).y
	yacc -b $(name) -d $(name).y
	
