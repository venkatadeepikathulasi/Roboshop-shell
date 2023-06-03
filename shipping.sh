script = $(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
mysql_root_password = $1
if[-z "$mysql_root_password"];then
  echo Input roboshop password missing
  exit
  fi
  component = "shipping"
  schema_Setup=mysql
  func_java
