# just_check_update
 アップデートチェックをやるだけのコマンド。

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

2.cronに以下から必要なものを選んで記載するか、systemdに適宜設定する。<br>

dnfを使用する場合<br>
```
echo '
#起動直後にチェック。(dnfを使用。)
@reboot root /usr/local/sbin/check_update_dnf.sh

#3時間おきにチェック。(dnfを使用。)
00 0-23/3 * * * root /usr/local/sbin/check_update_dnf.sh
' > /etc/cron.d/just_check_update.cron
```

Packagekitを使用する場合<br>
```
echo '
#起動直後にチェック。(PackageKitを使用。)
@reboot root /usr/local/sbin/check_update_pkcon.sh

#3時間おきにチェック。(PackageKitを使用。)
00 0-23/3 * * * root /usr/local/sbin/check_update_pkcon.sh
' > /etc/cron.d/just_check_update.cron
```

systemdによる設定。<br>
```
cd src/systemd
ls -l `pwd`/just_check_update* /etc/systemd/system/just_check_update*
chmod 700 `pwd`/just_check_update*
ls -l `pwd`/just_check_update* /etc/systemd/system/just_check_update*
cp -f `pwd`/just_check_update* /etc/systemd/system/

ls -l `pwd`/just_check_update* /etc/systemd/system/just_check_update*
```

dnfを使用する場合<br>
```
systemctl enable just_check_update_dnf.timer
systemctl status just_check_update_dnf.timer
```

Packagekitを使用する場合。<br>
```
systemctl enable just_check_update_pkcon.timer
systemctl status just_check_update_pkcon.timer
```
