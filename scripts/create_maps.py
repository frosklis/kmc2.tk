import yaml
import os
import glob
import re

self_dir = os.path.dirname(os.path.abspath(__file__))
data_path = '%s/../data/' % self_dir
blog_path = '%s/../content/posts/' % self_dir


def main():
    data = yaml.load(open('%s%s' % (data_path, 'viajes.yaml')))
    regions = []
    for viaje in data:
        if 'regions' not in viaje:
            continue
        regions.extend(viaje['regions'])

    print(','.join(["'%s'" % region for region in regions]))


if __name__ == '__main__':
    main()
