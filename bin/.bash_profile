# 1. Carregar as configurações do seu .bashrc (Starship, Cores, Aliases)
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# 2. Configurar o PATH para o Rofi ver seus scripts e flatpaks
export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/bin:/usr/bin:/bin:/var/lib/flatpak/exports/bin"

# 3. Iniciar o Sway (mantenha como estava)
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    exec sway
fi
