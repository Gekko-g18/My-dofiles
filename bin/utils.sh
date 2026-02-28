#!/bin/bash

# 1. Coleta de Informações do Sistema
DATA_HORA=$(date "+%A, %d de %B de %Y | %H:%M:%S")
CPU_USO=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4"%"}')
RAM_USO=$(free -m | awk 'NR==2{printf "%d/%dMB (%.1f%%)", $3,$2,$3*100/$2 }')
TEMP=$(sensors | grep "Package id 0:" | awk '{print $4}' || echo "N/A")

# Tenta pegar a GPU (Intel/AMD/Nvidia)
if command -v nvidia-smi &> /dev/null; then
    GPU_INFO=$(nvidia-smi --query-gpu=utilization.gpu,temperature.gpu --format=csv,noheader,nounits | awk -F', ' '{print $1"% | "$2"°C"}')
else
    GPU_INFO="N/A"
fi

# 2. Definição das Opções do Menu
# Estrutura: Ícone + Nome
opcoes=" Desligar\n Reiniciar\n Bloquear\n---\n󱓧 Obsidian\n󰈹 Zen Browser\n󰙯 Discord\n Spotify\n---\n Status: CPU $CPU_USO | $TEMP\n󰢮 GPU: $GPU_INFO\n RAM: $RAM_USO"

# 3. Execução do Wofi
# Usamos o prompt para exibir a data e hora completa no topo
escolha=$(echo -e "$opcoes" | wofi --dmenu \
    --location left_center \
    --width 350 \
    --height 100% \
    --prompt "$DATA_HORA" \
    --cache-file /dev/null | awk '{print $2}')

# 4. Ações
case $escolha in
    Desligar) loginctl poweroff ;;
    Reiniciar) loginctl reboot ;;
    Bloquear) swaylock -c 000000 ;;
    Obsidian) obsidian ;;
    Zen) zen-browser ;; # Verifique se o comando é este mesmo
    Discord) discord ;;
    Spotify) spotify ;;
    Status|GPU|RAM) foot -e btop ;; # Clicar nos status abre o btop detalhado
esac
