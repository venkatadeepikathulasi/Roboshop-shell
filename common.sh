app_user = roboshop
print_head()
{
  echo -e\e[32m>>>>>>>$*<<<<<<<<<<<\e[0m
}
schema_setup()
{
  if["$schema_setup"==mongo];then
   print_head"copy mongodb repo"
cp $script_path/mongo.repo /etc/yum.repos.d/mongo.repo
print_head"install mongodb client"
yum install mongodb-org-shell -y
print_head "load schema"
mongo --host mongodb.devops1008.online </app/schema/catalogue.js
fi
}



func_nodejs()
{
 print_head "configuration repos"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash
  print_head "install nodejs"
  yum install nodejs -y
  print_head "add application user"
  useradd roboshop
  print_head "making directory"
  # before creating the app directory some od content we have to remove
  rm-rf /app
  mkdir /app
  print_head "download app content"
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
  cd /app
 print_head "unzip the file"
  unzip /tmp/${component}.zip
  print_head "install nodejs repos"
  npm install
  print_head "copy cart systemd service file"
  cp $script_path/${component}.service /etc/systemd/system/{component}.service
  print_head "Start cart service"
  systemctl daemon-reload
  systemctl enable ${component}
  systemctl start ${component}

  schema_setup
}

