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

docker run -it --rm \
-v $HOME:/root/share \
--name re_linux"$name" \
--cap-add=SYS_PTRACE \
--privileged \
dapang10ve/re_linux"$arg" \
bash

