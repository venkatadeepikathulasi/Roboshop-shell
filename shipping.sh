source common.sh
echo -e "\e[32m >>>>>>>>install maven>>>>>>>\e[0m"
yum install maven -y
echo -e "\e[32m >>>>>>>>adding roboshop>>>>>>>\e[0m"
useradd {app_user}
echo -e "\e[32m >>>>>>>>making directory>>>>>>>\e[0m"
rm -rf /app
mkdir /app
echo -e "\e[32m >>>>>>>>Download app content>>>>>>>\e[0m"
curl -L -o /tmpshi/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
echo -e "\e[32m >>>>>>>>unzip the file>>>>>>>\e[0m"
cd /app
unzip /tmp/shipping.zip

echo -e "\e[32m >>>>>>>>download maven dependcies>>>>>>>\e[0m"
mvn clean package
mv target/shipping-1.0.jar shipping.jar
echo -e "\e[32m >>>>>>>>install my sql>>>>>>>\e[0m"
yum install mysql -y
mysql -h mysql.devops1008.online -uroot -pRoboShop@1 < /app/schema/shipping.sql
echo -e "\e[32m >>>>>>>>setup the systemd service>>>>>>>\e[0m"
cp /root/Roboshop-shell/shipping.service /etc/systemd/system/shipping.service
echo -e "\e[32m >>>>>>>>start the service>>>>>>>\e[0m"

systemctl daemon-reload
systemctl enable shipping
systemctl start shipping