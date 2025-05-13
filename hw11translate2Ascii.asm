; Student: Bidhan Baral
; Class: CMSC313 Monday/Wednesday 10-11:15 am

SECTION .data
    inputBuf:
        db 0x83, 0x6A, 0x88, 0xDE, 0x9A, 0xC3, 0x54, 0x9A
    hexChars:
        db '0123456789ABCDEF'
    space:
        db ' '
    newline:
        db 0Ah

SECTION .bss
    outputBuf:
        resb 80

SECTION .text
    global _start

_start:

    mov esi, inputBuf
    mov edi, outputBuf

    ; looping over the 8 bytes of data in inputBuf
    mov ecx, 8

_loop:
    ; for each byte in inputBuf:
    ; get high and low nibbles
    ; convert nibbles to ascii hex characters using hexChars
    ; store the resulting two ascii characters into outputBuf
    ; repeat 8 times since there are 8 bytes

    mov al, byte [esi]
    inc esi

    mov ebx, 0
    mov bl, al
    shr bl, 4
    and bl, 0Fh
    mov dl, [hexChars + ebx]
    mov [edi], dl
    inc edi

    mov ebx, 0
    mov bl, al
    and bl, 0Fh
    mov dl, [hexChars + ebx]
    mov [edi], dl
    inc edi

    ; adding space between the hex values so it's easier to read
    mov dl, [space]
    mov [edi], dl
    inc edi

    ; check if the loop should keep running or stop
    dec ecx
    cmp ecx, 0
    jne _loop

    ; making the last space a new line
    dec edi
    mov byte [edi], 0Ah

    ; printing the output to the terminal
    mov eax, 4
    mov ebx, 1
    mov ecx, outputBuf
    mov edx, 24
    int 80h

    mov ebx, 0
    mov eax, 1
    int 80h
