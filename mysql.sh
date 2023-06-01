echo -e "\e[31m >>>>>>>>disable mysql>>>>>>>\e[0m"
dnf module disable mysql -y
echo -e "\e[31m >>>>>>>>repos file>>>>>>>\e[0m"

cp /root/Roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo
echo -e "\e[31m >>>>>>>>Start service>>>>>>>\e[0m"

systemctl enable mysqld
systemctl start mysqld
echo -e "\e[31m >>>>>>>>reset paswd>>>>>>>\e[0m"

mysql_secure_installation --set-root-pass RoboShop@1
mysql -uroot -pRoboShop@1
