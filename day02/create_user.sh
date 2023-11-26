#!/bin/bash
# author: hank
# version: 0.1
# date:

# 题目：随机生成10个用户，用户名为 user_00 到 user_04，随机生成密码并存储到 userpwd.txt 文件中，密码随机
# 系统为 ubuntu
# 
# 思路：
# 1、要生成 user_00 到 user_04，需要用到 seq 命令来生成序列，具体用法如下：
# seq [OPTIONS] FIRST INCREMENT LAST
# 如果 FIRST、INCREMENT 为指定，默认为1，即：生成默认从1开始每次增加1的序列。具体查看 seq --help
# 2、如果要生成随机密码，需要用到 mkpasswd 工，它在工具包 whois 中，安装：
# apt-get install whois -y
# 使用：mkpasswd [OPTIONS]... [PASSWORD [SALT]]
# mkpasswd -S ab生成ab打头的13位随机密码
# mkpasswd -S cd生成cd打头的13位随机密码
# mkpasswd -S xy生成xy打头的13位随机密码
# 

pwdFile="./userpwd.txt"

# 先查看 userpwd.txt 文件是否存在，存在则删除
if [ -f ${pwdFile} ]; then
    rm -f ${pwdFile}
fi

# 创建随机密码需要使用 mkpasswd 工具，判断是否存在，不存在则安装
if ! which mkpasswd; then
    echo "installing mkpasswd..."
    apt-get install whois -y
fi

# 生成 00 到 04 的序列，-w 参数让生成的序列数字等宽
q=`seq -w 0 04`
for n in ${q}; do
    # 生成随机密码
    pwd=`mkpasswd 0`
    # 添加用户并设置密码
    useradd user_${n} && echo "${pwd}" | passwd --stdin user_${n}
    # 输出用户名密码到文件中
    echo "user_${n} ${pwd}" >> ${pwdFile}
done