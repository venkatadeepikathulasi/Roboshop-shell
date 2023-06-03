script = $(realname "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
rabbitmq_appuser_password = $1

if[-z "$rabbitmq_appuser_password"];then
  echo Input roboshop password missing
  exit
  fi

component = python
func_python