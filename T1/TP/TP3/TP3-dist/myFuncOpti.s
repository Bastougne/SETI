    .data
A:  .double 8.0, 1.0,2.0,3.0,4.0,5.0,7.0,8.0,9.0,10.0,11.0,12.0
B:  .double 3.0,14.0,13.0,4.0,8.0,9.0,8.0,7.0,6.0,5.0,4.0,3.0
N:  .word 12

    .text
main:
    dadd  r1,r0,r0		; r1 = i = 0
	ld    r2,N(r0)		; r2 = N	
    daddi r3,r0,8		; r3 = i + 1

loop:		
	l.d 	f0,A(r1)	    ; A[i]	
    l.d 	f1,B(r1)	    ; B[i]
    l.d 	f2,A(r3)	    ; A[i+1]
    l.d 	f3,B(r3)	    ; B[i+1]
    	
    sub.d 	f1,f1,f0      	; B[i] = B[i] - A[i], la premiere iteration est pair
    add.d 	f3,f3,f2 	    ; B[i+1] = B[i+1] + A[i+1]
    	
    daddi 	r2,r2,-2	    ; N++
	daddi 	r1,r1,16	    ; i++
	s.d 	f1,B(r0)	    ; stocke dans B[i] la valeur adéquate
	s.d 	f3,B(r0)	    ; stocke dans B[i+1] la valeur adéquate 
    bne     r2,r0,loop
	halt  


