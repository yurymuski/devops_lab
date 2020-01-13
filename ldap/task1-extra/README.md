This Ansible-playbook uses "expect" so python>=2.7 & pip, pexpect are required (Installing in [Vagrantfile](Vagrantfile)). 

"Vars_prompt" works only in interactive mode, so `ansible-playbook -vv ldap/provision.yml` should be used or defaults will be used.
(inventory is defined in /etc/ansible/hosts like "192.168.25.5 ansible_user=vagrant ansible_private_key_file="/home/yury/ldap/ldap-task1/.vagrant/machines/ldap/virtualbox/private_key"")  

### Roles:  
- [Ldap role](ldap/roles/ldap/) installs and configures ldap ([task file](ldap/roles/ldap/tasks/main.yml)), adds admin and custom users (ansible "expect" resourse is used to hide pass, [template is used for custom user](ldap/roles/ldap/templates/ldap-templ.ldif) )
- [phpadmin role](ldap/roles/phpadmin/) installs and configures ldap ([task file](ldap/roles/phpadmin/tasks/main.yml))
