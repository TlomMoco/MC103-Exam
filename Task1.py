import string

cipher = ["IJKLE LWPZQ LRTCW QFWWZ QDZFY OLYOQ FCJDT RYTQJ TYRYZ ESTYR",
          "QBBJXUMEHBTYIQIJQWUQDTQBBJXUCUDQDTMECUDCUHUBOFBQOUHI",
          "ZA z9 TcVmVi A5 3zE kyz4x9 r SzA sF vE6r4uz4x R26yrsvA r4u ruuz4x 4B3sv89"]

def caesar_cipher_decrypt(cipher):    
    has_upper = any(char.isupper() for char in cipher)
    has_lower = any(char.islower() for char in cipher)
    has_digit = any(char.isdigit() for char in cipher)

    if has_lower and has_upper and has_digit:
        alphabet = string.ascii_uppercase + string.ascii_lowercase + string.digits
    else:
        alphabet = string.ascii_uppercase
    alphabet_length = len(alphabet)

    for shift in range(1, alphabet_length): 
        decrypted_text = ""

        for char in cipher:
            if char in alphabet:
                new_index = alphabet.index(char) - shift
                if new_index < 0:
                    new_index += alphabet_length
                decrypted_text += alphabet[new_index].upper()
            else:
                decrypted_text += char

        print(f"Shift {shift}: {decrypted_text}\n")

for item in cipher:    
    caesar_cipher_decrypt(item)
