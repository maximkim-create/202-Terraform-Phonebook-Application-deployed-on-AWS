#! /bin/bash
yum update -y
yum install python3 -y
pip3 install flask
pip3 install flask_mysql
yum install git -y
cd /home/ec2-user && git clone https://github.com/ofidan/tf_phonebook_app.git
sleep 1m
python3 /home/ec2-user/tf_phonebook_app/phonebook-app.py