# @file   des_block_demo.py 
# @brief  How to use des_block class.
# @author Laurent Sauvage <laurent.sauvage@telecom-paristech.fr>

from des_block import *

KSHIFTS= ( 0, 1, 1, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 1 )

if __name__ == "__main__":

   #========================================
   P= des_block("0x0123456789abcdef", 64) # Create a 64-bit wide DES block
   print("P={} (hex) {} (dec)".format(P, P.value()))
   #========================================
   L0, R0= P.ip() # Initial permutation
   print("L0= {} Ro={}".format(L0, R0))
   invip_ip_P= L0.concat(R0).ip(-1) # Inverse of Initial permutation
   print("invip_ip_P=", invip_ip_P)
   print("diff=", P.xor(invip_ip_P))
   #========================================
   KEY= des_block("0xfedcba9876543210", 64) # Create a 64-bit wide DES block
   print("Master KEY=", KEY)
   pc1_KEY= KEY.pc1() # @note Inverse of pc1() = pc1(-1)
   C0= pc1_KEY.subblock( 0, 28) 
   D0= pc1_KEY.subblock(28, 56) 
   C1= C0.ls(KSHIFTS[1]) # @note Left shift of n : ls(n)
                         #       Inverse of left shift : rs(n)
                         #       KSHIFTS[r] = number of shifts for round r
   D1= D0.ls(KSHIFTS[1])
   K1= C1.concat(D1).pc2() # @note Inverse of pc2() = pc2(-1)
   print("Round Key K1=", K1)
   #========================================
   inS= R0.e().xor(K1)
   outS= des_block()
   for i in range(0, 8): # for Sbox from 0 to 7
      outS= outS.concat( inS.subblock(6*i, 6*i+6).s(i) )
   R1= outS.p().xor(L0) # @note Inverse of p() : p(-1)
   print("R1=", R1)
