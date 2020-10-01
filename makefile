# Be sure to set MAMEPATH to the root directory of your MAME installation

cocorx.rom: main.obj

main.obj : main.asm
	lwasm main.asm --format=obj --output=cocorx.rom --pragma=undefextern,export --raw

runxroar: cocorx.rom
	xroar -machine coco2us -kbd-translate -cart cocorx.rom -cart-autorun

runmame: cocorx.rom
	mame64 -homepath $(MAMEPATH) -rompath $(MAMEPATH)/roms -video opengl -window coco2b -cart cocorx.rom

clean:
	rm -f $(OBJS) cocorx.rom
