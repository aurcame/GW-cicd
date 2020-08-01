#!/bin/sh
# copy Jenkins CLI
wget http://10.0.1.101:8080/jnlpJars/jenkins-cli.jar
# install neccessary plugins
java -jar jenkins-cli.jar -s http://10.0.1.101:8080/ --auth dell:159632 install-plugin parameterized-trigger \
        http://updates.jenkins-ci.org/latest/ansicolor.hpi \
        http://updates.jenkins-ci.org/latest/ansible.hpi \
        http://updates.jenkins-ci.org/latest/nexus-artifact-uploader.hpi \
        http://updates.jenkins-ci.org/latest/maven-plugin.hpi \
        http://updates.jenkins-ci.org/latest/job-dsl.hpi \
        http://updates.jenkins-ci.org/latest/locale.hpi \
        --restart
