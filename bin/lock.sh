#!/bin/bash

IMG="/tmp/lockscreen.png"
CACHE="$HOME/.cache/last_lockscreen.png"
ICON="/home/gekko/Downloads/freirenicon.png"
NOME="Gekko"

# Cores Catppuccin Mocha
TEXT_COLOR="#cdd6f4"
ACCENT_COLOR="#b4befe"

if [ "$1" == "fast" ] && [ -f "$CACHE" ]; then
    cp "$CACHE" "$IMG"
else
    grim -t png "$IMG"
    
    # Escreve o nome com uma pequena sombra (stroke) para melhor leitura
    magick "$IMG" -gravity center -pointsize 45 \
        -fill "$ACCENT_COLOR" -annotate +0+160 "$NOME" "$IMG"
    
    if [ -f "$ICON" ]; then
        # Coloca a Frieren no centro
        magick composite -gravity center -geometry 1920x1080 "$ICON" "$IMG" "$IMG"
    fi
    cp "$IMG" "$CACHE"
fi

# Inicia o gtklock e dá o sleepzinho pro Lid não bugar
gtklock -d -s ~/.config/gtklock/style.css &
sleep 3.0
