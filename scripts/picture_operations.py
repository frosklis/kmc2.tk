#!/usr/bin/python
import os
import datetime
self_dir = os.path.dirname(os.path.abspath(__file__))
data_path = '%s/../data/' % self_dir
blog_path = '%s/../content/posts/' % self_dir

# traverse root directory, and list directories as dirs and files as files
pictures = []
paths = {}

# Asumimos que todas las que están en un directorio válido son buenas
for root, dirs, files in os.walk(blog_path):
    path = root.split(os.sep)
    try:
        path_date = datetime.datetime.strptime(os.path.basename(root)[:10], '%Y-%m-%d')
        paths[path_date] = root
    except ValueError:
        print((len(path) - 1) * '---', os.path.basename(root))
    
        for file in files:
            if file.endswith('jpg'):
                picture_date = datetime.datetime.strptime(file[:8], '%Y%m%d')
                if picture_date != path_date:
                    pictures.append((root, file, picture_date))
        # print(len(path) * '---', file, root)

for from_dir, file, p_date in pictures:
    to_dir = paths.get(p_date, None)
    if to_dir:
        print('moving' , file, 'to', to_dir)
        os.replace(
            "%s%s%s" % (from_dir,os.sep,file),
            "%s%s%s" % (to_dir,os.sep,file)
            )


