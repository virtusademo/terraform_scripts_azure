#!/bin/bash
yum -y update
yum -y install git
yum install -y docker
service docker start
yum remove -y java-1.7.0-openjdk.x86_64
echo "
[gocd]
name     = GoCD YUM Repository
baseurl  = https://download.gocd.io
enabled  = 1
gpgcheck = 1
gpgkey   = https://download.gocd.io/GOCD-GPG-KEY.asc
" | sudo tee /etc/yum.repos.d/gocd.repo
yum install -y java-1.8.0-openjdk
sudo yum install -y go-server
sudo yum install -y git
sudo su
echo "export GO_SERVER_SYSTEM_PROPERTIES='-Dgo.plugin.upload.enabled=true'" >> /etc/default/go-server
git clone https://github.com/virtusademo/gocd_plugins.git
cp /gocd_plugins/gocd-docker-pipeline-plugin-1.0.0.jar /var/lib/go-server/plugins/external/
cp /gocd_plugins/script-executor-0.3.0.jar /var/lib/go-server/plugins/external/
sudo /etc/init.d/go-server restart
