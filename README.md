# re_linux_docker
基于ubuntu16:04的一个linux x64的逆向分析环境，在其中放入了比较常用的各种逆向工具，方便以后使用和快速拷贝

该docker镜像中集成以下工具：
- 在ubuntu16.04 x64系统中增加32位程序支持
- [peda](https://github.com/longld/peda)：gdb比较给力的插件
- [pwntools](https://github.com/Gallopsled/pwntools)：CTF漏洞利用必备工具
- [libheap](https://github.com/cloudburst/libheap)：可以快速查看堆分配情况
- [LibcSearcher](https://github.com/lieanu/LibcSearcher)：根据已知函数确定libc版本，并查找其他库函数的symbols地址
- [one_gadget](https://github.com/david942j/one_gadget)：快速getshell的一种方法
- gcc/g++(build-essential),python2/python3,ruby：常用的编程语言支持
- pip/pip3：更新到最新版本
- bpython：更好的以交互模式使用python
- [angr](https://github.com/angr)：自动化逆向破解工具
- ipuils-ping：ping命令支持
- git
- vim及其配置文件

## 使用方法
建议创建re_linux.sh文件，并写入一下内容：
```
#/usr/bin/env sh
docker run -it --rm \
-v $HOME:/root/share \
--name re_linux \
--cap-add=SYS_PTRACE \
--privileged \
dapang10ve/re_linux \
bash
```
每次可以执行这个脚本，来启动镜像。

### 参数说明
```
-v $HOME:/root/share    将当前用户主目录映射到docker镜像的/root/share/路径作为共享
--cap-add=SYS_PTRACE    允许gdb附加调试进程
--privileged            允许在docker容器内部关闭aslr等安全机制
```
