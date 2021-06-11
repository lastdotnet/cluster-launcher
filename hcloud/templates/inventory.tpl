all:
  children:
    environment:
      hosts:
%{ for node in nodes ~}
        ${node.name}:
          ansible_host: ${node.public_ip}
          ip: ${node.private_ip}
%{ if length(regexall("master", node.name)) > 0 ~}
          etcd_member_name: ${node.name}
%{ endif ~}
%{ endfor ~}
      vars:
%{ for var in vars ~}
        ${var}
%{ endfor ~}
    etcd:
      hosts:
%{ for master in masters ~}
        ${master.name}: {}
%{ endfor ~}
    k8s_cluster:
      children:
        calico_rr: {}
        kube_control_plane:
          hosts:
%{ for master in masters ~}
            ${master.name}: {}
%{ endfor ~}
        kube_node:
          hosts:
%{ for worker in workers ~}
            ${worker.name}: {}
%{ endfor ~}
    ungrouped: {}
