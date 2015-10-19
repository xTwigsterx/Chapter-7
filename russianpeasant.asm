;zachariah Alber
;based on http://mathforum.org/dr.math/faq/faq.peasant.html
;needs work at the test area
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
	test ebx,00000001 ; test if odd
	jz addition ; jumps to addition
	loop L1 ; reloop
	
addition:
	add bank, eax ; adds eax to bank
	test ebx, 00000010 ; checks if even  
	je done ; ends the process
	jmp L1 ; jumps back into the loop
	

done:
	invoke ExitProcess,0
main endp
end main
