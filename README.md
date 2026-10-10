# just_check_update
 packagekitを使って、定期的にアップデートチェックを行う。アップデートがあればダウンロードも行う。

# TODO(rootユーザで実施する。)

1.パスが通る場所にコピーする。<br>
```
cd src/script
ls -l `pwd`/check_update* /usr/local/sbin/*
chmod 700 `pwd`/check_update*
ls -l `pwd`/check_update* /usr/local/sbin/*
cp -f `pwd`/check_update* /usr/local/sbin/

ls -l /usr/local/sbin/*
```

2.起動タイミングをsystemdに適宜設定する。<br>

①.ServiceファイルとTimerファイルを配置する。
```
cd src/systemd
ls -l `pwd`/just_check_update* /etc/systemd/system/just_check_update*
chmod 700 `pwd`/just_check_update*
ls -l `pwd`/just_check_update* /etc/systemd/system/just_check_update*
cp -f `pwd`/just_check_update* /etc/systemd/system/

ls -l `pwd`/just_check_update* /etc/systemd/system/just_check_update*
```

②.Timerファイルを有効化する。<br>
```
systemctl enable just_check_update_pkcon.timer
systemctl status just_check_update_pkcon.timer
```
