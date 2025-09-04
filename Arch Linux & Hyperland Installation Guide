# Arch Linux & Hyperland Installation Guide

This comprehensive guide will walk you through installing Arch Linux from scratch and setting up the Hyperland window manager, using real installation commands and customization tips.  
Each step comes with clear explanations, Arabic comments in code blocks, and curated video links for deeper understanding.

---

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Arch Linux Installation](#arch-linux-installation)
    1. [Boot & Keyboard Setup](#boot--keyboard-setup)
    2. [Connect to WiFi](#connect-to-wifi)
    3. [Disk Partitioning](#disk-partitioning)
    4. [Format Partitions](#format-partitions)
    5. [Mount Partitions](#mount-partitions)
    6. [Install Base System](#install-base-system)
    7. [Fstab & Chroot](#fstab--chroot)
    8. [Regional Settings](#regional-settings)
    9. [User Setup](#user-setup)
    10. [Sudo & NetworkManager](#sudo--networkmanager)
    11. [GRUB Bootloader](#grub-bootloader)
    12. [Reboot & Initial Checks](#reboot--initial-checks)
    13. [Mirror Optimization](#mirror-optimization)
    14. [Kernel & Headers Management (Recommended)](#kernel--headers-management-recommended)
    15. [Disabling KDE Wallet (If Needed)](#disabling-kde-wallet-if-needed)
3. [Hyperland Installation & Configuration (Updated)](#hyperland-installation--configuration-updated)
    1. [Install Hyperland and Dependencies](#install-hyperland-and-dependencies)
    2. [Optional: Install AUR Helper and Apps](#optional-install-aur-helper-and-apps)
    3. [Customize Hyperland](#customize-hyperland)
    4. [Network DNS Configuration](#network-dns-configuration)
    5. [Fonts Setup](#fonts-setup)
    6. [QT Themes & Customization](#qt-themes--customization)
    7. [Enable Multilib (Optional)](#enable-multilib-optional)
    8. [Recommended Apps & Utilities](#recommended-apps--utilities)
4. [Useful Video Resources](#useful-video-resources)
5. [Tips & Troubleshooting](#tips--troubleshooting)

---

## 1. Prerequisites

- **A USB drive with Arch Linux ISO**
- **Internet connection**
- **Basic Linux command-line knowledge**

> **Tip:** Watch these videos for an overview of the Arch installation process:  
> [Arch installation video #1](https://youtu.be/Q6jAtnqfWtI?si=n4a4qhFr8uJSZu9L)  
> [Arch installation video #2](https://youtu.be/68z11VAYMS8?si=tpF2ZmSG2ZWUbB1Z)

---

## 2. Arch Linux Installation

### 2.1 Boot & Keyboard Setup

1. **Choose your keyboard layout:**
    ```bash
    loadkeys us       # تعيين تخطيط لوحة المفاتيح إلى الإنجليزية (US)
    ```

---

### 2.2 Connect to WiFi

2. **Start WiFi management tool:**
    ```bash
    iwctl             # الدخول إلى أداة إعداد الواي فاي
    ```
3. **List devices and connect:**
    ```bash
    device list                       # عرض أجهزة الشبكة المتوفرة
    station wlan1 scan                # البحث عن شبكات الواي فاي
    station wlan1 get-networks        # عرض قائمة الشبكات
    station wlan1 connect "اسم الواي فاي"  # الاتصال بالشبكة المطلوبة
    exit                              # الخروج من iwctl
    ```
4. **Test connection:**
    ```bash
    ping archlinux.org                # اختبار الاتصال بالإنترنت
    ```

> **Tip:** If you have issues, use `nmtui` after installation for network setup.

---

### 2.3 Disk Partitioning

5. **List disks and wipe old filesystems:**
    ```bash
    fdisk -l                          # عرض الأقراص المتصلة
    wipefs -a /dev/sda                # مسح جميع معلومات النظام السابقة من القرص (احذر!)
    ```
6. **Partition the disk:**
    ```bash
    cfdisk /dev/sda                   # أداة تقسيم القرص سهلة الاستخدام
    ```
    - Create partitions for EFI (e.g. `/dev/sda1`), Swap (`/dev/sda2`), and Root (`/dev/sda3`).
    - >Write>Yes>Quit

> **Note:** Use GPT partition table for UEFI systems.

---

### 2.4 Format Partitions

7. **Format each partition:**
    ```bash
    # قسم EFI
    sudo mkfs.fat -F32 /dev/sda1       # تهيئة قسم EFI بنظام FAT32

    # قسم Swap
    sudo mkswap /dev/sda2              # تهيئة قسم Swap
    sudo swapon /dev/sda2              # تفعيل Swap الآن

    # القسم الرئيسي (Root)
    sudo mkfs.ext4 /dev/sda3           # تهيئة القسم الرئيسي بنظام ext4
    ```

---

### 2.5 Mount Partitions

8. **Mount root and EFI:**
    ```bash
    sudo mount /dev/sda3 /mnt              # تركيب القسم الرئيسي
    sudo mkdir -p /mnt/boot/efi            # إنشاء مجلد EFI
    sudo mount /dev/sda1 /mnt/boot/efi     # تركيب قسم EFI
    ```

9. **Verify mounts:**
    ```bash
    lsblk                                   # التحقق من الأقسام المركبة
    ```

---

### 2.6 Install Base System

10. **Install essential packages:**
    ```bash
    pacstrap -K /mnt base base-devel linux linux-firmware sof-firmware nano sudo networkmanager grub efibootmgr intel-ucode
    # تثبيت حزم النظام الأساسية والأدوات المهمة
    ```

---

### 2.7 Fstab & Chroot

11. **Generate fstab and chroot:**
    ```bash
    genfstab -U /mnt > /mnt/etc/fstab       # إنشاء ملف fstab تلقائياً
    arch-chroot /mnt                        # الدخول إلى النظام المثبت حديثاً
    ```

---

### 2.8 Regional Settings

12. **Set timezone:**
    ```bash
    ln -sf /usr/share/zoneinfo/Africa/Casablanca /etc/localtime   # تعيين المنطقة الزمنية
    date                                                         # التحقق من الوقت
    hwclock --systohc                                            # مزامنة ساعة النظام
    ```

13. **Locale configuration:**
    - Edit `/etc/locale.gen` to enable English and/or Arabic (Morocco):
        ```bash
        nano /etc/locale.gen         # فتح الملف
        # احذف علامة # أمام:
        en_US.UTF-8 UTF-8
        ar_MA.UTF-8 UTF-8
        Ctrl+O                       # حفظ
        Ctrl+X                       # خروج
        locale-gen                   # توليد ملفات اللغات
        ```
    - Set locale and keymap:
        ```bash
        nano /etc/locale.conf        # تعيين اللغة الافتراضية
        LANG=en_US.UTF-8
        Ctrl+O
        Ctrl+X

        nano /etc/vconsole.conf      # تعيين تخطيط لوحة المفاتيح
        KEYMAP=us
        Ctrl+O
        Ctrl+X
        ```

> **Tip:** You can set the language to Arabic (`ar_MA.UTF-8`) if you prefer.

---

### 2.9 User Setup

14. **Set hostname and hosts file:**
    ```bash
    nano /etc/hostname               # اسم الجهاز
    arch
    Ctrl+O
    Ctrl+X

    nano /etc/hosts                  # إعداد ملف hosts
    127.0.0.1    localhost
    ::1          localhost
    127.0.1.1    arch.localdomain    arch
    Ctrl+O
    Ctrl+X
    ```

15. **Set root password and create user:**
    ```bash
    passwd                           # تعيين كلمة مرور root
    useradd -m -g users -G wheel,storage,power -s /bin/bash younes   # إنشاء مستخدم جديد
    passwd younes                    # تعيين كلمة مرور للمستخدم
    ```

---

### 2.10 Sudo & NetworkManager

16. **Enable sudo for wheel group:**
    ```bash
    EDITOR=nano visudo                # تحرير صلاحيات sudo
    # ابحث عن هذا السطر وأزل علامة #
    %wheel ALL=(ALL:ALL) ALL
    Ctrl+O
    Ctrl+X
    ```

17. **Switch to user and update:**
    ```bash
    su younes                         # تسجيل الدخول كمستخدم جديد
    sudo pacman -Syu                  # تحديث النظام
    exit                              # العودة إلى root
    ```

18. **Enable NetworkManager:**
    ```bash
    systemctl enable NetworkManager.service   # تفعيل خدمة الشبكة
    ```

---

### 2.11 GRUB Bootloader

19. **Install and configure GRUB:**
    ```bash
    grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB    # تثبيت محمل الإقلاع
    grub-mkconfig -o /boot/grub/grub.cfg                                               # إنشاء ملف إعدادات GRUB
    ```

---

### 2.12 Reboot & Initial Checks

20. **Finish installation:**
    ```bash
    exit                                       # خروج من chroot
    umount -R /mnt                             # إلغاء تركيب جميع الأقسام
    reboot                                     # إعادة التشغيل والدخول للنظام الجديد
    ```

21. **Post-install networking:**
    ```bash
    systemctl status NetworkManager             # التحقق من حالة الشبكة
    nmtui                                      # أداة إعداد الشبكة النصية
    ping google.com                            # اختبار الاتصال بالإنترنت
    ```

---

### 2.13 Mirror Optimization

22. **Optimize mirrors for faster updates:**
    ```bash
    sudo pacman -S reflector rsync curl          # تثبيت الأدوات المساعدة
    sudo reflector --verbose --country France,Germany,Spain,Morocco --protocol https --sort rate --fastest 10 --connection-timeout 3 --download-timeout 13 --save /etc/pacman.d/mirrorlist
    # تحديث قائمة مستودعات Arch بأسرع الخوادم
    ```

> **Tip:** Regularly update your mirrorlist for best download speeds.

---

### 2.14 Kernel & Headers Management (Recommended)

> **هام:** ينصح بتثبيت نواة LTS بالإضافة إلى رؤوس النواة (headers) لتوافق أفضل مع التعريفات وبرامج DKMS مثل تعريفات VirtualBox وVMware.

```bash
sudo pacman -Syu linux-headers linux-lts linux-lts-headers   # تثبيت رؤوس النواة والنواة طويلة الدعم
```

> **ابحث عن جميع الحزم المتعلقة بالنواة:**
```bash
pacman -Qs linux
```

---

### 2.15 Disabling KDE Wallet (If Needed)

> **لمنع ظهور نافذة محفظة KDE المزعجة (KWallet) خاصة في بيئات KDE أو عند تثبيت بعض التطبيقات:**

1. أوقف المحفظة من الإعدادات:
    ```bash
    nano ~/.config/kwalletrc
    # أضف أو عدل:
    [Wallet]
    Enabled=false
    Ctrl+O
    Ctrl+X
    ```
2. احذف بيانات المحفظة القديمة:
    ```bash
    rm -r ~/.local/share/kwalletd/
    ```
3. أعد تشغيل الجهاز:
    ```bash
    reboot
    ```

---

## 3. Hyperland Installation & Configuration (Updated)

### 3.1 Install Hyperland and Dependencies

Install Hyperland and essential Wayland packages:
```bash
sudo pacman -S hyprland xdg-desktop-portal-hyprland qt5-wayland qt6-wayland polkit-kde-agent
sudo pacman -S wayland wayland-protocols xorg-xwayland
```

Install graphics drivers, Vulkan, and utilities:
```bash
sudo pacman -S mesa vulkan-intel intel-media-driver libva-intel-driver xf86-video-intel vulkan-tools intel-gpu-tools brightnessctl mesa-utils xorg-server
```

Install core apps and Wayland utilities:
```bash
sudo pacman -S dunst waybar rofi-wayland thunar kitty
```

Install PipeWire for audio:
```bash
sudo pacman -S pipewire pipewire-pulse pipewire-jack pipewire-alsa alsa-utils
systemctl --user enable --now pipewire pipewire-pulse wireplumber
pactl info          # تحقق من حالة PulseAudio/ PipeWire
pactl list sinks    # تحقق من أجهزة الإخراج
```

Install display manager and fonts:
```bash
sudo pacman -S sddm noto-fonts
sudo systemctl enable sddm
```

System update:
```bash
sudo pacman -Syu
yay -Syu
```

---

### 3.2 Optional: Install AUR Helper and Apps

Install yay from AUR:
```bash
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
```

Install AUR packages (e.g., Brave, VS Code):
```bash
yay -S brave-bin
yay -Syu visual-studio-code-bin
```

---

### 3.3 Customize Hyperland

Edit main config:
```bash
nano ~/.config/hypr/hyprland.conf
# إذا ظهر تحذير "autogenerated = 1"، احذف هذا السطر
```

Add monitor setup (replace with your resolution):
```text
# example:
monitor=eDP-1,1366x768@60,auto,1
```

Add audio keybindings:
```text
# رفع الصوت
bind = , XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%
# خفض الصوت
bind = , XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%
# كتم الصوت
bind = , XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle
```

Reload Hyprland config:
```bash
hyprctl reload
hyprctl monitors all   # تحقق من إعدادات الشاشات
```

---

### 3.4 Network DNS Configuration

Set custom DNS servers:
```bash
sudo nano /etc/NetworkManager/conf.d/dns.conf
# أضف:
[main]
dns=1.1.1.1 8.8.8.8
ignore-auto-dns=yes
Ctrl+O Ctrl+X
sudo systemctl restart NetworkManager
cat /etc/resolv.conf  # تحقق من DNS
```

If using a specific WiFi connection:
```bash
sudo nmcli connection modify "Huawei P30" ipv4.dns "1.1.1.1 8.8.8.8"
sudo nmcli connection modify "Huawei P30" ipv4.ignore-auto-dns yes
sudo nmcli connection down "Huawei P30"
sudo nmcli connection up "Huawei P30"
cat /etc/resolv.conf  # يجب أن يظهر DNS الجديد
```

---

### 3.5 Fonts Setup

Install fonts:
```bash
sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-extra noto-fonts-emoji
sudo pacman -S ttf-dejavu ttf-liberation ttf-droid ttf-ubuntu-font-family
sudo pacman -S ttf-fira-code ttf-jetbrains-mono otf-font-awesome
fc-cache -fv
```

Fontconfig setup for preferred fonts:
```bash
mkdir -p ~/.config/fontconfig
nano ~/.config/fontconfig/fonts.conf
# أضف:
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
    <alias>
        <family>sans-serif</family>
        <prefer>
            <family>Noto Sans</family>
            <family>Noto Sans Arabic</family>
        </prefer>
    </alias>
    <alias>
        <family>serif</family>
        <prefer>
            <family>Noto Serif</family>
            <family>Noto Serif Arabic</family>
        </prefer>
    </alias>
    <alias>
        <family>monospace</family>
        <prefer>
            <family>Fira Code</family>
            <family>Noto Sans Mono</family>
        </prefer>
    </alias>
</fontconfig>
Ctrl+O Ctrl+X
fc-cache -fv
```

---

### 3.6 QT Themes & Customization

```bash
sudo pacman -S qt6ct qt5ct breeze papirus-icon-theme gnome-themes-extra qt6-base qt6-declarative
hyprctl reload
echo 'export QT_QPA_PLATFORMTHEME="qt6ct"' >> ~/.bashrc
source ~/.bashrc
echo $QT_QPA_PLATFORMTHEME  # تحقق من القيمة
```

---

### 3.7 Enable Multilib (Optional)

```bash
sudo nano /etc/pacman.conf
# احذف علامة التعليق أمام:
[multilib]
Include = /etc/pacman.d/mirrorlist
Ctrl+O Ctrl+X
sudo pacman -Syu
yay -Syu
```

---

### 3.8 Recommended Apps & Utilities

> **تثبيت بعض البرامج والأدوات المرئية والمساعدة:**

```bash
sudo pacman -S gthumb hyprpaper
```

---

## 4. Useful Video Resources

### Arch Linux Installation
- [Arch installation video #1](https://youtu.be/Q6jAtnqfWtI?si=n4a4qhFr8uJSZu9L)
- [Arch installation video #2](https://youtu.be/68z11VAYMS8?si=tpF2ZmSG2ZWUbB1Z)

### Hyperland Customization
- [Customization #1](https://youtu.be/qLLgoRaA4Es?si=TP8VaOoHtglldPZU)
- [Customization #2](https://youtu.be/yjyEaoi6qeM?si=7wAs8bvt_VqpA2rV)
- [Customization #3](https://youtu.be/VF3dec6r0zs?si=FEBGUVOBYIwT9OUi)
- [Customization #4](https://youtu.be/hNr1uyEqS48?si=dXGxAoBnnnSts4Y0)
- [Customization #5](https://youtu.be/hQ6IisETfeo?si=4eANe2LvzPNy0sbt)

### Applications Customization
- [Apps Customization #1](https://youtu.be/t3IqyWNOdPg?si=9CnvLia399qEhqaX)
- [Apps Customization #2](https://youtu.be/v8w1i3wAKiw?si=B1IkPEjwJOIBbKuG)
- [Apps Customization #3](https://youtu.be/RgV47l59NYs?si=FZqGYzifsP5OASS8)
- [Apps Customization #4](https://youtu.be/cUwu3mkrz_k?si=n7zDLS6RnCioiYIS)
- [Apps Customization #5](https://youtu.be/DDB1FTQPfr8?si=wY2S1vrkIlmfplpZ)

---

## 5. Tips & Troubleshooting

> **Tip:** Always update your system and mirrors after installation for the latest packages and security updates.

> **Note:** If you run into issues with WiFi or sound, check the Arch Wiki for your hardware, and make sure all firmware packages are installed.

> **Tip:** For advanced customization of Hyperland and QT applications, explore the video links above and refer to official documentation.

---

**Guide by [younesd321](https://github.com/younesd321)**  
For more notes and dotfiles, see [Arch-Dots](https://github.com/younesd321/Arch-Dots)
