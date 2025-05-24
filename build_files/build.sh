#!/bin/bash

RELEASE="$(rpm -E %fedora)"
set -ouex pipefail

### Install Fonts

FONT_DIR="/usr/share/fonts/nerdfonts"
mkdir -p "$FONT_DIR"

install_nerd_font() {
    local font_name="$1"
    local font_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/${font_name}.zip"

    echo "Installing Nerd Font: $font_name"
    cd "$FONT_DIR"
    curl -fLo "${font_name}.zip" "$font_url"
    unzip -o "${font_name}.zip" -d "${font_name}"
    rm -f "${font_name}.zip"
}

# Install desired fonts
install_nerd_font "FiraCode"
install_nerd_font "FiraMono"

# Update font cache
fc-cache -fv

enable_copr() {
    repo="$1"
    repo_with_dash="${repo/\//-}"
    wget "https://copr.fedorainfracloud.org/coprs/${repo}/repo/fedora-${RELEASE}/${repo_with_dash}-fedora-${RELEASE}.repo" \
        -O "/etc/yum.repos.d/_copr_${repo_with_dash}.repo"
}

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

### Add NordVPN repo and install

rpm --import https://repo.nordvpn.com/gpg/nordvpn_public.asc

dnf5 config-manager addrepo --id="nordvpn" \
    --set=baseurl="https://repo.nordvpn.com/yum/nordvpn/centos/$(uname -m)" \
    --set=enabled=1 \
    --overwrite

dnf5 install -y --nogpgcheck nordvpn
systemctl enable nordvpnd
groupadd nordvpn
usermod -aG nordvpn $USER

# enable_copr some/coprrepo
enable_copr  bigjapka/VeraCrypt

# this installs a package from fedora repos
dnf5 install -y \
    tmux \
    kleopatra \
    gnome-disk-utility \
    kitty \
    zsh \
    gnome-calculator \
    powerline-fonts \
    veracrypt

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
systemctl disable NetworkManager-wait-online.service

### Cleaning
# Clean package manager cache
dnf5 clean all

# Clean temporary files
rm -rf /tmp/*

# Clean /var directory while preserving essential files
find /var/* -maxdepth 0 -type d \! -name cache -exec rm -fr {} \;
find /var/cache/* -maxdepth 0 -type d \! -name libdnf5 \! -name rpm-ostree -exec rm -fr {} \;

# Restore and setup directories
mkdir -p /var/tmp
chmod -R 1777 /var/tmp

# Commit and lint container
ostree container commit
bootc container lint
