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

3.cronに以下から必要なものを選んで記載する。<br>
```
#起動直後にチェック。(dnfを使用。)
@reboot /usr/local/sbin/check_update_dnf.sh

#3時間おきにチェック。(dnfを使用。)
00 0-23/3 * * * /usr/local/sbin/check_update_dnf.sh

#起動直後にチェック。(PackageKitを使用。)
@reboot /usr/local/sbin/check_update_pkcon.sh

#3時間おきにチェック。(PackageKitを使用。)
00 0-23/3 * * * /usr/local/sbin/check_update_pkcon.sh
```
4.rootのcronをセーブ
