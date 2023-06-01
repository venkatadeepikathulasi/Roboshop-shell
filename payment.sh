script_path=$(dirname $0)
source ${script_path}/common.sh

echo -e "\e[31m >>>>>>>>install python>>>>>>>\e[0m"

yum install python36 gcc python3-devel -y
echo -e "\e[31m >>>>>>>>add user >>>>>>>\e[0m"

useradd {app_user}
echo -e "\e[31m >>>>>>>>,make directory>>>>>>>\e[0m"
rm-rf /app
mkdir /app
echo -e "\e[31m >>>>>>>>download app content>>>>>>>\e[0m"

curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
echo -e "\e[31m >>>>>>>>extract>>>>>>>\e[0m"

cd /app
unzip /tmp/payment.zip
echo -e "\e[31m >>>>>>>>install >>>>>>>\e[0m"

pip3.6 install -r requirements.txt
echo -e "\e[31m >>>>>>>>copy systemd>>>>>>>\e[0m"

cp $script_path/payment.service /etc/systemd/system/payment.service
echo -e "\e[31m >>>>>>>>start service>>>>>>>\e[0m"

systemctl enable payment
systemctl start payment