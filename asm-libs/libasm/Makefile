TARGET	= libasm.a

AS	= as
ASFLAGS	= --64
AR	= ar
ARFLAGS	= rcs

SOURCES	:= $(wildcard src/*.s)
OBJECTS := $(patsubst src/%.s, obj/%.o, $(SOURCES))


.PHONY: clean


$(TARGET) : $(OBJECTS)
	$(AR) $(ARFLAGS) $(TARGET) $(OBJECTS)

obj/%.o : src/%.s
	$(AS) $(ASFLAGS) $< -o $@


clean:
	rm -f $(OBJECTS) $(TARGET)
