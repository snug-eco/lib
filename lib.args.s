

var _args_iter
var _args_inited
var _arg_len
var _arg_ptr

; ( -- )
lab args/init
    ; open args file
    lit 4    
    jsr heap/new

    ; name
    dup
    str "args"

    ; check exists
    dup
    jsr sys/file/check
    not
    jcn args/init/error

    ; open
    dup
    jsr sys/file/seek
    jsr sys/file/open
    ldv _args_iter

    ; clean up name
    jsr heap/void

    ; loop will iterate read blocks,
    ; till unread one if found
lab args/init/loop
    ; switch flag 
    ldv _args_iter
    jsr sys/disk/read
    
    ; 0x00 end of argument stream
    dup
    lit 0
    equ
    jcn args/init/done

    ; 0x01 argument not read
    dup
    lit 1
    equ
    jcn args/init/done

    ; otherwise assume argument read
    pop
    jsr args/next
    jmp args/init/loop 
    
lab args/init/done
    pop ;flag

    ; set initialized flag
    lit 1
    stv _args_inited
    ret

lab args/init/error
    lit 100
    jsr sys/heap/alloc
    dup
    str "args error: args file not found"
    jsr string/print
    jsr string/newline
    brk



; ( -- )
lab args/next

    ; length
    ldv _args_iter
    inc ;skip flag
    jsr sys/disk/read

    ; advance iterator
    ldv _args_iter
    add
    stv _args_iter
    ret




; ( -- arg* ) HEAP
lab args/get
    ; auto initialize 
    ldv _args_inited
    jcn args/get/inited
    jsr args/init

lab args/get/inited
    
    ; check flag
    ldv _args_iter
    jsr sys/disk/read
    lit 0
    equ
    jcn args/get/bound

    ; length
    ldv _args_iter
    inc ;skip flag
    jsr sys/disk/read
    stv _arg_len

    ; output allocate
    ldv _arg_len
    inc ;termi
    jsr sys/heap/alloc
    stv _arg_ptr

    ; skip to content
    ldv _args_iter
    lit 2
    add
    stv _args_iter

lab args/get/loop
    ; check exit
    ldv _arg_len
    lit 0
    equ
    jcn args/get/done

    ; dec count
    ldv _arg_len
    lit 1
    sub
    stv _arg_len

    ; copy character
    ldv _args_iter
        dup
        inc
        stv _args_iter
    jsr sys/disk/read
    ldv _arg_ptr 
        dup
        inc
        stv _arg_ptr
    sta

    jmp args/get/loop

lab args/get/done
    lit 0
    ldv _arg_ptr
    sta ; write terminator
    ret

lab args/get/bound
    lit 0 ; null ptr
    ret

    

