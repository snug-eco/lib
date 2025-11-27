
; read a line from the stdin, 
; while respectiving backspace,
; until enter it hit.

var _limit
var _buf
var _n


; (buf* limit)
lab line
    stv _limit
    stv _buf

    lit 0
    stv _n

lab line/loop
    inp

    dup
    dbg

    ; check enter
    dup
    lit 10
    equ
    jcn line/enter

    ; check backspace
    dup
    lit 8
    equ
    jcn line/backspace

    ; check buffer bounds
    ldv _limit
    ldv _n
    equ
    jcn line/loop

    ;echo
    out
    ; append to buffer
    ldv _buf
    ldv _n
    add
    sta
    ; advance
    ldv _n
    inc
    stv _n

    jmp line/loop

lab line/backspace
    ; skip backspace if buffer empty
    ldv _n
    lit 0
    equ
    jcn line/loop

    ;echo
    out
    ; preceed buffer
    ldv _buf
    lit 1
    sub
    stv _buf

    jmp line/loop

lab line/enter
    ; write terminator
    lit 0
    ldv _buf
    ldv _n
    add
    sta

    ret








    


    







