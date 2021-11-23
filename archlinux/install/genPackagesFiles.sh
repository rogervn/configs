suffix="${1:-default}"
pacman -Qmq > packages-$suffix.aur
pacman -Qqn > packages-$suffix.native
