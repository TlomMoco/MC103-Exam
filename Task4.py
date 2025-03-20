import hashlib
import pandas as pd
import tabulate


# Function for computing the names to hashes 
def compute_hashes(names):
    data = []
    
    for name in names:
        encoded_names = {
            'name': name,
            'sha-1': hashlib.sha1(name.encode()).hexdigest(),
            'sha256': hashlib.sha256(name.encode()).hexdigest(),
            'md5': hashlib.md5(name.encode()).hexdigest(),
            'ripemd160': hashlib.new('ripemd160', name.encode()).hexdigest()
        }
        data.append(encoded_names)
    df = pd.DataFrame(data)

    print(tabulate.tabulate(df, headers='keys', tablefmt='simple'))


names = ['Mariusz', 'Sarah', 'Fabian','Daniel']

compute_hashes(names)


# Task 4e: Hash Identification
def calculate_hash_length(hash_value):
    hash_length_chars = len(hash_value)
    hash_length_bits = hash_length_chars * 4  # Each hex character represents 4 bits
    return hash_length_chars, hash_length_bits

def determine_hash_algorithm(hash_length_bits):
    hash_algorithms = {
        128: ["MD5"],
        160: ["SHA-1", "RIPEMD-160"],
        224: ["SHA-224"],
        256: ["SHA-256"],
        384: ["SHA-384"],
        512: ["SHA-512"]
    }
    return hash_algorithms.get(hash_length_bits, ["Unknown Hash Algorithm"])

hash_input = "408d890298c4963dfaac2e8b508552b9e1ee8048"

char_length, bit_length = calculate_hash_length(hash_input)

possible_algorithms = determine_hash_algorithm(bit_length)

print(f"Hash: {hash_input}")
print(f"Length: {char_length} characters")
print(f"Bit-Length: {bit_length} bits")
print(f"Possible Hashing Algorithms: {', '.join(possible_algorithms)}")