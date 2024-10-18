#!/bin/sh

dir=$(pwd)

echo "请输入Aki-server的绝对路径(不以‘/’结尾)："
read server_path
mkdir -p $server_path/user
ln -s "$dir/根目录（存档及设置）/user/launcher" "$server_path/user/launcher"
ln -s "$dir/根目录（存档及设置）/user/profiles" "$server_path/user/profiles"
ln -s "$dir/根目录（存档及设置）/user/sptSettings" "$server_path/user/sptSettings"
echo "完毕"
