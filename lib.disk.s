


var _n
var _src
var _dst


; ( dst* src* n -- )
lab disk/copy
    stv _n
    stv _src
    stv _dst

lab disk/copy/loop
    ; countdown
    ldv _n
    lit 0
    equ
    jcn disk/copy/done

    ; read
    ldv _src
    s02

    ; write
    ldv _dst
    swp
    s03

    ;inc
    ldv _src
    s16
    ldv _dst
    s16

    ;dec
    ldv _n
    lit 1
    sub
    stv _n

    jmp disk/copy/loop
lab disk/copy/done
    ret

    
    






; ( dst* src* n -- )
lab disk/rcopy
    stv _n
    stv _src
    stv _dst

    ldv _src
    ldv _n
    s18 ; quad/advance

    ldv _dst
    ldv _n
    s18 ; quad/advance

lab disk/rcopy/loop
    ; countdown
    ldv _n
    lit 0
    equ
    jcn disk/rcopy/done

    ; read
    ldv _src
    s02

    ; write
    ldv _dst
    swp
    s03

    ;dec
    ldv _src
    s19
    ldv _dst
    s19

    ;dec
    ldv _n
    lit 1
    sub
    stv _n

    jmp disk/rcopy/loop
lab disk/rcopy/done
    ret






; ( *addr -- size)
; given a pointer into a file,
; computes the size of remaining
; content in the file from the pointer onwards.
lab disk/file-len
    ;copy file ptr
    lit 4
    jsr heap/new
    dup
    stv _src

    swp
    lit 4
    jsr mem/cpy

    ; counter
    lit 0
    stv _n

lab disk/file-len/loop
    ldv _src
    s02 ; sd_read
    lit 0
    equ
    jcn disk/file-len/done

    ldv _src
    s16 ;quad/inc

    ldv _n
    inc
    stv _n

    jmp disk/file-len/loop

lab disk/file-len/done
    ldv _src
    jsr heap/void

    ldv _n
    ret





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



    



    


