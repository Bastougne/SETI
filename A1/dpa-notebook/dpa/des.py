#!/usr/bin/env python

# initial permutation IP
des_ip = [57, 49, 41, 33, 25, 17, 9,  1,
          59, 51, 43, 35, 27, 19, 11, 3,
          61, 53, 45, 37, 29, 21, 13, 5,
          63, 55, 47, 39, 31, 23, 15, 7,
          56, 48, 40, 32, 24, 16, 8,  0,
          58, 50, 42, 34, 26, 18, 10, 2,
          60, 52, 44, 36, 28, 20, 12, 4,
          62, 54, 46, 38, 30, 22, 14, 6
          ]

# Expansion table for turning 32 bit blocks into 48 bits
des_expansion_table = [
    31,  0,  1,  2,  3,  4,
    3,  4,  5,  6,  7,  8,
    7,  8,  9, 10, 11, 12,
    11, 12, 13, 14, 15, 16,
    15, 16, 17, 18, 19, 20,
    19, 20, 21, 22, 23, 24,
    23, 24, 25, 26, 27, 28,
    27, 28, 29, 30, 31,  0
    ]

# The (in)famous S-boxes
des_sbox = [
    # S1
    [14, 4, 13, 1, 2, 15, 11, 8, 3, 10, 6, 12, 5, 9, 0, 7,
     0, 15, 7, 4, 14, 2, 13, 1, 10, 6, 12, 11, 9, 5, 3, 8,
     4, 1, 14, 8, 13, 6, 2, 11, 15, 12, 9, 7, 3, 10, 5, 0,
     15, 12, 8, 2, 4, 9, 1, 7, 5, 11, 3, 14, 10, 0, 6, 13],

    # S2
    [15, 1, 8, 14, 6, 11, 3, 4, 9, 7, 2, 13, 12, 0, 5, 10,
     3, 13, 4, 7, 15, 2, 8, 14, 12, 0, 1, 10, 6, 9, 11, 5,
     0, 14, 7, 11, 10, 4, 13, 1, 5, 8, 12, 6, 9, 3, 2, 15,
     13, 8, 10, 1, 3, 15, 4, 2, 11, 6, 7, 12, 0, 5, 14, 9],

    # S3
    [10, 0, 9, 14, 6, 3, 15, 5, 1, 13, 12, 7, 11, 4, 2, 8,
     13, 7, 0, 9, 3, 4, 6, 10, 2, 8, 5, 14, 12, 11, 15, 1,
     13, 6, 4, 9, 8, 15, 3, 0, 11, 1, 2, 12, 5, 10, 14, 7,
     1, 10, 13, 0, 6, 9, 8, 7, 4, 15, 14, 3, 11, 5, 2, 12],

    # S4
    [7, 13, 14, 3, 0, 6, 9, 10, 1, 2, 8, 5, 11, 12, 4, 15,
     13, 8, 11, 5, 6, 15, 0, 3, 4, 7, 2, 12, 1, 10, 14, 9,
     10, 6, 9, 0, 12, 11, 7, 13, 15, 1, 3, 14, 5, 2, 8, 4,
     3, 15, 0, 6, 10, 1, 13, 8, 9, 4, 5, 11, 12, 7, 2, 14],

    # S5
    [2, 12, 4, 1, 7, 10, 11, 6, 8, 5, 3, 15, 13, 0, 14, 9,
     14, 11, 2, 12, 4, 7, 13, 1, 5, 0, 15, 10, 3, 9, 8, 6,
     4, 2, 1, 11, 10, 13, 7, 8, 15, 9, 12, 5, 6, 3, 0, 14,
     11, 8, 12, 7, 1, 14, 2, 13, 6, 15, 0, 9, 10, 4, 5, 3],

    # S6
    [12, 1, 10, 15, 9, 2, 6, 8, 0, 13, 3, 4, 14, 7, 5, 11,
     10, 15, 4, 2, 7, 12, 9, 5, 6, 1, 13, 14, 0, 11, 3, 8,
     9, 14, 15, 5, 2, 8, 12, 3, 7, 0, 4, 10, 1, 13, 11, 6,
     4, 3, 2, 12, 9, 5, 15, 10, 11, 14, 1, 7, 6, 0, 8, 13],

    # S7
    [4, 11, 2, 14, 15, 0, 8, 13, 3, 12, 9, 7, 5, 10, 6, 1,
     13, 0, 11, 7, 4, 9, 1, 10, 14, 3, 5, 12, 2, 15, 8, 6,
     1, 4, 11, 13, 12, 3, 7, 14, 10, 15, 6, 8, 0, 5, 9, 2,
     6, 11, 13, 8, 1, 4, 10, 7, 9, 5, 0, 15, 14, 2, 3, 12],

    # S8
    [13, 2, 8, 4, 6, 15, 11, 1, 10, 9, 3, 14, 5, 0, 12, 7,
     1, 15, 13, 8, 10, 3, 7, 4, 12, 5, 6, 11, 0, 14, 9, 2,
     7, 11, 4, 1, 9, 12, 14, 2, 0, 6, 10, 13, 15, 3, 5, 8,
     2, 1, 14, 7, 4, 10, 8, 13, 15, 12, 9, 0, 3, 5, 6, 11],
    ]

# 32-bit permutation function P used on the output of the S-boxes
des_p = [
    15, 6, 19, 20, 28, 11,
    27, 16, 0, 14, 22, 25,
    4, 17, 30, 9, 1, 7,
    23,13, 31, 26, 2, 8,
    18, 12, 29, 5, 21, 10,
    3, 24
    ]

# Inverse of P
des_p_inv = [
    8, 16, 22, 30, 12, 27,  1, 17,
    23, 15, 29,  5, 25, 19,  9,  0,
    7, 13, 24,  2,  3, 28, 10, 18,
    31, 11, 21,  6,  4, 26, 14, 20
    ]


# Bit 0 = MSb of the first plaintext byte
def plaintext_to_bits(plaintext):
    result = [0] * 64
    pos = 0

    for val in plaintext:
        i = 7
        while i >= 0:
            if val & (1 << i) != 0:
                result[pos] = 1
            i -= 1
            pos += 1

    return result

# DEBUG
def subkey_to_bits(subkey):
    result = [0] * 48
    pos = 0

    for val in subkey:
        i = 7
        while i >= 0:
            if val & (1 << i) != 0:
                result[pos] = 1
            i -= 1
            pos += 1

    return result

# DEBUG
def print_bits(data):
    pos = 0
    c = 0
    while pos < len(data):
        c += data[pos] << (7 - (pos % 8))
        if (pos % 8) == 7:
            print ('%02x' % (c)),
            c = 0
        pos += 1


def key_hypothesis_to_bits(key_hypothesis):
    result = [0] * 6

    i = 5
    pos = 0
    while i >= 0:
        if key_hypothesis & (1 << i) != 0:
            result[pos] = 1
        i -= 1
        pos += 1

    return result


def permutate(table, data):
    return list(map(lambda x: data[x], table))


#
# Compute the Hamming Distance between the value of the 4 bits
# of the state register affected by the given sbox between the begining
# and the end of the first DES round
#
# sbox : sbox number (0-7)
# plaintext : list of the values of the 8 bytes of the plaintext
# key_hypothesis : value of the key hypothesis (0-63)
#
# return : 0-4
#
def des_first_round_hd_4bits(sbox, plaintext, key_hypothesis):
    plaintext_bits = plaintext_to_bits(plaintext)

    # Initial permutation
    after_ip = permutate(des_ip, plaintext_bits)

    L = after_ip[:32]
    R = after_ip[32:]

    # DEBUG
    #print '== First round =='
    #print 'In:',
    #print_bits(L)
    #print ' / ',
    #print_bits(R)
    #print ''

    # Feistel function

    # Expansion
    R_after_E = permutate(des_expansion_table, R)

    # XOR with subkey
    subkey = key_hypothesis_to_bits(key_hypothesis) * 8

    R_after_xor = list(map(lambda x, y: x^y, R_after_E, subkey))

    # SBox (complicated due to strange numbering of SBox table in the standard
    B = [R_after_xor[:6], R_after_xor[6:12], R_after_xor[12:18], R_after_xor[18:24], R_after_xor[24:30], R_after_xor[30:36], R_after_xor[36:42], R_after_xor[42:]]

    j = 0
    after_sbox = [0] * 32
    pos = 0
    while j < 8:
        # Work out the offsets
        m = (B[j][0] << 1) + B[j][5]
        n = (B[j][1] << 3) + (B[j][2] << 2) + (B[j][3] << 1) + B[j][4]

        # Find the permutation value
        v = des_sbox[j][(m << 4) + n]

        # Turn value into bits, add it to result: Bn
        after_sbox[pos] = (v & 8) >> 3
        after_sbox[pos + 1] = (v & 4) >> 2
        after_sbox[pos + 2] = (v & 2) >> 1
        after_sbox[pos + 3] = v & 1

        pos += 4
        j += 1

    # Permutation
    after_permutation = permutate(des_p, after_sbox)

    # XOR with L[i - 1]
    new_R = list(map(lambda x, y: x^y, after_permutation, L))
    new_L = R


    # DEBUG
    #print 'Out:',
    #print_bits(new_L)
    #print ' / ',
    #print_bits(new_R)
    #print ''


    # Select the bits affected by the selected sbox
    R_sbox_bits = [R[des_p_inv[sbox*4 + 0]], R[des_p_inv[sbox*4 + 1]],
                   R[des_p_inv[sbox*4 + 2]], R[des_p_inv[sbox*4 + 3]]]
    new_R_sbox_bits = [new_R[des_p_inv[sbox*4 + 0]], new_R[des_p_inv[sbox*4 + 1]],
                       new_R[des_p_inv[sbox*4 + 2]], new_R[des_p_inv[sbox*4 + 3]]]

    # Compute the Hamming Distance between the two consecutive values
    # of these bits
    hd = 0
    for i in range(4):
        if R_sbox_bits[i] != new_R_sbox_bits[i]:
            hd += 1

    return hd


def test():
    pass

if __name__ == "__main__":
    test()
