#!/bin/sh

# Check to see if ZSH is already installed.
if ! [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh-my-zsh is not installed, installing now."
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh 2>/dev/null && {
        echo "Oh-my-zsh installed!"
    }

    # Check to see if .zshrc exists
    if [ -f "$HOME/.zshrc" ]; then
        echo "Making backup of ~/.zshrc file in ~/.zshrc.orig"
        cp ~/.zshrc ~/.zshrc.orig
    fi

    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

    # Check to see if the default shell is already ZSH
    if ! echo "$SHELL" | grep -q "zsh"; then
        while true; do
            read -r "Would you like the default shell to be ZSH? " yn
            case $yn in
            [Yy]*)
                chsh -s "$(which zsh)"
                break
                ;;
            [Nn]*) break ;;
            *) echo "Please answer yes or no." ;;
            esac
        done
    fi
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
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME"/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Download autosuggestions
echo "Downloading autosuggestions now!"
git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME"/.oh-my-zsh/custom/plugins/zsh-autosuggestions

tempFile=$(mktemp)
sed -E "s?^plugins=\((.*)\)?\plugins=(\1 zsh-autosuggestions zsh-syntax-highlighting)?" "$HOME"/.zshrc >"$tempFile"
cat "$tempFile" >"$HOME"/.zshrc
rm "$tempFile"
echo "Oh-my-zsh and plugins successfully installed. Please close and reopen your shell to observe the changes."


