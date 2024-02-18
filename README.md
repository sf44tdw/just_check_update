# just_check_update
 アップデートチェックをやるだけのコマンド。

# TODO(rootユーザで実施する。)

1.パスが通る場所にコピーする。<br>
```
cd src
ls -l `pwd`/check_update* /usr/local/sbin/*
chmod 700 `pwd`/check_update*
ls -l `pwd`/check_update* /usr/local/sbin/*
cp -f `pwd`/check_update* /usr/local/sbin/

ls -l /usr/local/sbin/*
```

2.rootのcronを開く。<br>
```
crontab -e
```

3.cronに以下記載する。<br>
```
#起動直後にチェック。
@reboot /usr/local/sbin/check_update_check_update_dnf.sh && /usr/local/sbin/check_update_check_update_pkcon.sh

#3時間おきにチェック。
00 0-23/3 * * * /usr/local/sbin/check_update_check_update_dnf.sh && /usr/local/sbin/check_update_check_update_pkcon.sh
```
4.rootのcronをセーブ
