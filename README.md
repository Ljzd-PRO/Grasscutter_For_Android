# Ljzd's Grasscutter Installer For Android
Install Grasscutter on Android without ROOT  
在安卓上无ROOT安装Grasscutter

[🔗Grasscutter](https://github.com/Grasscutters/Grasscutter) ｜ [🔗mitmproxy](https://github.com/mitmproxy/mitmproxy) ｜ [🔗MongoDB](https://www.mongodb.com) ｜ [🔗Termux](https://github.com/termux/termux-app) ｜ [🔗Anlinux](https://github.com/EXALAB/Anlinux-Resources)

## Usage | 使用方法
* 1. Download the installer script.  
  下载安装脚本
```
curl https://raw.githubusercontent.com/Ljzd-PRO/Grasscutter_For_Android/main/grasscutter_installer.sh > grasscutter_installer.sh
```
* 2. Run the installer script.  
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
