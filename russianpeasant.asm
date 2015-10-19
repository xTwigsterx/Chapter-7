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
	test eax,bank ; test if they are the same answer
	jz done ; ends the process
	loop L1 ; reloops
	
addition:
	add bank, eax ; adds eax to bank  
	jmp L1 ; jumps back into the loop
	

done:
	invoke ExitProcess,0
main endp
end main

