sudo knife bootstrap 192.168.25.205 -N 'chef5' -x root -P vagrant -r 'role[exit_task]'  
  
![!](build.png)  
  
roles:
  
![!](roles.png)  
  
[kitchen verify](test/integration/default/serverspec/default_spec.rb)  
  
![!](test.png)  
