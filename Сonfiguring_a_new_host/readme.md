Новая нода в московском датацентре:

1) Добавляем новый хост по шаблону в inventory фаил between_host_second_dc 

[<host-name>]
<host-ip>

[<host-name>:vars]
ansible_connection=ssh 
ansible_ssh_user=root
ansible_ssh_pass=<host-root-password>

2) add_users.yml Создание стандартного набора пользователей Between и их конфигурации.

  Запускаем ansible-playbook add_users.yml

3) standart_node.yml Начальная конфигурация хоста, на данный момент только ssh и nrpe.

  Запускаем ansible-playbook standart_node.yml
 

 
 
Добавление нового пользователя на текущие хосты:
 
1) фаил <USERNAME>.pub ключом пользователя кладем в корень каталога и в vars раздел playbook'а add_users.yml добавляем 

    ssh_pubkey_<USERNAME>: "{{ lookup('file', './<USERNAME>.pub') }}"

2) в tasks раздел добавляем блок по шаблону

    - name: Add the user '<USERNAME>' with a specific uid
      user:
        name: <USERNAME>
        group: thumbtack

    - name: Add new SSH Public Key for <USERNAME>
      authorized_key: user=<USERNAME> key="{{ssh_pubkey_<USERNAME>}}" state=present
      register: add_key_result
      ignore_errors: True
      
3) запускаем ansible-playbook add_users.yml