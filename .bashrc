mkdir -p ~/.local/share/applications

# Atalho para o Ghidra
cat <<EOF > ~/.local/share/applications/ghidra.desktop
[Desktop Entry]
Name=Ghidra
Exec=$HOME/tools/ghidra_12.0.1_PUBLIC/ghidraRun
Icon=processor
Type=Application
Categories=Development;
EOF

# Atalho para o Obsidian
cat <<EOF > ~/.local/share/applications/obsidian.desktop
[Desktop Entry]
Name=Obsidian
Exec=$HOME/tools/obsidian/Obsidian-1.7.7.AppImage
Icon=notes
Type=Application
Categories=Office;
EOF

# No final do seu ~/.bashrc
export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/bin:/usr/bin:/bin:/var/lib/flatpak/exports/bin"

# Garanta que o Starship inicie
eval "$(starship init bash)"

# Habilita cores no ls, grep e fgrep
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# O "pulo do gato": diferencia diretórios com uma barra (/) e executáveis com (*)
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'

# Organiza deixando as pastas no topo da lista
alias ls='ls --color=auto --group-directories-first'
