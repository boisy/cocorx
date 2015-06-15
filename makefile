

main.obj : main.asm
	lwasm main.asm --format=obj --output=cocorx.rom --pragma=undefextern,export --raw

run: cocorx.rom
	xroar -machine coco2us -kbd-translate -cart cocorx.rom -cart-autorun

clean:
	rm -f $(OBJS) cocorx.rom
