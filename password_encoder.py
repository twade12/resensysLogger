import math
import string
import random
import sys

# Function which takes the input password as sid and outputs the correct encryption
def password_encoding_generator(password):
    password_bytes = bytes(password, 'ascii')
    byte_list = []
    for byte in password_bytes:
        byte_list.append(byte)
    reverse_list = byte_list[::-1]
    # loop through every element of the reversed array
    for i in range(len(reverse_list)):
        new_byte = (int(math.pow(-1, i))*(i%10))
        reverse_list[i] += new_byte
    # decode the new array
    encoded_characters = []
    for j in range(len(reverse_list)):
        encoded_characters.append(chr(reverse_list[j]))
    encoded_password = ''.join(encoded_characters)
    return encoded_password

def password_decoder(encryption):
    encryption_bytes = encryption.encode( 'utf-8')
    byte_list = []
    for byte in encryption_bytes:
        byte_list.append(byte)

    for i in range(len(byte_list)):
        new_byte = (int(math.pow(-1, i))*(i%10))
        byte_list[i] -= new_byte

    reverse_list = byte_list[::-1]
    encoded_characters = []
    for j in range(len(reverse_list)):
        encoded_characters.append(chr(reverse_list[j]))
    decrypted_password = ''.join(encoded_characters)
    return decrypted_password

if __name__ == "__main__":
    encoding = password_encoding_generator(sys.argv[1])
    print(encoding.replace(";",":"))
