echo -e "\e[31m >>>>>>>>configuration repos>>>>>>>\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[32m>>>>>>>> install nodejs>>>>>>>>>\e[0m"
yum install nodejs -y
echo -e "\e[33m>>>>>>>>add application user >>>>>>>\e[0m"
useradd roboshop
echo -e "\e[34m>>>>>> making directory>>>>>>\e[0m"
# before creating the app directory some od content we have to remove
rm-rf /app
mkdir /app
echo -e "\e[35m>>>>>> download app content>>>>>>\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
echo -e "\e[36m>>>>>> unzip the file>>>>>>\e[0m"
unzip /tmp/catalogue.zip
echo -e "\e[33m>>>>>> install nodejs repos >>>>>>\e[0m"
npm install
echo -e "\e[34m>>>>>> copy catalogue systemd service file>>>>>>\e[0m"
cp /root/Roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service
echo -e "\e[35m>>>>>> Start catalogue service>>>>>>\e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue
echo -e "\e[36m>>>>>copy mongodb repo>>>>>>>\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[31m>>>>install mongodb client>>>>>>\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[34m>>>>>> load schema>>>>>>\e[0m"
mongo --host mongodb.devops1008.online </app/schema/catalogue.js