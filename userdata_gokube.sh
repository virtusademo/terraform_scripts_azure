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
yum install -y go-agent
#/etc/init.d/go-agent start
sed -i -e 's/127.0.0.1/172.31.1.28/g' /etc/default/go-agent
cd /opt
sudo wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u111-b14/jdk-8u111-linux-x64.tar.gz"
sudo tar xzf jdk-8u111-linux-x64.tar.gz
sudo wget http://www-eu.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
sudo tar xvf apache-maven-3.3.9-bin.tar.gz
sudo su go
echo "export JAVA_HOME=/opt/jdk1.8.0_111 " >> /etc/profile
source /etc/profile
echo "export PATH=/opt/jdk1.8.0_111/bin:$PATH " >> /etc/profile
source /etc/profile
echo "export M2_HOME=/opt/apache-maven-3.3.9 " >> /etc/profile
source /etc/profile
echo "export PATH=$PATH:/opt/apache-maven-3.3.9/bin " >> /etc/profile
source /etc/profile
#sed -i -e 's/127.0.0.1/10.1.5.10/g' /etc/default/go-agent
sudo su
usermod -a -G docker ec2-user
usermod -a -G docker go
usermod -a -G wheel go
/etc/init.d/go-agent restart
sudo su -
#cd /home/ec2-user/kubeterra
cd /root
#echo "eport HOME=/root" >> /etc/profile
#source /etc/profile
#echo "displaying path" $HOME
wget https://github.com/kubernetes/kubernetes/releases/download/v1.4.6/kubernetes.tar.gz
tar -xvzf kubernetes.tar.gz
#export KUBERNETES_PROVIDER=aws
#export PATH=/kubernetes/platforms/linux/amd64:$PATH
sed -i -e 's/us-west-2a/ap-northeast-1a/g' /root/kubernetes/cluster/aws/config-default.sh
sed -i -e 's/NUM_NODES:-4/NUM_NODES:-1/g' /root/kubernetes/cluster/aws/config-default.sh
sed -i -e 's/NODE_SIZE="t2.micro"/NODE_SIZE="m3.medium"/g' /root/kubernetes/cluster/aws/config-default.sh
sed -i -e 's/MASTER_SIZE="m3.medium"/MASTER_SIZE="m3.medium"/g' /root/kubernetes/cluster/aws/config-default.sh
sed -i -e 's/${KUBE_AWS_INSTANCE_PREFIX:-kubernetes/${KUBE_AWS_INSTANCE_PREFIX:-kubernetes-DEMO/g' /root/kubernetes/cluster/aws/config-default.sh
sed -i -e 's/us-east-1/ap-northeast-1/g' /root/kubernetes/cluster/aws/config-default.sh
sed -i -e 's/KUBE_OS_DISTRIBUTION:-jessie/KUBE_OS_DISTRIBUTION:-wily/g' /root/kubernetes/cluster/aws/config-default.sh
sed -i -e 's/VPC_NAME:-kubernetes-vpc/VPC_NAME:-kubernetes-DEMO_VPC/g' /root/kubernetes/cluster/aws/config-default.sh
sed -i -e 's/KUBE_VPC_CIDR_BASE:-172.20/KUBE_VPC_CIDR_BASE:-172.17/g' /root/kubernetes/cluster/aws/util.sh
sed -i -e 's/SUBNET_CIDR=${VPC_CIDR_BASE}.0.0/SUBNET_CIDR=${VPC_CIDR_BASE}.1.0/g' /root/kubernetes/cluster/aws/util.sh
#sed -i -e 's/MASTER_SG_NAME="kubernetes-master-${CLUSTER_ID}"/MASTER_SG_NAME="NordeaPSP_SIT_SG01"/g' /root/kubernetes/cluster/aws/util.sh
#sed -i -e 's/NODE_SG_NAME="kubernetes-minion-${CLUSTER_ID}"/NODE_SG_NAME="NordeaPSP_SIT_SG02"/g' /root/kubernetes/cluster/aws/util.sh
#sleep 15m
#auto-scaling, cidr, existing key, yaml files --to be added
cd ~
mkdir .aws
echo "[default]
aws_access_key_id=**************
aws_secret_access_key=*************************
region=ap-northeast-1
output=json" >  ~/.aws/config

echo "export HOME=/root" >> /etc/profile
source /etc/profile
echo "displaying path" $HOME

source /etc/profile
echo "export KUBERNETES_PROVIDER=aws" >> /etc/profile
source /etc/profile
echo "export PATH=/root/kubernetes/platforms/linux/amd64:$PATH" >> /etc/profile
source /etc/profile
#export KUBERNETES_PROVIDER=aws
#export PATH=/kubernetes/platforms/linux/amd64:$PATH
usermod -aG root go
cd /root/kubernetes/cluster/
source /etc/profile
#cd /home/ec2-user/kubeterra/kubernetes/cluster/
./kube-up.sh >> kubeuplog.txt
chmod -R 777 ~/.kube
chmod -R 777 ~/.docker
sudo su go
source /etc/profile
/etc/init.d/go-agent restart
