#!/usr/bin/python
import os
import pandas as pd
import yaml

self_dir = os.path.dirname(os.path.abspath(__file__))
data_path = '%s/../data/' % self_dir
blog_path = '%s/../content/posts/' % self_dir

def main():
    data = pd.read_csv(f'{data_path}pictures.tsv', sep='\t').set_index('file')
    data_dict = data.to_dict('index')
    with open(f'{data_path}pictures.yaml', 'w') as f:     
        f.write(yaml.dump(data_dict))

if __name__ == '__main__':
    main()
