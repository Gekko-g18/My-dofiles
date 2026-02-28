#!/bin/bash
opcoes=" Desligar\n Reiniciar\n󰒲 Hibernar\n Bloquear"

# O comando abaixo abre o wofi e pega apenas a segunda palavra (ex: Desligar)
escolha=$(echo -e "$opcoes" | wofi --dmenu --width 200 --height 250 --cache-file /dev/null | awk '{print $2}')

case $escolha in
    Desligar) loginctl poweroff ;;
    Reiniciar) loginctl reboot ;;
    Hibernar) loginctl hibernate ;;
    Bloquear) swaylock -c 000000 ;;
esac
