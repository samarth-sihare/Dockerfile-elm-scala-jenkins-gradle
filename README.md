# Dockerfile elm scala jenkins gradle

## Command to Build image
`docker build -t <newImageName> <dockerFileDirectory>`

`docker build -t myNewDockerImage .`

## Command to Run docker

`docker run --name <name> -p <host_port>:8080 -p 50000:50000 -v <host volume>:/var/jenkins_home <newImageName>`

Note: If you face access issues due to mounted volumes in running jenkins pipeline etc, try using root user

`docker run --name My_jenkins -u 0 -p 8080:8080 -p 50000:50000 -v /home/jenkins_home:/var/jenkins_home <newImageName>`
