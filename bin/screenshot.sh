#!/bin/bash
mkdir -p /home/gekko/Imagens
FILENAME="/home/gekko/Imagens/$(date +%Y-%m-%d_%H-%M-%S).png"

# O grim tira o print, o tee salva no arquivo e passa para o wl-copy
grim -g "$(slurp)" - | tee "$FILENAME" | wl-copy --type image/png
