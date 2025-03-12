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