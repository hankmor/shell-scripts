#!/bin/bash
# author: hank
# version: 0.1
# date:
#
# 要求：
# 写一个脚本，检测本机所有磁盘分区是否正常
# 思路：遍历所有挂载点，新建一个测试文件然后删除之，都正常说明分区正常。

# 查找本地磁盘挂载点
# 1、首先，使用 df 命令查看系统磁盘，最终需要获取 Mounted on 字段
# 2、使用 sed 工具删除第一行，它是标头信息
# 3、使用 grep 过滤并排除 tmpfs 的挂载，这里的 -v 参数用于筛选不匹配的行，它是虚拟内存文件系统，不是真正的磁盘块
# 4、最后，用 awk 工具筛选出最后一列，其中的 $NF 表示记录的字段数，也就是获取记录的最后一个字段
mnts=$(df | sed '1d' | grep -v 'tmpfs' | awk '{print $NF}')
for mnt_p in ${mnts}; do
    # 创建文件并删除，都成功则会返回 0
    touch $mnt_p/test_file && rm -f $mnt_p/test_file
    # $? 表示上一个命令的退出状态等，如果为 0 则说明前边两条命了都执行成功，注意 [] 左右的空格不能少
    if [ $? -ne 0 ]; then
        echo '$mnt_p读写失败'
    else
        echo '$mnt_p读写正常'
    fi
done
