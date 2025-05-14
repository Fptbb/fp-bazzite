# <img src="system_files/usr/share/pixmaps/fp-logo.png" alt="Fp OS Logo" width="45" valign="middle"/> Fp OS

This is my personalized setup for **Fp OS**, a custom version of Bazzite (Fedora Kinoite + KDE Plasma + Nvidia). It's tailored specifically for **my own use** and this document is mostly a reminder for myself on how things work and how to manage it.

[![Build Status](https://github.com/Fptbb/fp-os/actions/workflows/build.yml/badge.svg)](https://github.com/Fptbb/fp-os/actions/) [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/fp-os)](https://artifacthub.io/packages/container/fp-os/fp-os)

---

## <picture><img src="https://fonts.gstatic.com/s/e/notoemoji/latest/1f4a1/webp/emoji_u1f4a1.webp" alt="💡" width="22" height="22"></picture> Core Idea

*   **Base:** `ghcr.io/ublue-os/bazzite-nvidia-open:stable`. This gives me Fedora Kinoite (KDE Plasma) with all the Bazzite gaming goodies and Nvidia drivers pre-installed.
*   **Immutable:** Uses `bootc` and `ostree` for a stable system.
*   **My Customizations:** I've added some personal branding, a few specific system tweaks, and my preferred default Flatpaks.
*   **Flatpak First:** Most apps I use are installed via Flatpak. The base image modifications are for things that can't be easily Flatpak'd or system-level configs.

## <picture><img src="https://fonts.gstatic.com/s/e/notoemoji/latest/1f9f0/webp/emoji_u1f9f0.webp" alt="🧰" width="22" height="22"></picture> What's Inside (My Custom Bits)

*   **Custom Branding:**
    *   **KDE "About System":** Shows "Fp OS - Bazzite Edition" with my logo ([`fp-logo.png`](system_files/usr/share/pixmaps/fp-logo.png)) and a link to my site.
    *   **Wallpapers:** Custom default desktop and lockscreen wallpapers are in `system_files/usr/share/backgrounds/fp-os/`.

*   **KDE Google Account Tweaks:**
    *   The `system_files/usr/share/accounts/providers/kde/google.provider` file is modified. To fix Google Drive Integration with KDE because Google sucks.

*   **Default Flatpaks (installed by `build.sh`):**
    *   `com.bitwarden.desktop` (Bitwarden)
    *   `com.dec05eba.gpu_screen_recorder` (GPU Screen Recorder)
    *   `com.spotify.Client` (Spotify)
    *   `com.vysp3r.ProtonPlus` (ProtonPlus)
    *   `dev.vencord.Vesktop` (Vesktop for Discord)
    *   `io.missioncenter.MissionCenter` (Mission Center)
    *   `app.zen_browser.zen` (Zen Browser)
    *   `org.gimp.GIMP` (GIMP)
    *   `org.mozilla.Thunderbird` (Thunderbird)
    *   `org.telegram.desktop` (Telegram Desktop)
    *   `org.vinegarhq.Sober` (Sober)
    *   `org.vinegarhq.Vinegar` (Vinegar)
    *   `rest.insomnia.Insomnia` (Insomnia)
    *   Possibly Others not Documented.

## <picture><img src="https://fonts.gstatic.com/s/e/notoemoji/latest/23ea/webp/emoji_u23ea.webp" alt="⏪" width="22" height="22"></picture> How to Rebase to This

To switch from atomic system to this (or update it):
```bash
sudo bootc switch --ostree-remote=ghcr ghcr.io/fptbb/fp-os:latest
```
Then reboot. To check: `sudo bootc status`.

## <picture><img src="https://fonts.gstatic.com/s/e/notoemoji/latest/1f528/webp/emoji_u1f528.webp" alt="🔨" width="22" height="22"></picture> Building It (Reminders for Me)

The `Containerfile` defines the image, and `build.sh` (inside `build_files/`) handles RPMs, Flatpaks, and system file copying. The `Justfile` has handy shortcuts.
