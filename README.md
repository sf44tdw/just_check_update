# check_update_by_pkcon
 アップデートチェックをやるだけのコマンド。

# TODO(rootユーザで実施する。)

1.パスが通る場所にコピーする。<br>
```
cd src
ls -l `pwd`/check_update.sh /usr/local/sbin/check_update.sh
chmod 700 check_update.sh
ls -l `pwd`/check_update.sh /usr/local/sbin/check_update.sh
cp -f check_update.sh /usr/local/sbin/
ls -l /usr/local/sbin/check_update.sh
```

2.rootのcronを開く。<br>
```
crontab -e
```

3.cronに以下記載する。<br>
```
#起動直後にチェック。
@reboot /usr/local/sbin/check_update.sh

#3時間おきにチェック。
* */3 * * * /usr/local/sbin/check_update.sh
```
4.rootのcronをセーブ
