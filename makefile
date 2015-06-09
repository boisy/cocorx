OBJS = main.obj titlescreen.obj menuscreen.obj screenutils.obj symbols.obj \
        ramdoctor.obj videodoctor.obj sounddoctor.obj joystickdoctor.obj \
        cassettedoctor.obj serialdoctor.obj keyboarddoctor.obj utils.obj

cocorx.rom: $(OBJS)
	lwlink --output=$@ --format=raw $^

%.obj : %.asm
	lwasm --format=obj --output=$@ --pragma=undefextern,export $<

run: cocorx.rom
	xroar -machine coco2us -kbd-translate -cart cocorx.rom -cart-autorun

clean:
	rm -f $(OBJS) cocorx.rom
