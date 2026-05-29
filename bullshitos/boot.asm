ORG 0
BITS 16

jmp 0x7c0:start

start:
	cli	;clear interupts
	mov ax, 0x7c0	;cant directly put it into ds or es, so we put it into ax first
	mov ds, ax
	mov es, ax
	mov ax, 0x00
	mov ss, ax
	mov sp, 0x7c00
	
	sti	;enables interupts
	mov si, message
	call print
	jmp $

print:	;defining print function
	mov bx, 0
.loop:
	lodsb ;loads the char, increments, do like a loop for each char
	cmp al, 0
	je .done ;if true
	call print_char ;if not true
	jmp .loop	
.done:
	ret
; end of print

	
print_char:	;defining print_char function
	mov ah, 0eh	; 0eh is one of the functions this one outputs char
	int 0x10	;bios interupt code (there are many of them)
	ret



message: db 'Hello World!', 0 	; defining message function (db is like an array)



times 510-($-$$) db 0  ; 4096 - 16  or 512 bytes - 2 bytes which equals to 510 bytes... 
;we fill those 510 bytes with 0s so we can access the boot signature on those last 2 bytes
dw 0xAA55	; should be 0x55AA but intel cpu are retarded



; YOU STOPPED AT PART 9 https://youtu.be/dlFbJL8E5fE
