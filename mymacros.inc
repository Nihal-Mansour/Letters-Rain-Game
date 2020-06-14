drawpic macro x,y,imageData
push ax
push bx
push cx
push dx
	
	mov si,x
	mov bp,x
	MOV temp , BP
	mov di,y
    MOV CX,x ; x1
    MOV DX,y ; y1
	LEA BP , imageData ; BP contains index at the current drawn pixel
    call drawpixel 

pop dx
pop cx
pop bx
pop ax
endm drawpic 

smalldrawpic macro x,y,imageData
push ax
push bx
push cx
push dx
	
	mov si,x
	mov bp,x
	MOV temp , BP
	mov di,y
    MOV CX,x ; x1
    MOV DX,y ; y1
	LEA BP , imageData ; BP contains index at the current drawn pixel
    call smalldrawpixel 

pop dx
pop cx
pop bx
pop ax
endm smalldrawpic 

callOpenFile MACRO filename , fileHandle
    MOV AH, 3Dh
    MOV AL, 0 ; read only
    LEA DX, Filename
    INT 21h    
    MOV [Filehandle], AX
ENDM callOpenFile

callLoadData MACRO filehandle , imageData , _width , _height
	MOV AH,3Fh
    MOV BX, [Filehandle]
    MOV CX,_width*_height ; number of bytes to read
    LEA DX, imageData
    INT 21h
ENDM callLoadData

callCloseFile MACRO filehandle 
	MOV AH, 3Eh
	MOV BX, [Filehandle]
	INT 21h 
ENDM callCloseFile

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
printstring macro str
push ax
push dx
mov ah,09h
mov dx,offset str
int 21h
pop dx
pop ax
endm printstring
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
printnum macro inputdata 
local start , print 
push ax
push bx
push cx
push dx 
mov ax , inputdata
mov cx , 0
mov dx , 0
mov bx , 10

start:        
div bx        
add dl , '0'  
push dx       
mov dx , 0     
inc cx         

cmp ax , 0
jne start

print:
pop dx
mov ah , 2
int 21h
loop print
pop dx
pop cx
pop bx
pop ax
endm printnum
;;;;;;;;;;;;;;;;;;;;;;;;;;;
writescore macro score
push ax
push bx
push cx		   
push dx 
;;;set cursor;;;
mov dh , 00
mov dl , 23H
mov bh , 0
mov ah , 2
int 10h
;;;;;;;;;;;;;
mov ah , 2
mov dl , ':'
int 21h
;;;;;;;;;;;;
mov ax , score
printnum ax
pop dx
pop cx
pop bx
pop ax
endm writescore

writeheart macro heart
push ax
push bx
push cx
push dx
;;;set cursor;;;
mov dh , 02
mov dl , 23h
mov bh , 0
mov ah , 2
int 10h
;;;;;;;;;;;;;
mov ah , 2
mov dl , ':'
int 21h
;;;;;;;;;;;;
mov ax , heart
printnum ax
pop dx
pop cx
pop bx
pop ax
ENDM       writeheart