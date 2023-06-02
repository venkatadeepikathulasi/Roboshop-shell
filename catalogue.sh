script = $(realname "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
component = catalogue
fun_nodejs

echo -e "\e[36m>>>>>copy mongodb repo>>>>>>>\e[0m"
cp $script_path/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[31m>>>>install mongodb client>>>>>>\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[34m>>>>>> load schema>>>>>>\e[0m"
mongo --host mongodb.devops1008.online </app/schema/catalogue.js