# <img src="system_files/usr/share/pixmaps/fp-logo.png" alt="Fp OS Logo" width="45" valign="middle"/> Fp OS

This is my personalized setup for **Fp OS**, a custom version of Bazzite (Fedora Kinoite + KDE Plasma + Nvidia). It's tailored specifically for **my own use** and this document is mostly a reminder for myself on how things work and how to manage it.

**⚠️ Disclaimer: This project is highly personalized for myself (Fptbb) own use and workflow. It includes specific configurations (like modified application providers with pre-set client IDs) and branding tailored to my preferences. It is published publicly primarily as a reference, for my own amusement, or for others to see an example of a custom `bootc` image. It is NOT recommended for direct installation or use by others unless you are comfortable with these personalizations or plan to fork and modify it extensively. You have been warned!**

[![Build Status](https://github.com/Fptbb/fp-os/actions/workflows/build.yml/badge.svg)](https://github.com/Fptbb/fp-os/actions/) [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/fp-os)](https://artifacthub.io/packages/container/fp-os/fp-os)

Website: [os.fpt.icu](https://os.fpt.icu)

---

## <picture><img src="https://fonts.gstatic.com/s/e/notoemoji/latest/1f4a1/webp/emoji_u1f4a1.webp" alt="💡" width="22" height="22"></picture> Core Idea

*   **Base:** `ghcr.io/ublue-os/bazzite-dx-nvidia-open:stable`. This gives me Fedora Kinoite (KDE Plasma) with all the Bazzite gaming goodies, Developer Experience (DX) tools, and Nvidia drivers pre-installed.
*   **Immutable:** Uses `bootc` and `ostree` for a stable, predictable, and robust system.
*   **My Customizations:** I've added personal branding, a few specific system tweaks, and my preferred default Flatpaks.
*   **Flatpak First:** Most apps I use are installed via Flatpak. The base image modifications are for things that can't be easily Flatpak'd or require system-level configurations.

## <picture><img src="https://fonts.gstatic.com/s/e/notoemoji/latest/1f9f0/webp/emoji_u1f9f0.webp" alt="🧰" width="22" height="22"></picture> What's Inside (My Custom Bits)

*   **Custom Branding:**
    *   **KDE "About System":** Shows "Fp OS - Bazzite Edition" with my logo ([`fp-logo.png`](system_files/usr/share/pixmaps/fp-logo.png)) and a link to [os.fpt.icu](https://os.fpt.icu) (defined in `system_files/etc/xdg/kcm-about-distrorc`).
    *   **Wallpapers:** Custom default desktop and lockscreen wallpapers located in `system_files/usr/share/backgrounds/fp-os/`.
    *   **MOTD:** The "Message of the Day" in the terminal is customized to "Fp OS Bazzite Edition" and includes a fun, foxy tip (`system_files/usr/share/ublue-os/motd/bazzite.md` and `system_files/usr/share/ublue-os/motd/tips/40-fptbb.md`).

*   **KDE Google Account Tweaks:**
    *   The `system_files/usr/share/accounts/providers/kde/google.provider` file is modified. This is to fix Google Drive Integration with KDE, primarily because Google's default setup can be problematic. This file includes specific OAuth client details.

*   **Default Flatpaks (installed by `build.sh` via `repo_files/flatpaks` in addition to Bazzite's defaults):**
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

## <picture><img src="https://fonts.gstatic.com/s/e/notoemoji/latest/23ea/webp/emoji_u23ea.webp" alt="⏪" width="22" height="22"></picture> How to Rebase to This

To switch an existing `bootc`-compatible system to this image (or to update it):
```bash
sudo bootc switch --ostree-remote=ghcr ghcr.io/fptbb/fp-os:latest
```
Then reboot. To check the status: `sudo bootc status`.
An ISO can also be built (see building section) which uses a kickstart (`iso.toml`) to automatically rebase to this image upon installation.

## <picture><img src="https://fonts.gstatic.com/s/e/notoemoji/latest/1f4c4/webp/emoji_u1f4c4.webp" alt="📄" width="22" height="22"></picture> License

This project is licensed under the Apache License 2.0. See the [LICENSE](LICENSE) file for details.
