#/usr/bin/env sh

if [ -z "$1" ]
then 
  echo "arg is emtry"
  arg=
  name=
else
  arg=":$1"
  name=`echo $1|sed 's/\.//g'`
fi

#echo $arg
#echo $name

docker ps|grep re_linux"$name"

if [ $? -eq 0 ];then	#$?=0说明上个命令执行成功
  docker exec -it re_linux"$name" bash
else
  #echo "first"
  docker run -it --rm \
  -v $HOME:/root/share \
  --name re_linux"$name" \
  --cap-add=SYS_PTRACE \
  --privileged \
  dapang10ve/re_linux"$arg" \
  bash
fi
