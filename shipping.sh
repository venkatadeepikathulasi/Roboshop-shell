yum install maven -y
useradd roboshop
mkdir /app
curl -L -o /tmpshi/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
cd /app
unzip /tmp/shipping.zip
cd /app
mvn clean package
mv target/shipping-1.0.jar shipping.jar
systemctl daemon-reload
systemctl enable shipping
systemctl start shipping
yum install mysql -y
mysql -h mysql.devops1008.online -uroot -pRoboShop@1 < /app/schema/shipping.sql
systemctl restart shipping