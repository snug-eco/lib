


; (a* -- ) IO
lab string/print
lab string/print/loop
    dup
    lda
    dup
    lit 0
    equ
    jcn string/print/done
    out
    inc
    jmp string/print/loop

lab string/print/done
    pop
    pop

    ret

; ( -- ) IO
lab string/newline
    lit 10
    out
    lit 13
    out
    ret




var _delim

; (str* delim -- sub* str*)
lab string/token
    stv _delim

    ; find start of string
lab string/token/start-loop
    dup
    lda
    lit 0
    equ
    jcn string/token/start-cancel

    dup
    lda
    ldv _delim
    equ 
    jcn string/token/start-again

lab string/token/start-cancel
    dup ;substring
lab string/token/end-loop
    dup
    lda
    lit 0
    equ
    jcn string/token/end-cancel

    dup
    lda
    ldv _delim
    neq 
    jcn string/token/end-again


    ; write substring terminator
    dup
    lit 0
    swp
    sta
    inc

    ;already written
lab string/token/end-cancel
    ; done
    swp
    ret


lab string/token/start-again
    inc
    jmp string/token/start-loop
    
lab string/token/end-again
    inc 
    jmp string/token/end-loop




