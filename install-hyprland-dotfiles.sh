#!/bin/bash

# Màu sắc in terminal
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 Bắt đầu cài đặt các gói cần thiết...${NC}"
yay -Syu --noconfirm \
    hyprland-git \
    waybar-hyprland-git \
    swaylock-effects \
    wlogout \
    wofi \
    capitaine-cursors \
    sweet-theme-git \
    xdg-desktop-portal-hyprland

echo -e "${GREEN}📁 Clone dotfiles từ Git (bare repo)...${NC}"
git clone --depth 1 --separate-git-dir=$HOME/.dotfiles https://github.com/nabakdev/dotfiles.git $HOME/dotfiles-tmp

echo -e "${GREEN}🧹 Xóa thư mục tạm...${NC}"
rm -rf $HOME/dotfiles-tmp

echo -e "${GREEN}🏷️ Tạo alias 'dotfile' vào ~/.bashrc...${NC}"
echo "alias dotfile='/usr/bin/git --git-dir=\$HOME/.dotfiles/ --work-tree=\$HOME'" >> ~/.bashrc
source ~/.bashrc

echo -e "${GREEN}📦 Đang checkout dotfiles vào \$HOME...${NC}"
mkdir -p .config-backup
dotfile checkout 2>&1 | grep -E "\s+\." | awk {'print $1'} | while read file; do
    mv "$file" ".config-backup/$file"
done

dotfile checkout

echo -e "${GREEN}✅ Dotfiles đã được cài đặt thành công!${NC}"
echo -e "${GREEN}👉 Đăng xuất và chọn Hyprland để đăng nhập vào môi trường mới.${NC}"
