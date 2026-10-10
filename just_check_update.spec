Name:           just_check_update
Version:        0.1.0
Release:        1%{?dist}
Summary:        Periodically check for PackageKit updates
License:        GPL-3.0-only
URL:            https://github.com/sf44tdw/just_check_update
Source0:        %{name}-%{version}.tar.gz
BuildArch:      noarch

BuildRequires:  systemd-rpm-macros
Requires:       bash
Requires:       coreutils
Requires:       findutils
Requires:       PackageKit
Requires:       procps-ng
Requires:       systemd
Requires:       util-linux

%description
Runs a periodic PackageKit update check using pkcon and logs the results.

%prep
%autosetup -n %{name}-%{version}

%build

%install
install -Dpm 0755 src/script/check_update_pkcon.sh \
    %{buildroot}%{_sbindir}/check_update_pkcon.sh
install -Dpm 0755 src/script/check_update_backend \
    %{buildroot}%{_sbindir}/check_update_backend
install -Dpm 0644 src/systemd/just_check_update_pkcon.service \
    %{buildroot}%{_unitdir}/just_check_update_pkcon.service
install -Dpm 0644 src/systemd/just_check_update_pkcon.timer \
    %{buildroot}%{_unitdir}/just_check_update_pkcon.timer

%post
%systemd_post just_check_update_pkcon.service just_check_update_pkcon.timer

%preun
%systemd_preun just_check_update_pkcon.service just_check_update_pkcon.timer

%postun
%systemd_postun just_check_update_pkcon.service just_check_update_pkcon.timer

%files
%license LICENSE
%{_sbindir}/check_update_pkcon.sh
%{_sbindir}/check_update_backend
%{_unitdir}/just_check_update_pkcon.service
%{_unitdir}/just_check_update_pkcon.timer
