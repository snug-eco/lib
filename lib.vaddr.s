
; --- virtual address library ---
; the snug machine has 32-bit quad words
; and it's heap is only about 2000 quad words.
; now for example when storing text, doing
; so in real address space is inefficient,
; because the upper 3 bytes of the quad word
; are wasted. instead we can use a virtual address
; space which compresses 4 bytes into one quad word.
; this quadruples the heap size to 8000 byte words.



; real -- virt
lab vaddr/real-to-virt
    ; 4 bytes per quad, multiply by 4, shift left be 2
    lit 2
    shl
    ret

; virt -- real
lab vaddr/virt-to-real
    lit 2
    shr
    ret


; vaddr -- value
lab vaddr/read
    ;read quad
    dup
        lit 2
        shr
        lda
    ;select byte from quad
    swp
    lit 3 and ;get index bits (2 lsb)
    lit 3 shl ;multiply by 8 (8 bits per byte)
    shr ; pull bytes into low byte
    lit 7 and ;mask low byte
    ret ;done

var _raddr
var _voffset

; vaddr value --
lab vaddr/write
    ;compute bit offset
    swp
        dup ;compute real address and store for later
        lit 2 shr
        stv _raddr
    lit 3 and ;index bits
    lit 3 shl ;*8
    stv _voffset

    ;load value and clear target byte
    ldv _raddr
    lda
        lit 7
        ldv _voffset
        shl
        inv
    and
    swp

    ;final
    ldv _voffset
    shl
    aor ;merge quads
    
    ;write back
    ldv _raddr
    sta

    ret











