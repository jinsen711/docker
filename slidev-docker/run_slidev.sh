#!/bin/bash

# 创建存放 markdown 的文件夹
if [ -d markdown ]; then
    echo "markdown 文件夹已经存在，跳过创建。"
else
    mkdir makrdown
fi

# 创建 Dockerfile 文件
if [ -f Dockerfile ]; then
    echo "Dockerfile 文件已经存在，跳过创建。"
else
    touch Dockerfile
    echo "FROM tangramor/slidev:latest" >> Dockerfile
fi

# 创建 docker-compose.yml 文件
if [[ -f docker-compose.yml ]]; then
    echo "docker-compose.yml 文件已经存在，跳过创建。"
else
    touch docker-compose.yml
    {
        echo "version: '3'"
        echo "services:"
        echo "  slidev:"
        echo "    container_name: slidev"
        echo "    image: myppt"
        echo "    volumes:"
        echo "      - ./markdown:/slidev"
        echo "    ports:"
        echo "      - 3030:3030"
        echo "    environment:"
        echo "      NPM_MIRROR: https://registry.npmmirror.com"
        echo "    restart: always"
    } >> docker-compose.yml
fi

# 构建 docker 容器
if sudo docker images | grep -q "myppt"; then
    echo "myppt 镜像文件已经存在，跳过创建。"
else
    sudo docker build -t myppt .
fi

# 运行 myppt 容器
sudo docker compose up -d



