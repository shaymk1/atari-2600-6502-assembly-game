    processor 6502
    seg code
    org $F000    ; Define the code origin at F000
start:
    sei          ; Disable interupts
    cld          ; Disable Binary Coded Decimal(BCD) decimal math mode
    ldx #$FF     ; Load the X Register with the #$FF
    txs          ; Transfer the X Register into the (S)tack pointer register
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;; Clear The Page Zero Region From ($00 to $FF0)
;;;;;;;;;;;;;;;;;;; Meaning,  the entire RAM space, including the TIA Registers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    lda $0      ; A=0
    ldx #$FF    ; X=#$FF
MemLoop:
    sta $0,X    ; Store the value of A register, inside memory adress $0 + whatever is inside X
    dex         ; X--
    bne MemLoop ; Loop until X = 0 ,meaning untill my Z-flag is set
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;; Fill the ROM to exactly 4KB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    org $FFC    ; Set the origin at the end of our catridge, expect to find 2 bytes in this adress
    .word Start ; Expect to find the reset adress/vector at $FFFC, meaning where the programme start
    .word Start ; The interrupt vector that will be in the position $FFFE in memory (2 bytes=word), unused in the VCS

    