FROM ubuntu:16.04
  
RUN dpkg --add-architecture i386 \
  && apt-get update \
  && apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386 libc-dbg:i386 module-assistant gcc-multilib g++-multilib

RUN packs="vim build-essential python-dev libffi-dev git python-pip python3-pip gdb binutils xz-utils ruby libc6-dbg nasm lrzsz net-tools iputils-ping strace netcat" \
  && apt-get install -y $packs

RUN git clone https://github.com/pwndbg/pwndbg.git \
  && cd pwndbg \
  && ./setup.sh \
  && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/lieanu/LibcSearcher.git \
  && cd LibcSearcher \
  && python setup.py develop

RUN pip install --upgrade  pip
COPY ./src/pip /usr/bin/pip
RUN chmod +x /usr/bin/pip*

RUN git clone https://github.com/longld/peda.git ~/peda \
  && echo "#source ~/peda/peda.py" >> ~/.gdbinit \
  && pip install --upgrade pyelftools==0.24 \
  && pip install --upgrade capstone==3.0.5\
  && pip install --upgrade sortedcontainers==2.0.5\
  && pip install pwntools bpython angr \
  && gem install one_gadget

COPY ./src/vimrc /root/.vimrc
COPY ./src/heap.py /pwndbg/pwndbg/commands/heap.py

WORKDIR /root/
