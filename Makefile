
ifeq ($(strip $(CC)),)
CC := gcc
endif
CC += -Wall -MP -MD -g3 
INCMLFLG := -D INC_ML_CMPL
TESTFLG := -D TEST
DIR := src/c

SPECCMPL := 

SOURCES := $(wildcard $(DIR)/*.c)
OBJECTS := $(patsubst $(DIR)/%.c,  $(DIR)/%.o, $(SOURCES))

.PHONY: ml inc constraint_inc clean
ml: SPECCMPL = -D INC_ML_CMPL
inc: SPECCMPL = -D INC_CMPL 
constraint_inc: SPECCMPL = -D CINC_CMPL

clean:
	rm -f $(DIR)/*.o
	rm -f $(DIR)/*.d
	rm -f ml
	rm -f inc
	rm -f constraint_inc

ml inc constraint_inc: clean $(OBJECTS)
	$(CC) $(SPECCMPL) $(filter-out $<,$^) -lm -o $@

$(DIR)/%.o: $(DIR)/%.c
	$(CC) $(SPECCMPL) -I$(DIR) -c $< -o $@

