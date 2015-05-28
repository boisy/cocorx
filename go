#!/bin/tcsh
lwasm main.asm --format=obj --output=main.obj --pragma=undefextern,export
lwasm titlescreen.asm --format=obj --output=titlescreen.obj --pragma=undefextern,export
lwasm screenutils.asm --format=obj --output=screenutils.obj --pragma=undefextern,export
lwasm symbols.asm --format=obj --output=symbols.obj --pragma=undefextern,export
lwasm ramdoctor.asm --format=obj --output=ramdoctor.obj --pragma=undefextern,export
lwasm videodoctor.asm --format=obj --output=videodoctor.obj --pragma=undefextern,export
lwasm joystickdoctor.asm --format=obj --output=joystickdoctor.obj --pragma=undefextern,export
lwasm cassettedoctor.asm --format=obj --output=cassettedoctor.obj --pragma=undefextern,export
lwasm serialdoctor.asm --format=obj --output=serialdoctor.obj --pragma=undefextern,export
lwasm keyboarddoctor.asm --format=obj --output=keyboarddoctor.obj --pragma=undefextern,export
lwlink main.obj titlescreen.obj screenutils.obj symbols.obj ramdoctor.obj videodoctor.obj joystickdoctor.obj cassettedoctor.obj serialdoctor.obj keyboarddoctor.obj --output=cocorx.rom --raw
if ($? == 0) then
	xroar -machine coco2us -kbd-translate -cart cocorx.rom -cart-autorun
endif
