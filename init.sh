#!/bin/sh

dir=$(pwd)

echo "请输入 Aki-server 的绝对路径(不以‘/’结尾)："
read server_path

echo "链接存档和设置至 Aki-server"
mkdir -p $server_path/user
if [ -d "$server_path/user/launcher" ]; then
    rm -rf "$server_path/user/launcher"
fi
ln -s "$dir/根目录（存档及设置）/user/launcher" "$server_path/user/launcher"
if [ -d "$server_path/user/profiles" ]; then
    rm -rf "$server_path/user/profiles"
fi
ln -s "$dir/根目录（存档及设置）/user/profiles" "$server_path/user/profiles"
if [ -d "$server_path/user/sptSettings" ]; then
    rm -rf "$server_path/user/sptSettings"
fi
ln -s "$dir/根目录（存档及设置）/user/sptSettings" "$server_path/user/sptSettings"
echo "完毕"

echo "链接启动服务至 /etc/systemd/system/"
if [ -d "/etc/systemd/system/push-saves.timer" ]; then
    rm -rf "/etc/systemd/system/push-saves.timer"
fi
sudo ln -s "$dir/push-saves.timer" /etc/systemd/system/push-saves.timer
if [ -d "/etc/systemd/system/push-saves.service" ]; then
    rm -rf "/etc/systemd/system/push-saves.service"
fi
sudo ln -s "$dir/push-saves.service" /etc/systemd/system/push-saves.service
if [ -d "/etc/systemd/system/Aki-server.service" ]; then
    rm -rf "/etc/systemd/system/Aki-server.service"
fi
sudo ln -s "$dir/Aki-server.service" /etc/systemd/system/Aki-server.service
sudo systemctl daemon-reload
