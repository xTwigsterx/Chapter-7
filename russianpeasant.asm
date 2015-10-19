;zachariah Alber
;based on http://mathforum.org/dr.math/faq/faq.peasant.html
386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
numX dword 15
numY dword 25
bank dword 0

.code
main PROC

mov eax, numX
mov ebx, numY

L1:
	mult eax,2 ; multiplies eax by 2 
	div  ebx,2 ; divides ebx by 2
	test ebx, ebx, 00000001 ; test to odd
	jz addition ; jumps to addition
	loop L1
	
addition:
	add bank, eax ;  
	jmp L1
	

done:
	invoke ExitProcess,0
main endp
end main
