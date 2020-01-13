Using base docker image ***centos:6.7***

1. With ```Dockerfiles```:
    - Create Docker Image of ```nginx``` ([web.Dockerfile](/web.Dockerfile))
    - Create Docker Image of ```Tomcat 7``` ([tomcat.Dockerfile](/tomcat.Dockerfile))
    - Create Docker Image (Data Volume) with [```hello world```](https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war) application for Tomcat ([application.Dockerfile](application.Dockerfile))
    - Run these Images: [curl](/curl.png),[curl -L](/curl2.png) so that http://localhost/sample shows ```hello world``` page
    - ```Nginx``` container forwards http requests to ```Tomcat``` container; Only ```nginx``` container exposes port (80)
2. With ```docker-compose```:
    - Create [docker-compose.yml](/docker-compose.yml) file to build containers from previos task
    - Run "environment" in daemon mode
3. All needed changes (additional configuration/installations) on "Host" must be added into [Vagrantfile](/Vagrantfile)
4. All needed resources (if they are) must be placed into ```/resources``` folder