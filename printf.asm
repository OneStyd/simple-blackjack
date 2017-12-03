clrScr:
    mov eax, 4
    mov ebx, 1
    mov ecx, clr_scr
    mov edx, len_clr_scr
    int 0x80
ret

printnewline:
    push dword newline
    call printf 
    add esp, 4
ret 

printheader:
    push dword header+1
    push dword header+1
    push dword header+1
    push dword header
    call printf 
    add esp, 16
ret

printhelp:
    push dword help+1
    push dword help+1
    push dword help+1
    push dword help+1
    push dword help+1
    push dword help+1
    push dword help+1
    push dword help+1
    push dword help+1
    push dword help
    call printf 
    add esp, 40
ret

printstart:
    push dword start
    call printf 
    add esp, 4
ret

printchoice:
    push dword choice+1
    push dword choice+1
    push dword choice
    call printf
    add esp, 12
ret

printdhand:
    push dword [dealerfirst]
    push dword dealer
    call printf 
    add esp, 8
ret

printagain:
    push dword again
    call printf 
    add esp, 4
ret

printsum:
    push dword [psum]
    push dword whenhit
    call printf
    add esp, 8
ret

printsumdealer:
    push dword [dsum]
    push dword whenstand
    call printf
    add esp, 8
ret

printbust:
    push dword pbust
    call printf
    add esp, 12
    call printnewline
    jmp kalah
ret

printdbust:
    push dword dbust
    call printf
    add esp, 12
    call printnewline
    jmp menang
ret

printwin:
    push dword win+1
    push dword win+1
    push dword win
    call printf
    add esp, 12
ret

printblackjack:
    push dword blackjack+1
    push dword blackjack+1
    push dword blackjack
    call printf
    add esp, 12
    call printnewline
    call printrestart
    jmp exit
ret

printlose:
    push dword lose+1
    push dword lose+1
    push dword lose
    call printf
    add esp, 12
ret

printties:
    push dword ties+1
    push dword ties+1
    push dword ties
    call printf
    add esp, 12
ret

printfooter:
    push dword footer+1
    push dword footer+1
    push dword footer
    call printf
    add esp, 12
ret