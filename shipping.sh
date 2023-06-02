script = $(realname "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
mysql_root_password = $1
if[-z "$mysql_root_password"];then
  echo Input roboshop password missing
  exit
  fi
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
mysql -h mysql.devops1008.online -uroot -p${mysql_root_password} < /app/schema/shipping.sql
echo -e "\e[32m >>>>>>>>setup the systemd service>>>>>>>\e[0m"
cp $script_path/shipping.service /etc/systemd/system/shipping.service
echo -e "\e[32m >>>>>>>>start the service>>>>>>>\e[0m"

systemctl daemon-reload
systemctl enable shipping
systemctl start shipping