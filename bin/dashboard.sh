#!/bin/bash

# --- Coleta de Dados ---
DATA=$(date "+%A, %d de %B")
HORA=$(date "+%H:%M:%S")
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4"%"}')
TEMP=$(sensors | grep "Package id 0:" | awk '{print $4}' || echo "N/A")
RAM=$(free -m | awk 'NR==2{printf "%d/%dMB (%.1f%%)", $3,$2,$3*100/$2 }')

# Detectar GPU (ajustado para ser mais genérico)
if command -v nvidia-smi &> /dev/null; then
    GPU=$(nvidia-smi --query-gpu=utilization.gpu,temperature.gpu --format=csv,noheader,nounits | awk -F', ' '{print $1"% | "$2"°C"}')
else
    GPU=$(cat /sys/class/class/drm/card0/device/gpu_busy_percent 2>/dev/null || echo "0")"%"
fi

# --- Montagem do Menu ---
# Usamos espaços e ícones para criar a ilusão de seções
opcoes="󰃰  SISTEMA\n  Data: $DATA\n  Hora: $HORA\n  CPU: $CPU ($TEMP)\n  GPU: $GPU\n  RAM: $RAM\n\n󰀻  APLICATIVOS\n  󱓧 Obsidian\n  󰈹 Zen Browser\n  󰙯 Discord\n   Spotify\n\n  ENERGIA\n   Bloquear\n   Reiniciar\n   Desligar"

# --- Execução do Wofi ---
# --location 3 coloca o menu no centro-direita da tela
escolha=$(echo -e "$opcoes" | wofi --dmenu \
    --location 3 \
    --width 400 \
    --height 100% \
    --xoffset -10 \
    --prompt "Painel de Controle" \
    --style ~/.config/wofi/sidebar.css \
    --cache-file /dev/null | awk '{print $2}')

# --- Ações ---
case $escolha in
    Obsidian) obsidian ;;
    Zen) zen-browser ;;
    Discord) discord ;;
    Spotify) spotify ;;
    Bloquear) swaylock -c 000000 ;;
    Reiniciar) loginctl reboot ;;
    Desligar) loginctl poweroff ;;
esac
