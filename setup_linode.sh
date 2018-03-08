#!/bin/sh

echo "Starting Setup."
HOSTNAME="andromeda"
IPV4_ADDRESS=""
IPV6_ADDRESS=""
FQDN="site.com"
USERNAME=""
USERPASS=""

#.ssh public key
USERKEY=""


echo "***********************************************"
echo "Updating system"
apt-get update
apt-get -y upgrade
apt install -y vim


echo "***********************************************"
echo "Setting Hostname"
#Hostfile
hostnamectl set-hostname $HOSTNAME

>/etc/hosts
echo "127.0.0.1       localhost" >> /etc/hosts
echo "127.0.1.1       $HOSTNAME.$FQDN $HOSTNAME" >> /etc/hosts
echo "$IPV4_ADDRESS  $HOSTNAME.$FQDN $HOSTNAME" >> /etc/hosts
echo "$IPV6_ADDRESS  $HOSTNAME.$FQDN $HOSTNAME" >> /etc/hosts
echo " " >> /etc/hosts
echo "# The following lines are desirable for IPv6 capable hosts" >> /etc/hosts
echo "::1     localhost ip6-localhost ip6-loopback" >> /etc/hosts
echo "ff02::1 ip6-allnodes" >> /etc/hosts
echo "ff02::2 ip6-allrouters" >> /etc/hosts


echo "***********************************************"
echo "Setting Timezone"
#Set time zone
#dpkg-reconfigure tzdata Africa/Harare
timedatectl set-timezone Africa/Harare


echo "***********************************************"
echo "Creating User..."
# quietly add a user without password
adduser --quiet --disabled-password --shell /bin/bash --home /home/$USERNAME --gecos "User" $USERNAME
# set password
echo "$USERNAME:$USERPASS" | chpasswd


echo "***********************************************"
echo "Adding Key..."
mkdir /home/$USERNAME/.ssh
echo $USERKEY > /home/$USERNAME/.ssh/authorized_keys


echo "***********************************************"
echo "Giving Sudo..."
echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

echo "***********************************************"
echo "Disabling root SSH"
#This doesn't work at the moment. NOW it does, it was missing that s at the start.
sed -i 's/PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config

systemctl restart sshd

ufw allow ssh

ufw enable
echo "***********************************************"
echo "Setup Complete."
echo "***********************************************"