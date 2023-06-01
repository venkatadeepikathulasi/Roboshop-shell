source common.sh
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
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app
echo -e "\e[36m>>>>>> unzip the file>>>>>>\e[0m"
unzip /tmp/cart.zip
echo -e "\e[33m>>>>>> install nodejs repos >>>>>>\e[0m"
npm install
echo -e "\e[34m>>>>>> copy cart systemd service file>>>>>>\e[0m"
cp /root/Roboshop-shell/cart.service /etc/systemd/system/cart.service
echo -e "\e[35m>>>>>> Start cart service>>>>>>\e[0m"
systemctl daemon-reload
systemctl enable cart
systemctl start cart
