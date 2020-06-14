include mymacros.inc
.model Large
.386
.stack 64
.data
win db "CONGRATULATIONS $"
playagain db "PRESS ANY KEY TO PLAY AGAIN$"
continue db "PRESS ANY KEY TO CONTINUE $"
gameover db "GAME OVER$"
score dw 0000h
heart dw 3
stringscore db "SCORE $"
stringwelcome db "WELCOME $"
howtoplay1 db "TO WIN THE GAME YOU SHOULD PICK THE     $"
howtoplay2 db "RIGHT LETTER BY PRESSING THE KEY ON     $"
howtoplay3 db "KEYBOARD BEFORE THE LETTERS REACH       $"
howtoplay4 db "END OF THE SCREEN,OR YOU WILL LOSE ALIFE$"
howtoplay5 db "WATCHOUT YOU HAVE ONLY THREE,LOSING     $"
howtoplay6 db "ALIFE WILL MAKE YOU START ALLOVER AGAIN.$"
howtoplay7 db "SO LETS START  $"
stringgoodluck db "GOOD LUCK! $"			  
             
pointy dw 0h

clearpointx dw 0
clearpointy dw 0

clearwidth dw 320
clearheight dw 200

temp dw ?

fishwidth equ 100
fishheight equ 100

fishfilename db 'fish.bin',0
fishfilehandle dw ?
fishdata db fishwidth*fishheight dup(0)

letterwidth equ 60
letterheight equ 60

smallletterwidth equ 30
smallletterheight equ 30

smallletterefilename db 'mine.bin',0
smallletterefilehandle dw ?
smallletteredata db smallletterwidth*smallletterheight dup(0)

smalllettergfilename db 'ming.bin',0
smalllettergfilehandle dw ?
smalllettergdata db smallletterwidth*smallletterheight dup(0)

smallletterffilename db 'minf.bin',0
smallletterffilehandle dw ?
smallletterfdata db smallletterwidth*smallletterheight dup(0)

smallletterifilename db 'mini.bin',0
smallletterifilehandle dw ?
smallletteridata db smallletterwidth*smallletterheight dup(0)

smalllettersfilename db 'mins.bin',0
smalllettersfilehandle dw ?
smalllettersdata db smallletterwidth*smallletterheight dup(0)

smallletterhfilename db 'minh.bin',0
smallletterhfilehandle dw ?
smallletterhdata db smallletterwidth*smallletterheight dup(0)

heartwidth equ 16
heartheight equ 16

heartFilename DB 'heart.bin', 0
heartFilehandle DW ?
heartData DB heartwidth*heartheight dup(0)

letterEfilename db 'E.bin',0
letterEfilehandle dw ?
letterEdata db letterwidth*letterheight dup(0)

letterGfilename db 'G.bin',0
letterGfilehandle dw ?
letterGdata db letterwidth*letterheight dup(0)

letterBfilename db 'B.bin',0
letterBfilehandle dw ?
letterBdata db letterwidth*letterheight dup(0)

letterFfilename db 'F.bin',0
letterFfilehandle dw ?
letterFdata db letterwidth*letterheight dup(0)

letterHfilename db 'H.bin',0
letterHfilehandle dw ?
letterHdata db letterwidth*letterheight dup(0)

letterSfilename db 'S.bin',0
letterSfilehandle dw ?
letterSdata db letterwidth*letterheight dup(0)

letterIfilename db 'I.bin',0
letterIfilehandle dw ?
letterIdata db letterwidth*letterheight dup(0)

letterNfilename db 'N.bin',0
letterNfilehandle dw ?
letterNdata db letterwidth*letterheight dup(0)

eggwidth equ 100
eggheight equ 100

cryfilename db 'cry.bin',0
cryfilehandle dw ?
crydata db eggwidth*eggheight dup(0)

eggfilename db 'egg.bin',0
eggfilehandle dw ?
eggdata db eggwidth*eggheight dup(0)

.code
;;;;;;;;;;;;;;;;;;;;welcome screen;;;;;;;
welcomescreen proc
push ax
push bx
push cx
push dx
;;;;;;;;;;;to clear screen with black ;;;;;;;;;;;
mov cx,clearpointx
mov dx,clearpointy
mov di,clearpointx
mov si,clearpointy
add di,clearwidth
add si,clearheight
mov ah,0ch
; Drawing loop
sketch1:
mov al,00h
int 10h 
inc cx
cmp cx,di
jne sketch1 
mov cx, clearpointx
inc dx
cmp dx,si
jne sketch1
;;;;;;;;;;;;;;;; to write welcome;;;;;;;;;;
mov dh , 02
mov dl , 16
mov bh , 0
mov bl,04h
mov ah , 2
int 10h
printstring stringwelcome
;;;;;;;;;;;;to write the instructions;;;;
mov dh , 05
mov dl , 02
mov bh , 0
mov bl,04h
mov ah , 2
int 10h
printstring howtoplay1
mov dh , 7
mov dl , 02
mov bh , 0
mov bl,04h
mov ah , 2
int 10h
printstring howtoplay2
mov dh , 9
mov dl , 03
mov bh , 0
mov bl,04h
mov ah , 2
int 10h
printstring howtoplay3
mov dh , 11
mov dl , 00
mov bh , 0
mov bl,04h
mov ah , 2
int 10h
printstring howtoplay4
mov dh , 13
mov dl , 02
mov bh , 0
mov bl,04h
mov ah , 2
int 10h
printstring howtoplay5
mov dh , 15
mov dl , 00
mov bh , 0
mov bl,04h
mov ah , 2
int 10h
printstring howtoplay6
mov dh , 17
mov dl , 13
mov bh , 0
mov bl,04h
mov ah , 2
int 10h
printstring howtoplay7
;;;;;;;;;;;;to write goodluck;;;
mov dh , 19
mov dl , 14
mov bh , 0
mov bl,04h
mov ah , 2
int 10h
printstring stringgoodluck
;;;;;;;;;;;to continue the game;;;;
mov dh , 22
mov dl , 08
mov bh , 0
mov bl,04h
mov ah , 2
int 10h
printstring continue
;;;;;;;;;;;;wait for key pressed to play;;;;;;;
mov ah,0
int 16h
;;;;;;;;;;;;;;;;
pop dx
pop cx
pop bx
pop ax
ret
welcomescreen endp
;;;;;;;;;;;;;;;clear block;;;;;;;;;;;;;;;;
clearblock proc
push ax
push bx
push cx
push dx
mov cx,clearpointx
mov dx,clearpointy
mov di,clearpointx
mov si,clearpointy
add di,clearwidth
add si,clearheight
mov ah,0ch
; Drawing loop
sketch:
mov al,0fh
int 10h 
inc cx
cmp cx,di
jne sketch 
mov cx,clearpointx
inc dx
cmp dx,si
jne sketch
pop dx
pop cx
pop bx
pop ax
ret
clearblock endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;draw pixel procedure ;;;;;;;;;;;;
drawpixel proc
mov ah,0ch
add si,60
add di,60
mov bx, 0
; Drawing loop
drawLoop1:
mov al,ds:[bp]
int 10h 
inc cx
inc bp
cmp cx,si
jne drawLoop1 
mov cx,temp
inc dx
cmp dx, di
jne drawLoop1
ret
drawpixel endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;small draw pixel procedure ;;;;;;;;;;;;
smalldrawpixel proc
mov ah,0ch
add si,30
add di,30
mov bx , 0
; Drawing loop
smalldrawLoop1:
mov al,ds:[bp]
int 10h 
inc cx
inc bp
cmp cx,si
jne smalldrawLoop1 
mov cx, temp
inc dx
cmp dx, di
jne smalldrawLoop1
ret
smalldrawpixel endp
;;;;;;;;;;;;;;;;;increase score;;;;;
increasescore proc
push ax
push bx
push cx
push dx
mov cx,100
add score,cx
writescore score
pop dx
pop cx
pop bx
pop ax
ret
increasescore endp
;;;;;;;;;;;;;;;;;;;;;heart procedure;;;;;;
drawheart proc
push ax
push bx
push cx
push dx
;;;;;;;;;;;open file;;;;;;;;;
mov ah,3dh
mov al,0
lea dx,heartfilename
int 21h
mov [heartfilehandle],ax
;;;;;;;;;;read data;;;;;;;;;;;
mov ah,3fh
mov bx,[heartfilehandle]
mov cx,heartwidth*heartheight
lea dx,heartdata
int 21h
;;;;;;;;;;;;;;;
lea bx,heartdata
mov cx,260
mov dx,13
mov ah,0ch
heartdrawloop:
mov al,[bx]
int 10h
inc cx
inc bx
cmp cx,heartwidth+260
jne heartdrawloop
mov cx,260
inc dx
cmp dx,heartheight+13
jne heartdrawloop
;;;;;;;;;;;;;;;;;;close file;;;;
MOV AH, 3Eh
MOV BX, [heartfilehandle]
INT 21h
pop dx
pop cx
pop bx
pop ax
ret
drawheart endp
;;;;;;;;;;;;;;;;fish procedure;;;;;;;;;;;;;;;
drawfish proc
push ax
push bx
push cx
push dx
;;;;;;;;;;;open file;;;;;;;;;
mov ah,3dh
mov al,0
lea dx,fishfilename
int 21h
mov [fishfilehandle],ax
;;;;;;;;;;read data;;;;;;;;;;;
mov ah,3fh
mov bx,[fishfilehandle]
mov cx,fishwidth*fishheight
lea dx,fishdata
int 21h
;;;;;;;;;;;;;;;
lea bx,fishdata
mov cx,200
mov dx,50
mov ah,0ch
fishdrawloop:
mov al,[bx]
int 10h
inc cx
inc bx
cmp cx,fishwidth+200
jne fishdrawloop
mov cx,200
inc dx
cmp dx,fishheight+50
jne fishdrawloop
;;;;;;;;;;;;;;;;;;close file;;;;
MOV AH, 3Eh
MOV BX, [fishfilehandle]
INT 21h
pop dx
pop cx
pop bx
pop ax
ret
drawfish endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;clear buffer;;;;;;;;;;;
clearbuffer proc
push ax
clear:
mov ah ,1
int 16h
jz endClear
mov ah,0
int 16h
cmp ax , 0          
jmp clear
endCLear:
pop ax
ret
clearbuffer endp
;;;;;;;;;;;;;;;;;;;;;;;letterE procedure;;;;;;;;;;
drawletterE proc
push ax
push bx
push cx
push dx
;;;;;;;;;;;;;;;
lea bx,letterEdata
mov cx,0
mov dx,0
mov ah,0ch
letterEdrawloop:
mov al,[bx]
int 10h
inc cx
inc bx
cmp cx,letterwidth
jne letterEdrawloop
mov cx,0
inc dx
cmp dx,letterheight
jne letterEdrawloop
;;;;;;;;;;;;;;;
pop dx
pop cx
pop bx
pop ax
ret
drawletterE endp
;;;;;;;;;;;;;;;;;;;letterG procedure;;;;;;;
drawletterG proc
push ax
push bx
push cx
push dx
;;;;;;;;;;;;;;;
lea bx,letterGdata
mov cx,0
mov dx,0
mov ah,0ch
letterGdrawloop:
mov al,[bx]
int 10h
inc cx
inc bx
cmp cx,letterwidth
jne letterGdrawloop
mov cx,0
inc dx
cmp dx,letterheight
jne letterGdrawloop
;;;;;;;;;;;;;;;
pop dx
pop cx
pop bx
pop ax
ret
drawletterG endp
;;;;;;;;;;;;;;;;;;;letter e procedure;;;;;;;
drawsmalllettere proc
push ax
push bx
push cx
push dx
lea bx,smallletteredata
mov cx,0
mov dx,0
mov ah,0ch
smallletteredrawloop:
mov al,[bx]
int 10h
inc cx
inc bx
cmp cx,smallletterwidth
jne smallletteredrawloop
mov cx,0
inc dx
cmp dx,smallletterheight
jne smallletteredrawloop
pop dx
pop cx
pop bx
pop ax
ret
drawsmalllettere endp
;;;;;;;;;;;;;;;;;;;letter g procedure;;;;;;;
drawsmallletterg proc
push ax
push bx
push cx
push dx
;;;;;;;;;;;;;;;
lea bx,smalllettergdata
mov cx,0
mov dx,0
mov ah,0ch
smalllettergdrawloop:
mov al,[bx]
int 10h
inc cx
inc bx
cmp cx,smallletterwidth
jne smalllettergdrawloop
mov cx,0
inc dx
cmp dx,smallletterheight
jne smalllettergdrawloop
;;;;;;;;;;;;;;;
pop dx
pop cx
pop bx
pop ax
ret
drawsmallletterg endp
;;;;;;;;;;;;;;;;;;;letter f procedure;;;;;;;
drawsmallletterf proc
push ax
push bx
push cx
push dx
;;;;;;;;;;;;;;;
lea bx,smallletterfdata
mov cx,0
mov dx,0
mov ah,0ch
smallletterfdrawloop:
mov al,[bx]
int 10h
inc cx
inc bx
cmp cx,smallletterwidth
jne smallletterfdrawloop
mov cx,0
inc dx
cmp dx,smallletterheight
jne smallletterfdrawloop
;;;;;;;;;;;;;;;
pop dx
pop cx
pop bx
pop ax
ret
drawsmallletterf endp
;;;;;;;;;;;;;;;;;;;letter i procedure;;;;;;;
drawsmallletteri proc
push ax
push bx
push cx
push dx
;;;;;;;;;;;;;;;
lea bx,smallletteridata
mov cx,0
mov dx,0
mov ah,0ch
smallletteridrawloop:
mov al,[bx]
int 10h
inc cx
inc bx
cmp cx,smallletterwidth
jne smallletteridrawloop
mov cx,0
inc dx
cmp dx,smallletterheight
jne smallletteridrawloop
;;;;;;;;;;;;;;;
pop dx
pop cx
pop bx
pop ax
ret
drawsmallletteri endp
;;;;;;;;;;;;;;;;;;;letter s procedure;;;;;;;
drawsmallletters proc
push ax
push bx
push cx
push dx
;;;;;;;;;;;;;;;
lea bx,smalllettersdata
mov cx,0
mov dx,0
mov ah,0ch
smalllettersdrawloop:
mov al,[bx]
int 10h
inc cx
inc bx
cmp cx,smallletterwidth
jne smalllettersdrawloop
mov cx,0
inc dx
cmp dx,smallletterheight
jne smalllettersdrawloop
;;;;;;;;;;;;;;;
pop dx
pop cx
pop bx
pop ax
ret
drawsmallletters endp
;;;;;;;;;;;;;;;;;;;letter h procedure;;;;;;;
drawsmallletterh proc
push ax
push bx
push cx
push dx
;;;;;;;;;;;;;;;
lea bx,smallletterhdata
mov cx,0
mov dx,0
mov ah,0ch
smallletterhdrawloop:
mov al,[bx]
int 10h
inc cx
inc bx
cmp cx,smallletterwidth
jne smallletterhdrawloop
mov cx,0
inc dx
cmp dx,smallletterheight
jne smallletterhdrawloop
;;;;;;;;;;;;;;;
pop dx
pop cx
pop bx
pop ax
ret
drawsmallletterh endp
;;;;;;;;;;;;;;;;;;;letterB procedure;;;;;;;
drawletterB proc
push ax
push bx
push cx
push dx
;;;;;;;;;;;;;;;
lea bx,letterBdata
mov cx,0
mov dx,0
mov ah,0ch
letterBdrawloop:
mov al,[bx]
int 10h
inc cx
inc bx
cmp cx,letterwidth
jne letterBdrawloop
mov cx,0
inc dx
cmp dx,letterheight
jne letterBdrawloop
;;;;;;;;;;;;;;;
pop dx
pop cx
pop bx
pop ax
ret
drawletterB endp
;;;;;;;;;;;;;;;;;;;letterF procedure;;;;;;;
drawletterF proc
push ax
push bx
push cx
push dx
;;;;;;;;;;;;;;;
lea bx,letterFdata
mov cx,0
mov dx,0
mov ah,0ch
letterFdrawloop:
mov al,[bx]
int 10h
inc cx
inc bx
cmp cx,letterwidth
jne letterFdrawloop
mov cx,0
inc dx
cmp dx,letterheight
jne letterFdrawloop
;;;;;;;;;;;;;;;
pop dx
pop cx
pop bx
pop ax
ret
drawletterF endp
;;;;;;;;;;;;;;;;;;;letterH procedure;;;;;;;
drawletterH proc
push ax
push bx
push cx
push dx
;;;;;;;;;;;;;;;
lea bx,letterHdata
mov cx,0
mov dx,0
mov ah,0ch
letterHdrawloop:
mov al,[bx]
int 10h
inc cx
inc bx
cmp cx,letterwidth
jne letterHdrawloop
mov cx,0
inc dx
cmp dx,letterheight
jne letterHdrawloop
;;;;;;;;;;;;;;;
pop dx
pop cx
pop bx
pop ax
ret
drawletterH endp
;;;;;;;;;;;;;;;;;;;letterS procedure;;;;;;;
drawletterS proc
push ax
push bx
push cx
push dx
;;;;;;;;;;;;;;;
lea bx,letterSdata
mov cx,0
mov dx,0
mov ah,0ch
letterSdrawloop:
mov al,[bx]
int 10h
inc cx
inc bx
cmp cx,letterwidth
jne letterSdrawloop
mov cx,0
inc dx
cmp dx,letterheight
jne letterSdrawloop
;;;;;;;;;;;;;;;
pop dx
pop cx
pop bx
pop ax
ret
drawletterS endp
; ;;;;;;;;;;;;;;;;;;;letterI procedure;;;;;;;
drawletterI proc
push ax
push bx
push cx
push dx
;;;;;;;;;;;;;;;
lea bx,letterIdata
mov cx,0
mov dx,0
mov ah,0ch
letterIdrawloop:
mov al,[bx]
int 10h
inc cx
inc bx
cmp cx,letterwidth
jne letterIdrawloop
mov cx,0
inc dx
cmp dx,letterheight
jne letterIdrawloop
;;;;;;;;;;;;;;;
pop dx
pop cx
pop bx
pop ax
ret
drawletterI endp
;;;;;;;;;;;;;;;;;;;letterN procedure;;;;;;;
drawletterN proc
push ax
push bx
push cx
push dx
;;;;;;;;;;;;;;;
lea bx,letterNdata
mov cx,0
mov dx,0
mov ah,0ch
letterNdrawloop:
mov al,[bx]
int 10h
inc cx
inc bx
cmp cx,letterwidth
jne letterNdrawloop
mov cx,0
inc dx
cmp dx,letterheight
jne letterNdrawloop
;;;;;;;;;;;;;;;
pop dx
pop cx
pop bx
pop ax
ret
drawletterN endp
;;;;;;;;;;;;;;;;cry procedure;;;;;;;;;;;;;;;
drawcry proc
push ax
push bx
push cx
push dx
;;;;;;;;;;;open file;;;;;;;;;
mov ah,3dh
mov al,0
lea dx,cryfilename
int 21h
mov [cryfilehandle],ax
;;;;;;;;;;read data;;;;;;;;;;;
mov ah,3fh
mov bx,[cryfilehandle]
mov cx,eggwidth*eggheight
lea dx,crydata
int 21h
;;;;;;;;;;;;;;;
lea bx,crydata
mov cx,200
mov dx,40
mov ah,0ch
crydrawloop:
mov al,[bx]
int 10h
inc cx
inc bx 
cmp cx,eggwidth+200
jne crydrawloop
mov cx,200
inc dx
cmp dx,eggheight+40
jne crydrawloop
;;;;;;;;;;;;;;;;;;close file;;;;
MOV AH, 3Eh
MOV BX, [cryfilehandle]
INT 21h
pop dx
pop cx
pop bx
pop ax
ret
drawcry endp
;;;;;;;;;;;;;;;;egg procedure;;;;;;;;;;;;;;;
drawegg proc
push ax
push bx
push cx
push dx
;;;;;;;;;;;open file;;;;;;;;;
mov ah,3dh
mov al,0
lea dx,eggfilename
int 21h
mov [eggfilehandle],ax
;;;;;;;;;;read data;;;;;;;;;;;
mov ah,3fh
mov bx,[eggfilehandle]
mov cx,eggwidth*eggheight
lea dx,eggdata
int 21h
;;;;;;;;;;;;;;;
lea bx,eggdata
mov cx,200
mov dx,40
mov ah,0ch
eggdrawloop:
mov al,[bx]
int 10h
inc cx
inc bx 
cmp cx,eggwidth+200
jne eggdrawloop
mov cx,200
inc dx
cmp dx,eggheight+40
jne eggdrawloop
;;;;;;;;;;;;;;;;;;close file;;;;
MOV AH, 3Eh
MOV BX, [eggfilehandle]
INT 21h
pop dx
pop cx
pop bx
pop ax
ret
drawegg endp
;;;;;;;;;;;;;;;music code;;;;;;;;;;;;;
music proc NEAR
push ax
push bx
push cx
push dx
sound :     

MOV     DX,2000          ; Number of times to repeat whole routine.

MOV     BX,1             ; Frequency value.

MOV     AL, 10110110B    ; The Magic Number (use this binary number only)
OUT     43H, AL          ; Send it to the initializing port 43H Timer 2.

NEXT_FREQUENCY:          ; This is were we will jump back to 2000 times.

MOV     AX, BX           ; Move our Frequency value into AX.

OUT     42H, AL          ; Send LSB to port 42H.
MOV     AL, AH           ; Move MSB into AL  
OUT     42H, AL          ; Send MSB to port 42H.

IN      AL, 61H          ; Get current value of port 61H.
OR      AL, 00000011B    ; OR AL to this value, forcing first two bits high.
OUT     61H, AL          ; Copy it to port 61H of the PPI Chip
                         ; to turn ON the speaker.

MOV     CX, 100          ; Repeat loop 100 times
DELAY_LOOP:              ; Here is where we loop back too.
LOOP    DELAY_LOOP       ; Jump repeatedly to DELAY_LOOP until CX = 0


INC     BX               ; Incrementing the value of BX lowers 
                         ; the frequency each time we repeat the
                         ; whole routine

DEC     DX               ; Decrement repeat routine count

CMP     DX, 0            ; Is DX (repeat count) = to 0
JNZ     NEXT_FREQUENCY   ; If not jump to NEXT_FREQUENCY
                         ; and do whole routine again.

                         ; Else DX = 0 time to turn speaker OFF

IN      AL,61H           ; Get current value of port 61H.
AND     AL,11111100B     ; AND AL to this value, forcing first two bits low.
OUT     61H,AL           ; Copy it to port 61H of the PPI Chip
                         ; to
pop dx
pop cx
pop bx
pop ax
ret
music endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
main proc far
mov ax , @data
mov DS , ax
;;;;;;;;;;;;;;graphics mode;;;;;;;;;;;
mov ah,0
mov al,13h
int 10h

call welcomescreen
;;;;;;;;;;;;;;;load images ;;;;;;;;;;;;;;;;;;;;;;;
callopenfile letterNfilename,letterNfilehandle
callloaddata letterNfilehandle,letterNdata,letterwidth,letterheight
callclosefile letterNfilehandle

callopenfile letterEfilename,letterEfilehandle
callloaddata letterEfilehandle,letterEdata,letterwidth,letterheight
callclosefile letterEfilehandle


callopenfile letterGfilename,letterGfilehandle
callloaddata letterGfilehandle,letterGdata,letterwidth,letterheight
callclosefile letterGfilehandle

callopenfile letterFfilename,letterFfilehandle
callloaddata letterFfilehandle,letterFdata,letterwidth,letterheight
callclosefile letterFfilehandle

callopenfile letterHfilename,letterHfilehandle
callloaddata letterHfilehandle,letterHdata,letterwidth,letterheight
callclosefile letterHfilehandle

callopenfile letterSfilename,letterSfilehandle
callloaddata letterSfilehandle,letterSdata,letterwidth,letterheight
callclosefile letterSfilehandle

callopenfile letterIfilename,letterIfilehandle
callloaddata letterIfilehandle,letterIdata,letterwidth,letterheight
callclosefile letterIfilehandle

callopenfile letterBfilename,letterBfilehandle
callloaddata letterBfilehandle,letterBdata,letterwidth,letterheight
callclosefile letterBfilehandle

callopenfile smallletterefilename,smallletterefilehandle
callloaddata smallletterefilehandle,smallletteredata,smallletterwidth,smallletterheight
callclosefile smallletterefilehandle

callopenfile smalllettergfilename,smalllettergfilehandle
callloaddata smalllettergfilehandle,smalllettergdata,smallletterwidth,smallletterheight
callclosefile smalllettergfilehandle

callopenfile smallletterffilename,smallletterffilehandle
callloaddata smallletterffilehandle,smallletterfdata,smallletterwidth,smallletterheight
callclosefile smallletterffilehandle

callopenfile smallletterifilename,smallletterifilehandle
callloaddata smallletterifilehandle,smallletteridata,smallletterwidth,smallletterheight
callclosefile smallletterifilehandle

callopenfile smalllettersfilename,smalllettersfilehandle
callloaddata smalllettersfilehandle,smalllettersdata,smallletterwidth,smallletterheight
callclosefile smalllettersfilehandle

callopenfile smallletterhfilename,smallletterhfilehandle
callloaddata smallletterhfilehandle,smallletterhdata,smallletterwidth,smallletterheight
callclosefile smallletterhfilehandle

drawpic 0,pointy,letterEdata
drawpic 60,pointy,letterBdata
drawpic 120,pointy,letterNdata

;;;;;;;;;;the start of the game ;;;;;;;;;;;
startloop:
mov pointy,0
call clearblock;;;;;;;;to clear screen with white
mov clearwidth,180
mov dh , 00
mov dl , 30
mov bh , 0
mov bl,04h
mov ah , 2
int 10h
printstring stringscore
mov score,0000
writescore score
call drawheart
writeheart heart
call drawegg
firstletter:
call clearbuffer
inc pointy
drawpic 0,pointy,letterEdata
drawpic 60,pointy,letterBdata
drawpic 120,pointy,letterNdata
;;;;;;;;;;condition if the right key is pressed;;;;;;
mov ah,1
int 16h
cmp ah,18;;;scancode E
je secondletter;;;;;;;;;;;;;;; jmp to the second letter
cmp pointy,140
ja lose;;;;;;;jmp to lose
jmp firstletter
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
secondletter:
smalldrawpic 200,150,smallletteredata
call music
call increasescore
call clearblock;;;;;;;;to clear screen
call clearbuffer
mov pointy,0
L2:
call clearbuffer
drawpic 0,pointy,letterSdata
drawpic 60,pointy,letterGdata
drawpic 120,pointy,letterIdata
inc pointy
mov ah,1
int 16h
cmp ah,34;;;scancode G
je thirdletter;;;;;;;;;;;;;;; jmp to the third letter
cmp pointy,140
ja lose;;;;;;;jmp to lose
jmp L2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
thirdletter:
smalldrawpic 240,150,smalllettergdata
call music
call increasescore
call clearblock;;;;;;;;to clear screen
call clearbuffer
mov pointy,0
L3:
call clearbuffer
drawpic 0,pointy,letterGdata
drawpic 60,pointy,letterIdata
drawpic 120,pointy,letterFdata
inc pointy
mov ah,1
int 16h
cmp ah,34;;;scancode G
je secondphoto;;;;;;;;;;;;;;; jmp to the second photo
cmp pointy,140
ja lose;;;;;;;jmp to lose
jmp L3
;;;;;;;;;;;;;;;;;
secondphoto:
smalldrawpic 280,150,smalllettergdata
call music
mov clearwidth,320
call clearblock
mov dh , 00
mov dl , 30
mov bh , 0
mov bl,04h
mov ah , 2
int 10h
printstring stringscore
call increasescore
call drawheart
writeheart heart
call drawfish
call clearbuffer
mov pointy,0
mov clearwidth,180
;;;;;;;;;;;;;;;;;;letter f;;;;;
P2L1:
call clearbuffer
drawpic 0,pointy,letterBdata
drawpic 60,pointy,letterHdata
drawpic 120,pointy,letterFdata
inc pointy
mov ah,1
int 16h
cmp ah,33;;;scancode f
je P2secondletter;;;;;;;;;;;;;;; jmp to the third letter
cmp pointy,140
ja lose;;;;;;;jmp to lose
jmp P2L1
;;;;;;;;;;;;;;;;;;;;;;;
P2secondletter:
smalldrawpic 200,150,smallletterfdata
call increasescore
call music
call clearblock
call clearbuffer
mov pointy,0
;;;;;;;;;;;;;;;; letter I;;;;;;;;;;
P2L2:
call clearbuffer
drawpic 0,pointy,letterNdata
drawpic 60,pointy,letterIdata
drawpic 120,pointy,letterEdata
inc pointy
mov ah,1
int 16h
cmp ah,23;;;scancode I
je P2thirdrdletter;;;;;;;;;;;;;;; jmp to the third letter
cmp pointy,140
ja lose;;;;;;;jmp to lose
jmp P2L2
;;;;;;;;;;;;;;;;;;;;;;;;;;
P2thirdrdletter:
smalldrawpic 230,150,smallletteridata
call music
call increasescore
call clearblock
call clearbuffer
mov pointy,0
;;;;;;;;;;;;; letter s;;;;;;;
P2L3:
call clearbuffer
drawpic 0,pointy,letterSdata
drawpic 60,pointy,letterBdata
drawpic 120,pointy,letterGdata
inc pointy
mov ah,1
int 16h
cmp ah,31;;;scancode S
je P2forthletter;;;;;;;;;;;;;;; jmp to the third letter
cmp pointy,140
ja lose;;;;;;;jmp to lose
jmp P2L3
;;;;;;;;;;;;;;;;;;;;;;;;;;
P2forthletter:
smalldrawpic 260,150,smalllettersdata
call music
call increasescore
call clearblock
call clearbuffer
mov pointy,0
;;;;;;;;;;;;;;;;;letter H;;;;;;;
P2L4:
call clearbuffer
drawpic 0,pointy,letterIdata
drawpic 60,pointy,letterHdata
drawpic 120,pointy,letterNdata
inc pointy
mov ah,1
int 16h
cmp ah,35;;;scancode H
je winner;;;;;;;;;;;;;;; jmp to the third letter
cmp pointy,140
ja lose;;;;;;;jmp to lose
jmp P2L4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
winner:
smalldrawpic 287,150,smallletterhdata
call music
call increasescore
mov clearwidth,320
call clearblock
mov dh , 10
mov dl , 10
mov bh , 0
mov bl,04h
mov ah , 2
int 10h
printstring win
call drawegg
mov dh , 150
mov dl , 46
mov bh , 0
mov bl,04h
mov ah , 2
int 10h
printstring playagain
mov dh , 00
mov dl , 30
mov bh , 0
mov bl,04h
mov ah , 2
int 10h
printstring stringscore
writescore score
call drawheart
writeheart heart
mov heart,3
;;;;;;;;;;;
call clearbuffer
mov ah,0
int 16h
w:jmp startloop
;;;;;;;;;;;;;;;;;;;;;;;;;;
lose:
dec heart
cmp heart,0
je tryagain
mov clearwidth,320
jmp startloop
tryagain:
mov clearwidth,320
call clearblock
mov dh , 10
mov dl , 10
mov bh , 0
mov bl,04h
mov ah , 2
int 10h
printstring gameover
call drawcry
mov dh , 150
mov dl , 46
mov bh , 0
mov bl,04h
mov ah , 2
int 10h
printstring playagain
mov dh , 00
mov dl , 30
mov bh , 0
mov bl,04h
mov ah , 2
int 10h
printstring stringscore
writescore score
call drawheart
writeheart heart
mov heart,3
;;;;;;;;;;;
call clearbuffer
mov ah,0
int 16h
jmp startloop
;;;;;;;;;;;;;;;;;;
main endp
end main

