      .data

A:    .double 8.0,1.0,2.0,3.0,4.0,5.0,7.0,8.0,9.0,10.0,11.0,12.0
sum: .double 0.0
N:    .word 12

      .text
main:
      	l.d   f1,sum(r0)	; f1 = 0.0 premiere iteration
      	dadd  r1,r0,r0		; r1 = i = 0
	ld    r2,N(r0)		; r2 = N  
      
loop:	
	l.d   f0,A(r1)		; f0 = A[i]
      	add.d f1,f1,f0		; f1 = f1 + A[i], f1 = 0.0 premiere iteration
      	daddi r2,r2,-1		; N++
      	daddi r1,r1,8		; i++
      	s.d   f1,sum(r0)	; stock f1 dans sum
      	bne   r2,r0,loop	; boucle
      	halt
