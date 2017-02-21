
# Uninstall nginx, cmatrix

"Remove packages":
  pkg.removed:
    - pkgs:
      - nginx
      - cmatrix

# Rename
# /etc/salt/master.d/fileserver.conf
"Update file manager name":
  file.rename:
    - name: '/etc/salt/master.d/fileserver.conf.bak'
    - source: '/etc/salt/master.d/fileserver.conf'

# remove version grain
"Remove version grain":
  grains.absent:
    - name: version

# 