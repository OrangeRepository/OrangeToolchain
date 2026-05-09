TARGET	= libsfr.o

AS	= as
ASFLAGS	= --64
LD	= ld
LDFLAGS	= -r
#
# Sources
#
SUFFER.S	= src/suffer.s

# OBJECTS		= $(SUFFER.O)


.PHONY: clean


# $(TARGET) : $(OBJECTS)
	# $(LD) $(LDFLAGS) $^ -o $@
# $(SUFFER.O) : $(SUFFER.S)
	# $(AS) $(ASFLAGS) $< -o $@

$(TARGET) : $(SUFFER.S)
	$(AS) $(ASFLAGS) $< -o $@

clean:
	rm -f $(SUFFER.O) $(TARGET)
