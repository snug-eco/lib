

; --
lab sys/yield
    s00
    ret

; --
lab sys/flush-disk-cache
    s01
    ret

; addr -- byte
lab sys/disk/read
    s02
    ret

; addr byte --
lab sys/disk/write
    s03
    ret

; name* -- bool
lab sys/file/check
    s04
    ret

; name* -- addr
lab sys/file/seek
    s05
    ret

; addr -- addr
lab sys/file/open
    s06
    ret

; addr -- addr
lab sys/file/next
    s07
    ret

; name* size -- addr
lab sys/file/create
    s08
    ret

; addr --
lab sys/file/delete
    s09
    ret

; addr -- size
lab sys/file/size
    s10
    ret

; addr -- id
lab sys/proc/launch
    s11
    ret

; id --
lab sys/proc/kill
    s12
    ret

; id -- bool
lab sys/proc/check
    s13
    ret

; -- bool
lab sys/io/recv-ready
    s14
    ret

; words -- base
lab sys/heap/alloc
    s16
    ret

; base --
lab sys/heap/free
    s17
    ret






