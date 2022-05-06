#!/bin/bash

set -u

usage() {
    printf "\33[1mLjzd's Grasscutter Installer For Android 0.1.0\33[0m\n"
    cat 1>&2 <<EOF
A Grasscutter installer for Android(Termux)
Grasscutter - https://github.com/Grasscutters/Grasscutter

USAGE:
    ./$(basename  $0) [OPTIONS] [VALUES]

OPTIONS:
    -i  | --install [mitmproxy|mongodb|all]      Start to install Grasscutter with environment you choose (Default: all)
            mitmproxy                           Install mitmproxy with Python3 PyPi (mitmproxy redirects MiHoYo's URL to your server)
            mongodb                             Install MongoDB with CentOS 8 by AnLinux(https://github.com/EXALAB/AnLinux-App) (Grasscutter require MongoDB database)
            all                                 Install both mitmproxy and MongoDB
    -c  | --check [mitmproxy|mongodb|jdk|all]   Check if you have installed mitmproxy, MongoDB or JDK17 (Default: all)

    -j  | --jar-file <path>                     The Grasscutter core you want to install (Default: Download from GitHub latest release)
    -t  | --target <path>...                    Target path you want to install Grasscutter in

    -h  | --help                                Get usage | help
EOF
}

checkEnvironment() {
    local check_result_python3=0
    local check_result_pip=0
    local check_result_mitmproxy=0
    local check_result_mongodb=0
    local check_result_jdk=0
    local check_result_proot=0

    run_whereis() {
        if  [ "$(whereis $1)" = $1":" ]; then
            echo -e "  \033[33m[x]" $1 "is not installed\033[0m"
            return 1
        else
            echo -e "  \033[32m[v]" $1 "is installed\033[0m"
            return 0
        fi
    }

    run_pgrep() {
        if  [ "$(pgrep -f $1)" = "" ]; then
            echo -e "  \033[33m[x]" $1 "isn't running\033[0m"
            return 1
        else
            echo -e "  \033[32m[v]" $1 "is running\033[0m"
            return 0
        fi
    }

    check_mitmproxy() {
        if run_whereis "mitmproxy" ; then
            local check_result_mitmproxy=1
            local check_result_pip=1
            local check_result_python3=1
        else
            if  run_whereis "pip" -a run_whereis "pip3" ; then
                local check_result_pip=1
                local check_result_python3=1
            else
                if run_whereis "python3" ; then
                    local check_result_python3=1
                fi
            fi
        fi
    }

    check_mongodb() {
        if run_pgrep "mongod" ; then
            local check_result_mongodb=1
        else
            if run_whereis "mongod" ; then
                local check_result_mongodb=1
            else
                if run_whereis "proot" ; then
                    local check_result_proot=1
                fi
            fi
        fi
    }

    check_jdk() {
        if run_whereis "java" ; then
            local check_result_jdk=1
        fi
    }

    echo "> Checking your environment ..."

    case "$1" in
        mitmproxy)
            check_mitmproxy
            ;;
        mongodb)
            check_mongodb
            ;;
        jdk)
            check_jdk
            ;;
        all)
            check_mitmproxy
            check_mongodb
            check_jdk
            ;;
        *)
            echo -e "\033[31m> Invalid parameter!\033[0m" 1>&2
            exit 1
            ;;
    esac
}

install() {
    local check_result_python3
    local check_result_pip
    local check_result_mitmproxy
    local check_result_mongodb
    local check_result_jdk
    local check_result_proot

    local jar-file=""
    local target-path="./grasscutter"

    # Get values set for installation
    num=0
    for arg in $args; do

            let num++

            if "$arg" in "-j" "--jar-file"; then
                if [ ${#args[@]} != $num ] && [ ${args[num]:0:1} != "-" ]; then
                    local jar-file=${args[num]}
                fi
            else
                if "$arg" in "-t" "--target"; then
                    if [ ${#args[@]} != $num ] && [ ${args[num]:0:1} != "-" ]; then
                        local target-path=${args[num]}
                    fi
                fi
            fi

        done

    # Install mitmproxy
    if [ $1 = "mitmproxy" -o $1 = "all" ]; then
        checkEnvironment "mitmproxy"
        if [ $check_result_mitmproxy != 1 ]; then
            echo "> Installing mitmproxy ..."
            if [ $check_result_pip != 1 ]; then
                if [ $check_result_python3 != 1 ]; then
                    exec "pkg install python3"
                fi
                exec "curl https://bootstrap.pypa.io/get-pip.py > get-pip.py"
                exec "python3 get-pip.py"
                exec "rm get-pip.py"
            fi
            exec "pkg install rustc-dev"
            exec "pip install mitmproxy"
            echo -e "  \033[32m[v] mitmproxy successfully installed\033[0m"
        fi
    fi

    # Install MongoDB
    if [ $1 = "mongodb" -o $1 = "all" ]; then
        checkEnvironment "mongodb"
        if [ $check_result_mongodb != 1 ] && [ $1 = "mongodb" -o $1 = "all" ]; then
            echo "> Installing MongoDB ..."
            exec "pkg install openssl-tool"
            if [ $check_result_proot != 1 ]; then
                exec "pkg install proot"
            fi
            exec "curl https://raw.githubusercontent.com/EXALAB/Anlinux-Resources/master/Scripts/Installer/CentOS/centos.sh > centos_installer.sh"
            exec "bash centos_installer.sh"
            exec "rm centos_installer.sh"
            exec "bash ~/start-centos.sh curl https://raw.githubusercontent.com/Ljzd-PRO/Grasscutter_For_Android/main/CentOS/CentOS-Linux-BaseOS.repo -o /etc/yum.repos.d/CentOS-Linux-BaseOS.repo"
            exec "bash ~/start-centos.sh curl https://raw.githubusercontent.com/Ljzd-PRO/Grasscutter_For_Android/main/CentOS/CentOS-Linux-AppStream.repo -o /etc/yum.repos.d/CentOS-Linux-AppStream.repo"
            exec "bash ~/start-centos.sh curl https://repo.mongodb.org/yum/redhat/8/mongodb-org/5.0/aarch64/RPMS/mongodb-org-server-5.0.8-1.el8.aarch64.rpm > mongodb_installer.rpm"
            exec "bash ~/start-centos.sh yum clean all && yum makecache"
            exec "bash ~/start-centos.sh yum install mongodb_installer.rpm"
            echo -e "  \033[32m[v] MongoDB successfully installed\033[0m"
        fi
    fi

    # Install JDK17
    checkEnvironment "jdk"
    if [ $check_result_jdk != 1 ]; then
        echo "> Installing JDK17 ..."
        exec "pkg install openjdk-17"
        echo -e "  \033[32m[v] JDK17 successfully installed\033[0m"
    fi

    # Install Grasscutter
    if [ -z $jar-file ]; then
        release_url=$(curl -Ls -w %{url_effective} -o /dev/null https://github.com/Grasscutters/Grasscutter/releases/latest)
        split_url=(${release_url//// })
        latest_download="https://github.com/Grasscutters/Grasscutter/releases/download/${split_url[${#split_url[@]}-1]}/grasscutter.jar"
        if [ ${target-path} != "./grasscutter" ]; then
            if [ ${target-path: -1} = "/" ]; then
                exec "curl ${latest_download} > ${target-path}'grasscutter.jar'"
            else
                exec "curl ${latest_download} > ${target-path}'/grasscutter.jar'"
            fi
        fi
    else
        if [ ${target-path} != "./grasscutter" ]; then
            if [ -d ${target-path} ]; then
                exec "cp ${jar-file} ${target-path}"
            else
                exec "mkdir ${target-path}"
                exec "cp ${jar-file} ${target-path}"
            fi
        fi
    fi

    echo -e "  \033[32m[v] Grasscutter successfully downloaded\033[0m"
    echo -e "\033[32m> Finished!\033[0m"
}

if [ $# == 0 ]; then
    usage
    exit 0
fi

# Write args into array
num=0
for arg in "$@"; do

        case "$arg" in
            -h|--help|-help)
                usage
                exit 0
                ;;
            *)
                args[num]=$arg
                ;;
        esac

        let num++

    done

num=0
for arg in $args; do

        let num++

        case "$arg" in
            -c|--check)
                if [ $# == $num ] || [ ${args[num]:0:1} = "-" ]; then
                    arg_in="all"
                else
                    arg_in=${args[num]}
                fi
                checkEnvironment $arg_in
                exit 0
                ;;
            -i|--install)
                if [ $# == $num ] || [ ${args[num]:0:1} = "-" ]; then
                    arg_in="all"
                else
                    arg_in=${args[num]}
                fi
                install $arg_in
                ;;
            *)
                ;;
        esac

    done
