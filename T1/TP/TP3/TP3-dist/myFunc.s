    .data
A:  .double 8.0, 1.0,2.0,3.0,4.0,5.0,7.0,8.0,9.0,10.0,11.0,12.0
B:  .double 3.0,14.0,13.0,4.0,8.0,9.0,8.0,7.0,6.0,5.0,4.0,3.0
N:  .word 12

    .text
main:
    ld    	r2,N(r0)	    ; r2 = N
    dadd  	r1,r0,r0	    ; r1 = i = 0
    dadd  	r3,r0,r0	    ; r3 = 0
    	
    
loop: 
	l.d 	f0,A(r1)	    ; A[i]	
    l.d 	f1,B(r1)	    ; B[i]
   	andi 	r3, r1, 8       ; comparaison impair    
   	bnez 	r3, impair      ; si impair jump a la fonction impair
   	
    sub.d 	f1,f1,f0      	; si pair, B[i] = B[i] - A[i]
    jal 	finPrgm		    ; Sauter la fonction impair
    	
	impair: 
	add.d 	f1,f1,f0 	    ; B[i] = B[i] + A[i]

	finPrgm:
	daddi 	r2,r2,-1	    ; N++
	daddi 	r1,r1,8		    ; i++
	s.d 	f1,B(r0)	    ; stocke dans B[i] la valeur adéquate  
   	bne   	r2,r0,loop
	halt  



