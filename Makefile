ASM=nasm

SRC_DIR=src
BUILD_DIR=build

.PHONY: all floppy_image kernel bootLoader clean always



#FLOPPY IMAGE
floppy_image: $(BUILD_DIR)/main_floppy.img	


$(BUILD_DIR)/main_floppy.img: bootloader kernel
	dd if=/dev/zero of= $(BUILD_DIR)/main_floppy.img bs=512 count=2880
	mkfs.fat -F 12 -n "NBOS" $(BUILD_DIR)/main_floppy.img
	dd if=$(BUILD_DIR)/bootloader.bin of=$(BUILD_DIR)/main_floppy.img conv=norunc
	mcopy -i $(BUILD_DIR)/main_floppy.img $(BUILD_DIR)/kernel.bin "::kernel.bin"
	# YOU STOPPED AT 7:46
	
#Bootloader
bootLoader: $(BUILD_DIR)/bootloader.bin
$(BUILD_DIR)/bootLoader.bin: always
	$(ASM) $(SRC_DIR)/bootloader/boot.asm -f bin -o $(BUILD_DIR)/bootloader.bin


#KERNEL
kernel: $(BUILD_DIR)/kernel.bin

$(BUILD_DIR)/kernel.bin: always
	mkdir -p $(BUILD_DIR)
	$(ASM) $(SRC_DIR)/kernel/main.asm -f bin -o $(BUILD_DIR)/kernel.bin

# Always
always:
	mkdir -p $(BUILD_DIR)


#Clean
clean:
	rm -rf $(BUILD_DIR)/*

