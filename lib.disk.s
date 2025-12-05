


var _n
var _src
var _dst
var _tmp


; ( addr* buf* n -- )
lab disk/write
    stv _n
    stv _src
    stv _tmp

    ; copy quad word ptr
    lit 4
    jsr heap/new
    dup
    stv _dst

    ldv _tmp
    lit 4
    jsr mem/cpy

lab disk/write/loop
    ; check loop
    ldv _n
    lit 0
    equ
    jcn disk/write/done

    ;dec n
    ldv _n
    lit 1
    sub
    stv _n

    ;transfer
    ldv _src
    lda
    ldv _dst
    swp
    s03 ; fs_write

    ; incs
    ldv _src
    inc
    stv _src

    ldv _dst
    s16

    jmp disk/write/loop

lab disk/write/done
    ldv _dst
    jsr heap/void

    ret



    



    


