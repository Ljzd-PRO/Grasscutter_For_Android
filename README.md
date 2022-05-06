# Ljzd's Grasscutter Installer For Android
Install Grasscutter on Android without ROOT  
在安卓上无ROOT安装Grasscutter

[🔗Grasscutter](https://github.com/Grasscutters/Grasscutter) ｜ [🔗mitmproxy](https://github.com/mitmproxy/mitmproxy) ｜ [🔗MongoDB](https://www.mongodb.com) ｜ [🔗Termux](https://github.com/termux/termux-app) ｜ [🔗Anlinux](https://github.com/EXALAB/Anlinux-Resources)

## Usage | 使用方法
* 1. Install Termux App to your Android device.  
  安装 Termux App 到你的安卓设备.  
[**🔗Termux App**](https://github.com/termux/termux-app/releases)

* 2. Download the installer script.  
  下载安装脚本
```
curl https://raw.githubusercontent.com/Ljzd-PRO/Grasscutter_For_Android/main/grasscutter_installer.sh > grasscutter_installer.sh
```
* 3. Run the installer script.  
  运行安装脚本
```
bash grasscutter_installer.sh [OPTIONS 选项] [VALUES 值]
```
* * *
* The installer usage/help  
  脚本使用方法
  
**ENG**
```
USAGE:
    ./grasscutter_installer.sh [OPTIONS] [VALUES]

OPTIONS:
    -i  | --install [mitmproxy|mongodb|all]     Start to install Grasscutter with environment you choose (Default: all)
            mitmproxy                           Install mitmproxy with Python3 PyPi (mitmproxy redirects MiHoYo's URL to your server)
            mongodb                             Install MongoDB with CentOS 8 by AnLinux(https://github.com/EXALAB/AnLinux-App) (Grasscutter require MongoDB database)
            all                                 Install both mitmproxy and MongoDB
    -c  | --check [mitmproxy|mongodb|jdk|all]   Check if you have installed mitmproxy, MongoDB or JDK17 (Default: all)

    -j  | --jar-file <path>                     The Grasscutter core you want to install (Default: Download from GitHub latest release)
    -t  | --target <path>...                    Target path you want to install Grasscutter in

    -h  | --help                                Get usage | help
```
**CHS**
```
用法:
    ./grasscutter_installer.sh [选项] [值]

选项:
    -i  | --install [mitmproxy|mongodb|all]     开始安装 Grasscutter 以及你选择要安装的环境 (默认: all)
            mitmproxy                           使用 Python PyPi 安装 mitmproxy (mitmproxy 将会重定向米哈游的URL到你的 Grasscutter 服务器)
            mongodb                             通过 Anlinux 的 CentOS 8 来安装 MongoDB (https://github.com/EXALAB/AnLinux-App) (Grasscutter 需要连接到 MongoDB)
            all                                 安装 mitmproxy 和 MongoDB
    -c  | --check [mitmproxy|mongodb|jdk|all]   检查你是否安装了 mitmproxy、 MongoDB 或 JDK17 (默认: all)

    -j  | --jar-file <path>                     Grasscutter jar 核心 (默认: 下载GitHub最新release)
    -t  | --target <path>...                    Grasscutter 安装目录

    -h  | --help                                获取使用方法
```
## Commands the scriptd use ｜ 脚本所用命令
```
pkg install python3
curl https://bootstrap.pypa.io/get-pip.py > get-pip.py
python3 get-pip.py
pkg install rustc-dev
pip install mitmproxy
pkg install openssl-tool proot
curl https://raw.githubusercontent.com/EXALAB/Anlinux-Resources/master/Scripts/Installer/CentOS/centos.sh > centos_installer.sh
bash centos_installer.sh
bash ~/start-centos.sh curl https://raw.githubusercontent.com/Ljzd-PRO/Grasscutter_For_Android/main/CentOS/CentOS-Linux-BaseOS.repo -o /etc/yum.repos.d/CentOS-Linux-BaseOS.repo
bash ~/start-centos.sh curl https://raw.githubusercontent.com/Ljzd-PRO/Grasscutter_For_Android/main/CentOS/CentOS-Linux-AppStream.repo -o /etc/yum.repos.d/CentOS-Linux-AppStream.repo
bash ~/start-centos.sh curl https://repo.mongodb.org/yum/redhat/8/mongodb-org/5.0/aarch64/RPMS/mongodb-org-server-5.0.8-1.el8.aarch64.rpm > mongodb_installer.rpm
bash ~/start-centos.sh yum clean all && yum makecache
bash ~/start-centos.sh yum install mongodb_installer.rpm
pkg install openjdk-17
curl https://github.com/Grasscutters/Grasscutter/releases/download/v1.0.0/grasscutter.jar > ./grasscutter/grasscutter.jar
bash ~/start-centos.sh mongod --config /etc/mongod.conf
```
