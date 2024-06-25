import argparse
import os

# 容器名
SYMBOLS_CONTAINER_NAME = "symbols"

if __name__ == "__main__":
    # 初始化
    parser = argparse.ArgumentParser();
    # 添加参数说明
    parser.add_argument('-n', '--notstripped', required=True, help='有符号文件');
    parser.add_argument('-s', '--stripped', required=True, help='无符号文件');
    args = parser.parse_args();
    
    # 调用容器进行符号提取
    os.system(f"sudo docker exec -i {SYMBOLS_CONTAINER_NAME} mips-linux-gnu-objcopy --only-keep-debug {args.notstripped} symbolfile")
    # 调用容器进行符号迁移
    os.system(f"sudo docker exec -i {SYMBOLS_CONTAINER_NAME} mips-linux-gnu-objcopy --add-gnu-debuglink=symbolfile {args.stripped}")
    
