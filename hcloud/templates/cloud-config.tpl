#cloud-config
# vim: syntax=yaml

users:
  - name: ${user.name}
    groups: users, admin
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh_authorized_keys:
      - ${user.key}

write_files:
  - path: /etc/sysctl.d/k8s.conf
    content: |
      net.bridge.bridge-nf-call-ip6tables = 1
      net.bridge.bridge-nf-call-iptables = 1

apt:
  sources:
    kubernetes:
      source: "deb http://apt.kubernetes.io/ kubernetes-xenial main"
      keyid: 7F92E05B31093BEF5A3C2D38FEEA9169307EA071

package_update: true
package_upgrade: true
packages:
  - git
  - jq
  - apt-transport-https
  - ca-certificates
  - curl
%{ for item in custom_packages ~}
  - ${item}
%{ endfor ~}

runcmd:
  - swapoff -a
  - sysctl --system
  - touch /home/${user.name}/cloud-init-has-finished
