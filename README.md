# Dockerfile elm scala jenkins gradle

## Command

`docker run --name BRE_jenkins -p 7080:8080 -p 50000:50000 -v /home/jenkins_home:/var/jenkins_home jenkins:latest`

Note: If you face access issues due to mounting volumes, try using root user

`docker run --name BRE_jenkins -u 0 -p 7080:8080 -p 50000:50000 -v /home/jenkins_home:/var/jenkins_home jenkins:latest'
