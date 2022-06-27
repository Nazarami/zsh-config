#!/bin/sh

# Check to see if ZSH is already installed.
if ! [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh-my-zsh is not installed, installing now."
fi

echo "Oh-my-zsh installed, proceeding with plugin installation."

# Check to see if the plugins are already installed.
pluginLine="$(grep -E "^[^#].+(\)$)" "$HOME"/.zshrc)" || {
    echo "Failed to find .zshrc file or plugin line."
    exit 1
}

# Check to see if the plugins are already installed.
if echo "$pluginLine" | grep -q "zsh-autosuggestions"; then
    echo "zsh-autosuggestions already installed!"
    exit 1
fi

if echo "$pluginLine" | grep -q "zsh-syntax-highlighting"; then
    echo "zsh-syntax-highlighting already installed!"
    exit 1
fi


# Download syntax highlighting
echo "Downloading syntax highlighting now!"
git clone "https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"

# Download autosuggestions
echo "Downloading autosuggestions now!"
git clone "https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

sed -Ei "s?^plugins=\((.*)\)?\plugins=(\1 zsh-autosuggestions zsh-syntax-highlighting)?" "$HOME"/.zshrc

echo "Oh-my-zsh and plugins successfully installed. Please close and reopen your shell to observe the changes."
