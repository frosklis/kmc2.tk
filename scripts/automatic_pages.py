import yaml
import os
import glob
import re

self_dir = os.path.dirname(os.path.abspath(__file__))
data_path = '%s/../data/' % self_dir
blog_path = '%s/../content/posts/' % self_dir

template_viaje = """---
url: {url}
type: viaje
---
"""

template_gallery = """---
url: {url}
type: gallery
---
"""



def main():
    data = yaml.load(open('%s%s' % (data_path, 'viajes.yaml')))

    for viaje_dir in os.listdir(blog_path):
        fullpath = "%s%s" % (blog_path, viaje_dir)
        if not os.path.isdir(fullpath):
            continue
        files = os.listdir(fullpath)

        sanitized = re.findall(r"\d\d\d\d-(.*)", viaje_dir)[0]
        with open("%s/%s" % (fullpath, '_index.md'), 'w') as f:
            f.write(template_viaje.format(url="/viaje/%s/" % sanitized))
        
        if os.path.exists("%s/index.md" % fullpath):
            os.remove("%s/index.md" % fullpath)

        url = re.findall(r"url: ?(.*)\n", open("%s/%s" % (fullpath, '_index.md'), 'r').read())[0]
        string = template_gallery.format(url="%sgallery/" % url)
        with open("%s/%s" % (fullpath, 'gallery.md'), 'w') as f:
            f.write(string)


if __name__ == '__main__':
    main()

