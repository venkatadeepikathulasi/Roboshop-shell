script_path=$(dirname $0)
source ${script_path}/common.sh
echo -e "\e[32m ...setup...\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[32m ...install nodejs...\e[0m"
yum install nodejs -y
echo -e "\e[32m ...roboshop add...\e[0m"
useradd roboshop
echo -e "\e[32m ...make direcory...\e[0m"
rm-rf /app
mkdir /app
echo -e "\e[32m ...creating file...\e[0m"

curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
echo -e "\e[32m ...change directory...\e[0m"

cd /app
echo -e "\e[32m ...unzip...\e[0m"
unzip /tmp/user.zip
echo -e "\e[32m ...install npm..\e[0m"
npm install

cp $script_path/user.service /etc/systemd/system/user.service
systemctl daemon-reload
systemctl enable user
systemctl start user
cp $script_path/mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org-shell -y
mongo --host mongodb.devops1008.online </app/schema/user.js