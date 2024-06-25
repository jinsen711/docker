#!/bin/bash

# 创建存放 src 的文件夹
if [ -d src ]; then
    echo "src 文件夹已经存在，跳过创建。"
else
    mkdir src
fi

# 构建 docker 容器
if sudo docker images | grep -q "symbols"; then
    echo "symbols 镜像文件已经存在，跳过创建。"
else
    sudo docker build -t symbols .
fi

# 判断 jin/symbols 容器是否在运行，如果在运行，删除，重新运行
if sudo docker ps -a | grep -q "symbols";then
    sudo docker rm -f symbols > /dev/null
fi
# 运行
sudo docker compose up -d
echo "symbols 容器运行成功"