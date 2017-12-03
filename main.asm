; @author	: Wawan Setyadi & Aldi Solihin
; @NIM		: G64140088 & G641400
; @Task		: Simple Blackjack Game

; fungsi dari file lain
%include    'printf.asm'
%include    'proses.asm'

; fungsi dari bahasa C
extern printf
extern scanf

SECTION     .data
    header      db '        ===========================        ',0xa,
                db '        || Simple Blackjack Game ||        ',0xa,
                db '        ||   By : Wawan & Aldi   ||        ',0xa,
                db '        ===========================        ',0xa,0xa,0
            
    help        db '///////////////////////////////////////////',0xa,
                db '//                 Rules                 //',0xa,
                db '// _____________________________________ //',0xa,
                db '//|o Aces can be either 1 or 11 points. |//',0xa,
                db '//|o Jack, Queen, and King counted as   |//',0xa,
                db '//|  10 points.                         |//',0xa,
                db '//|o Dealer wins ties unless player has |//',0xa,
                db '//|  a blackjack.                       |//',0xa,
                db '//|_____________________________________|//',0xa,
                db '///////////////////////////////////////////',0xa,0xa,0
            
    footer      db '        ===========================        ',0xa,
                db '        || Thank You For Playing ||        ',0xa,
                db '        ===========================        ',0xa,0xa,0
            
    newline     db '',0xa,0
            
    pre         db 'Are you ready?',0xa,
                db '1. Yes',0xa,
                db '2. No',0xa,
                db '3. Exit',0xa,0xa,0
    
    start       db 'The Dealer shuffled and dealt you each your cards.',0xa,0
    
    player      db 'Your hand : %d',0
    
    player2     db ' %d',0xa,0
    
    dealer      db 'Dealers hand : %d *',0xa,0
    
    win         db '               ==============               ',0xa,
                db '               | You Win !! |               ',0xa,
                db '               ==============               ',0xa,0
    
    blackjack   db '         ===========================         ',0xa,
                db '         | Blackjack !! You Win !! |         ',0xa,
                db '         ===========================         ',0xa,0
    
    lose        db '              ===============              ',0xa,
                db '              | You Lose !! |              ',0xa,
                db '              ===============              ',0xa,0
    
    ties        db '          =======================          ',0xa,
                db '          | Ties !! Dealer Wins |          ',0xa,
                db '          =======================          ',0xa,0
    
    pbust       db 'You bust! Dealer win.',0xa,0
    
    dbust       db 'Dealer bust! You win.',0xa,0
    
    aces        db 0xa,'Would you like your Ace to count as 1 or 11 points?',0xa,
                db '1. count as 1 point',0xa,
                db '2. count as 11 point',0xa,0xa,0
                
    acespoint   db 'Your Aces is counted as %d',0xa,0
    
    choice      db 'Would you like to hit or stand?',0xa,
                db '1. Hit',0xa,
                db '2. Stand',0xa,0xa,0
                
    whenhit     db 'Your total card points now : %d',0xa,0
    
    whenstand   db 'Dealer total card points now : %d',0xa,0
    
    newhit      db 'Your new card : %d',0xa,0
    
    again       db 'The Dealer dealt you another card.',0xa,0
    
    restart     db 'Would you like to play again?',0xa,
                db '1. Yes',0xa,
                db '2. No',0xa,0xa,0
    
    clr_scr     db  27,'[H',27,'[2J',0
    
    len_clr_scr equ $-clr_scr
    
    formatnum   db '%d',0
    
    
SECTION     .bss
    ;temporary chip
    final       resd    1
    
    ;hasil random
    randcard    resq    1
    dealerfirst resq    1
    
    ;Player answer
    reply       resd    1
    
    ;Card points
    psum        resq    1
    dsum        resq    1
    
    
SECTION     .text
    global  main

main:
    call clrScr
    call printheader
    call printhelp
    call printpre
    jmp exit

mulai:
    mov dword[psum], 0
    call clrScr
    call printstart
    call printnewline
    call prandomize
    call pdelay
    call ddelay
    call printnewline
    call printsum
    call printnewline
    call checkbust
    call printchoice
    call hitorstand
    jmp exit

addcard:
    call clrScr
    call printagain
    call printnewline
    call p3randomize
    call printnewline
    call printsum
    call printnewline
    call checkbust
    call printchoice
    call hitorstand
    jmp exit

comparecard:
    call clrScr
    call printsum
    call printnewline
    call dealercard
    call printnewline
    call checkbustdealer
    mov eax, dword[psum]
    mov ebx, dword[dsum]
    cmp eax, ebx
    ja menang
    jb kalah
    je seri
    jmp exit

menang:
    call printwin
    call printnewline
    call printrestart
    jmp exit

kalah:
    call printlose
    call printnewline
    call printrestart
    jmp exit

seri:
    call printties
    call printnewline
    call printrestart
    jmp exit

exit:
    call printfooter
    mov eax, 1
    int 0x80