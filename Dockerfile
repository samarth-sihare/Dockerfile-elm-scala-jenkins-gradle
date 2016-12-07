# jenkins 
# Java 8
# Scala 2.12
# elm 0.18
# gradle 3.2.1
# nodejs 7.2.0 and npm
#
# 
# MAINTAINER samarth-sihare
#
#
#



FROM jenkins

#Installing nodejs

USER root
ARG nodejs_version=v7.2.0/node-v7.2.0-linux-x64.tar.gz
RUN apt-get update -y && apt-get install --no-install-recommends -y -q curl python build-essential git ca-certificates
RUN mkdir /nodejs && curl http://nodejs.org/dist/${nodejs_version} | tar xvzf - -C /nodejs --strip-components=1
ENV PATH $PATH:/nodejs/bin


#Installing SCALA

ENV SCALA_VERSION 2.11.8
ENV SCALA_TARBALL http://www.scala-lang.org/files/archive/scala-$SCALA_VERSION.deb

RUN \
    echo "===> install from Typesafe repo (contains old versions but they have all dependencies we need later on)"  && \
    curl -sSL http://apt.typesafe.com/repo-deb-build-0002.deb  -o repo-deb.deb  && \
    dpkg -i repo-deb.deb  && \
    apt-get update        && \
    \
    \
    \
    echo "===> install Scala"  && \
    DEBIAN_FRONTEND=noninteractive \
        apt-get install -y --force-yes libjansi-java  && \
    curl -sSL $SCALA_TARBALL -o scala.deb             && \
    dpkg -i scala.deb                                 && \
    \
    \
    \
    echo "===> clean up..."  && \
    rm -f *.deb    && \
    apt-get clean  && \
    rm -rf /var/lib/apt/lists/*



#Installing ELM

ARG elm_version=0.18.0
RUN npm install -g elm@${elm_version} \
	&& npm install -g elm-test@${elm_version}


#Installing Gradle
ARG gradle_version=gradle-3.2.1
ARG gradle_dist=${gradle_version}-bin.zip
RUN mkdir /gradle && wget https://services.gradle.org/distributions/${gradle_dist} \
	&& unzip ${gradle_dist} -d /gradle
ENV PATH $PATH:/gradle/${gradle_version}/bin

USER jenkins

ENTRYPOINT ["/bin/tini", "--", "/usr/local/bin/jenkins.sh"]
