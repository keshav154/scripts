# Jenkins Installation Script for Centos 8
# authored by - Keshav Saxena

#!/bin/bash
echo "enabling Port for accessing jenkins server";
firewall-cmd --add-port=8080/tcp --permanent --zone=public;
firewall-cmd --reload;
echo "installing jenkins server";
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo;
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key;
sudo yum -y update;
sudo yum install -y jenkins java-1.8.0-openjdk-devel;
sudo systemctl daemon-reload;
systemctl start jenkins && systemctl enable jenkins;
echo "Open the Jenkins url as https://'$echo$(hostname -I):8080'";
echo "Initial admin password for jenkins is ";
sudo cat /var/lib/jenkins/secrets/initialAdminPassword;
echo "Use above secret while initializing Jenkins in Browser";
