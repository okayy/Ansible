1) Add host in hosts_list
[<host-name>]
<host-ip>

[<host-name>:vars]
ansible_connection=ssh 
ansible_ssh_user=root
ansible_ssh_pass=host-root-password

2) Add key in centos.pem

3) Run ansible-playbook add_users.yml

4) ansible-playbook standart_node.yml standart_node.yml Setting up ssh, nrpe, firewalld.
