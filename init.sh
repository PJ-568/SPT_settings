#!/usr/bin/env bash

dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "请输入 Aki-server 的绝对路径(不以‘/’结尾)："
read server_path

echo "链接存档和设置至 Aki-server"
if [ ! -d "$server_path/user" ]; then
    mkdir -p $server_path/user
fi

# if [ -d "$server_path/user/launcher-bak" ]; then
#     rm -rf "$server_path/user/launcher-bak"
# fi
# if [ -d "$server_path/user/launcher" ]; then
#     mv "$server_path/user/launcher" "$server_path/user/launcher-bak"
# fi
# ln -s "$dir/根目录（存档及设置）/user/launcher" "$server_path/user/launcher"

if [ -d "$server_path/user/profiles-bak" ]; then
    rm -rf "$server_path/user/profiles-bak"
fi
if [ -d "$server_path/user/profiles" ]; then
    mv "$server_path/user/profiles" "$server_path/user/profiles-bak"
fi
ln -s "$dir/根目录（存档及设置）/user/profiles" "$server_path/user/profiles"
if [ -d "$server_path/user/sptSettings" ]; then
    mv "$server_path/user/sptSettings" "$server_path/user/sptSettings-bak"
fi
ln -s "$dir/根目录（存档及设置）/user/sptSettings" "$server_path/user/sptSettings"
echo "完毕"

echo "链接启动服务至 /etc/systemd/system/"
cat << EOF > "$dir/push-saves.timer"
[Unit]
Description=Run push-saves.service every 2 minutes
After=network.target
Before=Aki-server.service

[Timer]
OnUnitActiveSec=2min
Unit=push-saves.service

[Install]
WantedBy=timers.target
EOF
if [ -d "/etc/systemd/system/push-saves.timer" ]; then
    rm -rf "/etc/systemd/system/push-saves.timer"
fi
sudo ln -s "$dir/push-saves.timer" /etc/systemd/system/push-saves.timer

cat << EOF > "$dir/push-saves.service"
[Unit]
Description=push-saves

[Service]
WorkingDirectory=$dir
ExecStart=$dir/push-saves.sh
Restart=always
User=pj568
Group=pj568

[Install]
WantedBy=multi-user.target
EOF
if [ -d "/etc/systemd/system/push-saves.service" ]; then
    rm -rf "/etc/systemd/system/push-saves.service"
fi
sudo ln -s "$dir/push-saves.service" /etc/systemd/system/push-saves.service

cat << EOF > "$dir/Aki-server.service"
[Unit]
Description=Aki Server Service
Wants=push-saves.timer
After=push-saves.timer

[Service]
WorkingDirectory=$server_path
ExecStartPre=$dir/pull-saves.sh
ExecStart=$server_path/SPT.Server.exe
Restart=always
User=pj568
Group=pj568
ExecStopPost=$dir/push-saves.sh

[Install]
WantedBy=multi-user.target

[Unit]
PartOf=push-saves.timer
EOF
if [ -d "/etc/systemd/system/Aki-server.service" ]; then
    rm -rf "/etc/systemd/system/Aki-server.service"
fi
sudo ln -s "$dir/Aki-server.service" /etc/systemd/system/Aki-server.service

sudo systemctl daemon-reload
