script = $(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh



   func_print_head"install nginx"
yum install nginx -y &>>$log_file
 func_checking_sucess $?
    func_print_head"copy robosshop"

cp roboshop.conf /etc/nginx/default.d/roboshop.conf &>>$log_file
 func_checking_sucess $?

func_print_head "clean old app content"
rm -rf /usr/share/nginx/html/* &>>$log_file
 func_checking_sucess $?

func_print_head"downloading app content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>$log_file
 func_checking_sucess $?

func_print_head"extracting app content"
cd /usr/share/nginx/html &>>$log_file
unzip /tmp/frontend.zip &>>$log_file
 func_checking_sucess $?
#some file need to be created
func_print_head"start nginx"
systemctl enable nginx &>>$log_file
systemctl restart nginx
 func_checking_sucess $?
