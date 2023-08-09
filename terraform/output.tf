output "output-ip-host" {
  value = <<OUTPUT

Application Load Balancer
external = ${yandex_alb_load_balancer.web-load-balancer.listener.*.endpoint.0.address.0.external_ipv4_address}

VM Bastion Host
internal = ${yandex_compute_instance.bastion-host.network_interface.0.ip_address}
external = ${yandex_compute_instance.bastion-host.network_interface.0.nat_ip_address}

VM Web-Server1
internal = ${yandex_compute_instance.web-server1.network_interface.0.ip_address}

VM Web-Server2
internal = ${yandex_compute_instance.web-server2.network_interface.0.ip_address}

VM Prometheus
internal = ${yandex_compute_instance.prometheus.network_interface.0.ip_address}

VM Grafana
internal = ${yandex_compute_instance.grafana.network_interface.0.ip_address}
external = ${yandex_compute_instance.grafana.network_interface.0.nat_ip_address}

VM ElasticSearch
internal = ${yandex_compute_instance.elasticsearch.network_interface.0.ip_address}

VM Kibana
internal = ${yandex_compute_instance.kibana.network_interface.0.ip_address}
external = ${yandex_compute_instance.kibana.network_interface.0.nat_ip_address}

OUTPUT
}

output "output-ansible-hosts" {
  value = <<OUTPUT

[bastion-host]
bastion-host ansible_host=${yandex_compute_instance.bastion-host.network_interface.0.nat_ip_address} ansible_ssh_user=mashkov

[webservers]
web1 ansible_host=${yandex_compute_instance.web-server1.network_interface.0.ip_address}
web2 ansible_host=${yandex_compute_instance.web-server2.network_interface.0.ip_address}

[prometheus]
prometheus ansible_host=${yandex_compute_instance.prometheus.network_interface.0.ip_address}

[grafana]
grafana ansible_host=${yandex_compute_instance.grafana.network_interface.0.ip_address}

[elasticsearch]
elasticsearch ansible_host=${yandex_compute_instance.elasticsearch.network_interface.0.ip_address}

[kibana]
kibana ansible_host=${yandex_compute_instance.kibana.network_interface.0.ip_address}

[webservers:vars]
ansible_ssh_user=mashkov
ansible_ssh_common_args='-o ProxyCommand="ssh -p 22 -W %h:%p -q -i /home/stanislav/.ssh/id_rsa mashkov@${yandex_compute_instance.bastion-host.network_interface.0.nat_ip_address}"'

[prometheus:vars]
ansible_ssh_user=mashkov
ansible_ssh_common_args='-o ProxyCommand="ssh -p 22 -W %h:%p -q -i /home/stanislav/.ssh/id_rsa mashkov@${yandex_compute_instance.bastion-host.network_interface.0.nat_ip_address}"'

[grafana:vars]
ansible_ssh_user=mashkov
ansible_ssh_common_args='-o ProxyCommand="ssh -p 22 -W %h:%p -q -i /home/stanislav/.ssh/id_rsa mashkov@${yandex_compute_instance.bastion-host.network_interface.0.nat_ip_address}"'

[elasticsearch:vars]
ansible_ssh_user=mashkov
ansible_ssh_common_args='-o ProxyCommand="ssh -p 22 -W %h:%p -q -i /home/stanislav/.ssh/id_rsa mashkov@${yandex_compute_instance.bastion-host.network_interface.0.nat_ip_address}"'

[kibana:vars]
ansible_ssh_user=mashkov
ansible_ssh_common_args='-o ProxyCommand="ssh -p 22 -W %h:%p -q -i /home/stanislav/.ssh/id_rsa mashkov@${yandex_compute_instance.bastion-host.network_interface.0.nat_ip_address}"'

OUTPUT
}

output "output-finish" {
  value = <<OUTPUT

## Website address ##
http://${yandex_alb_load_balancer.web-load-balancer.listener.*.endpoint.0.address.0.external_ipv4_address}/

## Grafana ##
http://${yandex_compute_instance.grafana.network_interface.0.nat_ip_address}:3000/login/


## Kibana ##
http://${yandex_compute_instance.kibana.network_interface.0.nat_ip_address}/app/home#/

OUTPUT
}