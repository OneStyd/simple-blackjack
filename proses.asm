ddelay:
    mov eax, 13
    mov ebx, 0
    int 0x80
    mov ecx, eax
    add ecx, 1      ;detik
    
mdelay:    
    mov eax, 13
    mov ebx, 0
    int 0x80

    cmp eax, ecx 
    jae drandomize
    jmp mdelay

prandomize:
    mov eax, 13
    mov ebx, 0
    int 0x80
    
    mov edx, 0
    mov ecx, 12
    div ecx
    add edx, 1
    
    ;kondisi kartu
    cmp edx, 11
    jae pjadi10
    cmp edx, 1
    je pnilaiAs
    jmp pprintnilai

pjadi10:
    mov edx, 10
    jmp pprintnilai
    
pnilaiAs:
    push dword aces+1
    push dword aces+1
    push dword aces
    call printf
    add esp, 12
    
    push reply
    push formatnum
    call scanf
    add esp, 8
    
    mov eax, [reply]
    cmp eax, 1
    je pjadi1
    jmp pjadi11

pjadi1:
    mov edx, 1
    jmp pprintnilai

pjadi11:
    mov edx, 11
    jmp pprintnilai
    
pprintnilai:
    call sumplayer
    mov dword[randcard], edx
    push dword [randcard]
    push dword player
    call printf
    add esp, 8
ret

pdelay:
    mov eax, 13
    mov ebx, 0
    int 0x80
    mov ecx, eax
    add ecx, 1      ;detik
    
delay:    
    mov eax, 13
    mov ebx, 0
    int 0x80

    cmp eax, ecx 
    jae p2randomize
    jmp delay

p2randomize:
    mov eax, 13
    mov ebx, 0
    int 0x80
    
    mov edx, 0
    mov ecx, 12
    div ecx
    add edx, 1
    
    ;kondisi kartu
    cmp edx, 11
    jae p2jadi10
    cmp edx, 1
    je p2nilaiAs
    jmp p2printnilai

p2jadi10:
    mov edx, 10
    jmp p2printnilai
    
p2nilaiAs:
    push dword aces+1
    push dword aces+1
    push dword aces
    call printf
    add esp, 12
    
    push reply
    push formatnum
    call scanf
    add esp, 8
    
    mov eax, [reply]
    cmp eax, 1
    je p2jadi1
    jmp p2jadi11

p2jadi1:
    mov edx, 1
    jmp p2printnilaiAs

p2jadi11:
    mov edx, 11
    jmp p2printnilaiAs
    
p2printnilai:
    call sumplayer
    mov dword[randcard], edx
    push dword [randcard]
    push dword player2
    call printf
    add esp, 8
ret

p2printnilaiAs:
    call sumplayer
    mov dword[randcard], edx
    push dword [randcard]
    push dword acespoint
    call printf
    add esp, 8
ret

p3randomize:
    mov eax, 13
    mov ebx, 0
    int 0x80
    
    mov edx, 0
    mov ecx, 12
    div ecx
    add edx, 1
    
    ;kondisi kartu
    cmp edx, 11
    jae p3jadi10
    cmp edx, 1
    je p3nilaiAs
    jmp p3printnilai

p3jadi10:
    mov edx, 10
    jmp p3printnilai
    
p3nilaiAs:
    push dword aces+1
    push dword aces+1
    push dword aces
    call printf
    add esp, 12
    
    push reply
    push formatnum
    call scanf
    add esp, 8
    
    mov eax, [reply]
    cmp eax, 1
    je p3jadi1
    jmp p3jadi11

p3jadi1:
    mov edx, 1
    jmp p3printnilai

p3jadi11:
    mov edx, 11
    jmp p3printnilai
    
p3printnilai:
    call sumplayer
    mov dword[randcard], edx
    push dword [randcard]
    push dword newhit
    call printf
    add esp, 8
ret

drandomize:
    mov eax, 13
    mov ebx, 0
    int 0x80
    
    mov edx, 0
    mov ecx, 12
    div ecx
    add edx, 1
    
    ;kondisi kartu
    cmp edx, 11
    jae djadi10
    cmp edx, 1
    je dnilaiAs
    jmp dprintnilai

djadi10:
    mov edx, 10
    jmp dprintnilai
    
dnilaiAs:
    mov edx, 11
    jmp dprintnilai
    
dprintnilai:
    mov dword[dealerfirst], edx

d2printnilai:
    push dword [dealerfirst]
    push dword dealer
    call printf
    add esp, 8
ret

printpre:
    push dword pre+1
    push dword pre+1
    push dword pre+1
    push dword pre
    call printf 
    add esp, 16
    
    push reply
    push formatnum
    call scanf
    add esp, 8
    
    mov eax, [reply]
    cmp eax, 1
    je mulai
    cmp eax, 2
    je notready
    jmp exit
ret

notready:
    call clrScr
    jmp printpre
ret

hitorstand:
    push reply
    push formatnum
    call scanf
    add esp, 8
    
    mov eax, [reply]
    cmp eax, 1
    je addcard
    cmp eax, 2
    je comparecard
ret

printrestart:
    push dword restart+1
    push dword restart+1
    push dword restart
    call printf 
    add esp, 12
    
    push reply
    push formatnum
    call scanf
    add esp, 8
    
    mov eax, [reply]
    cmp eax, 1
    je mulai
    cmp eax, 2
    je exit
ret

sumplayer:
    mov eax, dword[psum]
    add eax, edx
    mov dword[psum], eax
ret

dealercard:
    mov eax, dword[dealerfirst]
    mov dword[dsum], eax

randforsum: 
    mov eax, 13
    mov ebx, 0
    int 0x80
    
    mov edx, 0
    mov ecx, 12
    div ecx
    add edx, 1
    
    ;kondisi kartu
    cmp edx, 11
    jae ddjadi10
    jmp dealersum

ddjadi10:
    mov edx, 10
    jmp dealersum
    
dealersum:
    mov eax, dword[dsum]
    add eax, edx
    mov dword[dsum], eax
    cmp eax, 17
    jb randforsum
    jmp printsumdealer
ret

checkbustdealer:
    mov eax, dword[dsum]
    cmp eax, 21
    ja printdbust
ret

checkbust:
    mov eax, dword[psum]
    cmp eax, 21
    ja printbust
    je printblackjack
ret