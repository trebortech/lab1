{% if grains['os_family'] == 'RedHat' %}
    {% set sshd = 'sshd' %}

{% elif grains['os_family'] == 'Debian' %}
    {% set sshd = 'ssh' %}

{% endif %}


#######################################################
#  Install base packages
#######################################################

"Install yubico repo":
  pkgrepo.managed:
    - ppa: yubico/stable
    - refresh_db: True

"Install yubico package":
  pkg.installed:
    - name: libpam-yubico


#######################################################
#  Deploy configuration files
#######################################################

"Stage mapping file":
  file.managed:
    - name: '/etc/yubikey_mappings'
    - source: salt://yubikey/yubikey_mappings
    - mode: 644
    - user: root
    - group: root


"Update pam files":
  file.managed:
    - name: '/etc/pam.d/common-auth'
    - source: salt://yubikey/common-auth
    - mode: 644
    - user: root
    - group: root

"Update ChallengeResponseAuthentication":
  file.replace:
    - name: '/etc/ssh/sshd_config'
    - pattern: 'ChallengeResponseAuthentication no'
    - repl: 'ChallengeResponseAuthentication yes'
    - backup: False

"Update PasswordAuthentication":
  file.replace:
    - name: '/etc/ssh/sshd_config'
    - pattern: 'PasswordAuthentication yes'
    - repl: 'PasswordAuthentication no'
    - backup: False


"Restart SSHD service":
  cmd.wait:
    - name: 'sudo service {{ sshd }} restart'
    - use_vt: True
    - watch:
      - file: "Update ChallengeResponseAuthentication"
      - file: "Update PasswordAuthentication"


#######################################################
#  User management
#######################################################

"Add secure User":
  user.present:
    - name: secure
    - fullname: secure
    - shell: '/bin/bash'
    - password: '$1$RMGwjAU9$TrWN4VNEg3.6aDL2sJkV..'
    - optional_groups:
      - wheel
      - admin
      - sudo

"Remove authorized key file":
  file.absent:
    - name: /home/ubuntu/.ssh/authorized_keys
