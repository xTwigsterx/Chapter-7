; Zachariah Alber
;russian peasant multiplication algorithm

386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
numX dword 15
numY dword 24


.code
main PROC

mov eax, numX
mov ebx, numY

L1:
	mult eax,2 ; 
	div  ebx,2 ;
	test ebx, ebx, 00000001 ;
	jz Redo
	loop L1
	
Redo:
	jmp L1

done:
	invoke ExitProcess,0
main endp
end main

 
