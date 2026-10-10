# just_check_update
 packagekitを使って、定期的にアップデートチェックを行う。アップデートがあればダウンロードも行う。

## RPMパッケージの作成

RPMビルド環境に `rpm-build` と `systemd-rpm-macros` をインストールし、リポジトリのルートでソースアーカイブを作成してからビルドする。

```sh
version=0.1.0
mkdir -p "$HOME/rpmbuild/SOURCES" "$HOME/rpmbuild/SPECS"
git archive --format=tar.gz --prefix="just_check_update-${version}/" HEAD \
  > "$HOME/rpmbuild/SOURCES/just_check_update-${version}.tar.gz"
cp just_check_update.spec "$HOME/rpmbuild/SPECS/"
rpmbuild -ba "$HOME/rpmbuild/SPECS/just_check_update.spec"
```

作成した RPM をインストール後、定期実行を有効にする。

```sh
sudo dnf install "$HOME"/rpmbuild/RPMS/noarch/just_check_update-*.rpm
sudo systemctl enable --now just_check_update_pkcon.timer
```
