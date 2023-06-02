script = $(realname "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
mysql_root_password =$1

if[-z "$mysql_root_password"];then
  echo Input roboshop password missing
  exit
  fi
echo -e "\e[31m >>>>>>>>disable mysql>>>>>>>\e[0m"
dnf module disable mysql -y
echo -e "\e[31m >>>>>>>>repos file>>>>>>>\e[0m"

cp $script_path/mysql.repo /etc/yum.repos.d/mysql.repo
echo -e "\e[31m >>>>>>>>install service>>>>>>>\e[0m"

yum install mysql-community-server -y
echo -e "\e[31m >>>>>>>>Start service>>>>>>>\e[0m"

systemctl enable mysqld
systemctl start mysqld
echo -e "\e[31m >>>>>>>>reset paswd>>>>>>>\e[0m"

mysql_secure_installation --set-root-pass $mysql_root_password

