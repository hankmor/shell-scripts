# 遍历目录下的所有txt文件，并备份
# 例如：a.txt 备份为 a.txt_20231125

#!/bin/bash
# author: hank
# version: v1.0
# date: 2023-11-25

dir=./data
# 定义一个变量，用来存储备份给文件增加的后缀
suffix=$(date +%Y%m%d)
# 查找/data目录下所有的txt文件
txtFiles=$(find ${dir} -type f -name "*.txt")
# 遍历文件，并备份
for f in ${txtFiles}
do
    echo "正在备份文件：${f}..."
    cp ${f} ${f}_${suffix}
done