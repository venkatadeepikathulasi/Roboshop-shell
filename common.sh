app_user = roboshop
func_print_head()
{
  echo -e\e[32m>>>>>>>$*<<<<<<<<<<<\e[0m
}
func_checking_sucess
{
  if[$? -eq 0];then
      echo func_print_head SUCESS
      else
        echo func_print_head Fail
        echo"refer a log for more information"
        exit 1
}
func_schema_setup()
{
  if["$schema_setup"==mongo];then
   func_print_head"copy mongodb repo"
cp $script_path/mongo.repo /etc/yum.repos.d/mongo.repo
 func_checking_sucess $?
func_print_head"install mongodb client"
yum install mongodb-org-shell -y
 func_checking_sucess $?
func_print_head "load schema"
mongo --host mongodb.devops1008.online </app/schema/catalogue.js
 func_checking_sucess $?
fi
if"${schema_setup}" == mysql ]; then

 func_print_head "install my sql"
  yum install mysql -y
   func_checking_sucess $?
  mysql -h mysql.devops1008.online -uroot -p${mysql_root_password} < /app/schema/shipping.sql
   func_checking_sucess $?
  fi
}
func_app_prereq()
{
  func_print_head"adding roboshop"
    useradd {app_user} &>>/tmp/roboshop.log
     func_checking_sucess $?

  func_print_head"making directory"
    rm -rf /app
    mkdir /app
      func_checking_sucess $?
  func_print_head"Download app content"
    curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
      func_checking_sucess $?
   func_print_head "unzip the file"
    cd /app
    unzip /tmp/${component}.zip
      func_checking_sucess $?

}

func_systemd_Setup()
{
  func_print_head"setup the systemd service"
    cp $script_path/${component}.service /etc/systemd/system/${component}.service
      func_checking_sucess $?
   func_print_head"start the service"

    systemctl daemon-reload
    systemctl enable ${component}
    systemctl start ${component}
    systemctl restart ${component}
      func_checking_sucess $?
}




func_nodejs()
{
 func_print_head "configuration repos"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash
    func_checking_sucess $?
  func_print_head "install nodejs"
  yum install nodejs -y
    func_checking_sucess $?
  func_app_prereq
  func_print_head "install nodejs repos"
  npm install
    func_checking_sucess $?

  func_schema_setup
  func_systemd_Setup
}

func_java()
{
  func_print_head "install maven"
  yum install maven -y &>>/tmp/roboshop.log
  func_checking_sucess $?

 func_app_prereq
 func_print_head"download maven dependcies"
   mvn clean package
   func_checking_sucess $?
   mv target/${component}-1.0.jar ${component}.jar
   func_schema_setup

  func_systemd_Setup

}

