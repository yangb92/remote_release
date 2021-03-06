#!/usr/bin/env bash

# Tip： MS_Windows系统请使用 Git bash 运行此脚本。

#################功能描述#########################
<<!
# [1] 备份远程Tomcat webapps目录到 /home 目录下
# [2] 关闭远程Tomcat服务
# [3] 清空远程Tomcat webapps目录
# [4] 发送一个应用文件文件到远程 webapps 目录中
# [5] 发送一个文件夹下的文件到远程 webapps/ROOT 目录中
# [6] 启动远程Tomcat
# [7] 免除重复认证.(命令执行过程中需要重复输入密码，可使用此选项，输入一次即可)
# [0] 退出
!

#################环境配置##########################

# 服务器地址
host="192.168.1.165"
# 用户名
user="root"
# 远程服务器Tomcat目录
REMOTE_TOMCAT_DIR="/data/ysoffice/t3" # 8100
# 远程服务器java目录(一般情况不用改)
REMOTE_JAVA_HOME="/usr"

# 需要传输的文件路径
app_file="C:/Users/DELL/Documents/APL_PROJECT/YS-OFFICE/ys-web/target/ys-web.war"
# 需要传输的目录路径
app_dir="C:/Users/DELL/Documents/APL_PROJECT/ys-info/src/main/dist"

###################################################

tip=" - Press any key to continue"

while [ 1 ]

do
clear
echo -e "
______ _   _ _____  _   __  _____ ________  ________   ___ _____
|  ___| | | /  __ \| | / / |_   _|  _  |  \/  /  __ \ / _ \_   _|
| |_  | | | | /  \/| |/ /    | | | | | | .  . | /  \// /_\ \| |
|  _| | | | | |    |    \    | | | | | | |\/| | |    |  _  || |
| |   | |_| | \__/\| |\  \   | | \ \_/ / |  | | \__/\| | | || |
\_|    \___/ \____/\_| \_/   \_/  \___/\_|  |_/\____/\_| |_/\_/

     \033[33m ======= Remote tomcat deploy shell! @yangb ======= \033[0m    "
echo
echo -e "主机: \033[32m${host}\033[0m | 用户: \033[32m${user}\033[0m "
echo -e "文件路径: \033[32m${app_file}\033[0m"
echo -e "目录路径: \033[32m${app_dir}\033[0m"
echo -e "远程Jdk或Jre目录: \033[32m${REMOTE_JAVA_HOME}\033[0m"
echo -e "远程Tomcat目录: \033[32m${REMOTE_TOMCAT_DIR}\033[0m"
echo
echo -e "\033[36mOptions:\033[0m"
echo
echo "[1] 备份远程 webapps目录到 /home 目录下" # Backup webapps to /home directory in the remote server
echo "[2] 关闭远程tomcat" # Shutdown the remote tomcat
echo "[3] 清空远程webapps目录" # Clear the webapps directory on remote tomcat
echo "[4] 发送一个应用文件文件到远程 webapps 目录中" #  Send a app file to webapps/ on the remote tomcat
echo "[5] 发送一个文件目录下的内容到远程 webapps/ROOT 目录中" # Send files for the folder on the remote webapps/ROOT
echo "[6] 启动远程Tomcat" # Start the remote tomcat
echo "[7] 免除重复认证" # Avoid repeat certification
echo
echo  -e "\033[31m[0] 退出 \033[0m" # EXIT
echo
read -p "Please input your command:  " command

case ${command} in
    0) break
    ;;
    1)
        ssh ${user}@${host} "tar -zcvf /home/$(date +%Y%m%d)_webapps_bak.tar.gz ${REMOTE_TOMCAT_DIR}/webapps/*"
        read -n1 -p "[-] SUCCESS ${tip}"
    ;;
    2)
        ssh ${user}@${host} "export JAVA_HOME=${REMOTE_JAVA_HOME} && ${REMOTE_TOMCAT_DIR}/bin/shutdown.sh"
        read -n1 -p "[-] SUCCESS ${tip}"
    ;;
    3)
        ssh ${user}@${host} "rm -rf ${REMOTE_TOMCAT_DIR}/webapps/*"
        read -n1 -p "[-] SUCCESS ${tip}"
    ;;
    4)
        scp ${app_file} ${user}@${host}:${REMOTE_TOMCAT_DIR}/webapps/
        read -n1 -p "[-] SUCCESS ${tip}"
    ;;
    5)
        scp -r ${app_dir}  ${user}@${host}:${REMOTE_TOMCAT_DIR}/webapps/ROOT/
        read -n1 -p "[-] SUCCESS ${tip}"
    ;;
    6)
        ssh ${user}@${host} "export JAVA_HOME=${REMOTE_JAVA_HOME} && ${REMOTE_TOMCAT_DIR}/bin/startup.sh"
        read -n1 -p "[-] SUCCESS ${tip}"
    ;;
    7)
        ssh-copy-id ${user}@${host}
        read -n1 -p "[-] SUCCESS ${tip}"
    ;;
    *)
        read -n1 -p "Command invalid ${tip}"
    ;;
esac

done

<<!
 **********************************************************
 * Author        : yangb
 * Email         : yangb92@outlook.com
 * Last modified : 2019-5-7
 * Filename      : z-deploytool
 * Description   : Remote tomcat deploy shell!
 * *******************************************************
!
