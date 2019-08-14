
FROM ubuntu:16.04

RUN dpkg --add-architecture i386 \
  && apt-get update \
  && apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386 libc-dbg:i386 module-assistant gcc-multilib g++-multilib
                                                                                                                           
RUN packs="vim build-essential python-dev libffi-dev git python-pip python3-pip gdb binutils xz-utils ruby libc6-dbg nasm lrzsz net-tools iputils-ping strace netcat" \
  && apt-get install -y $packs \
  && rm -rf /var/lib/apt/lists/*
COPY ./src/.vimrc /root/

RUN pip install --upgrade  pip 
COPY ./src/pip /usr/bin/pip

RUN pip install pwntools bpython angr\
  && git clone https://github.com/longld/peda.git ~/peda \
  && echo "source ~/peda/peda.py" >> ~/.gdbinit \
  && pip3 install setuptools \
  && git clone https://github.com/cloudburst/libheap \
  && pip3 install ./libheap/ \
  && echo "python import sys" >> ~/.gdbinit \
  && echo "python sys.path.append('/usr/local/lib/python3.5/dist-packages/')" >> ~/.gdbinit \
  && echo "python from libheap import *" >> ~/.gdbinit \
  && pip install --upgrade pyelftools==0.24 \
  && gem install one_gadget

COPY ./src/libc.tar.gz /root
RUN tar zxf /root/libc.tar.gz -C ~/ \
  && cd ~/libc \
  && python setup.py develop \
  && rm -rf /root/libc.tar.gz /root/LibcSearcher.egg-info
WORKDIR /root/
