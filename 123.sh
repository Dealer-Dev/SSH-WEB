#!/bin/bash

function msg {
  BRAN='\033[1;37m' && RED='\e[31m' && GREEN='\e[32m' && YELLOW='\e[33m'
  BLUE='\e[34m' && MAGENTA='\e[35m' && MAG='\033[1;36m' && BLACK='\e[1m' && SEMCOR='\e[0m'
  case $1 in
  -ne) cor="${RED}${BLACK}" && echo -ne "${cor}${2}${SEMCOR}" ;;
  -ama) cor="${YELLOW}${BLACK}" && echo -e "${cor}${2}${SEMCOR}" ;;
  -verm) cor="${YELLOW}${BLACK}[!] ${RED}" && echo -e "${cor}${2}${SEMCOR}" ;;
  -azu) cor="${MAG}${BLACK}" && echo -e "${cor}${2}${SEMCOR}" ;;
  -verd) cor="${GREEN}${BLACK}" && echo -e "${cor}${2}${SEMCOR}" ;;
  -bra) cor="${RED}" && echo -ne "${cor}${2}${SEMCOR}" ;;
  -nazu) cor="${COLOR[6]}${BLACK}" && echo -ne "${cor}${2}${SEMCOR}" ;;
  -gri) cor="\e[5m\033[1;100m" && echo -ne "${cor}${2}${SEMCOR}" ;;
  "-bar2" | "-bar") cor="${RED}————————————————————————————————————————————————————" && echo -e "${SEMCOR}${cor}${SEMCOR}" ;;
  esac
}

function fun_bar {
  comando="$1"
  _=$(
    $comando >/dev/null 2>&1
  ) &
  >/dev/null
  pid=$!
  while [[ -d /proc/$pid ]]; do
    echo -ne " \033[1;33m["
    for ((i = 0; i < 20; i++)); do
      echo -ne "\033[1;31m##"
      sleep 0.5
    done
    echo -ne "\033[1;33m]"
    sleep 1s
    echo
    tput cuu1
    tput dl1
  done
  echo -e " \033[1;33m[\033[1;31m########################################\033[1;33m] - \033[1;32m100%\033[0m"
  sleep 1s
}

function print_center {
  if [[ -z $2 ]]; then
    text="$1"
  else
    col="$1"
    text="$2"
  fi

  while read line; do
    unset space
    x=$(((54 - ${#line}) / 2))
    for ((i = 0; i < $x; i++)); do
      space+=' '
    done
    space+="$line"
    if [[ -z $2 ]]; then
      msg -azu "$space"
    else
      msg "$col" "$space"
    fi
  done <<<$(echo -e "$text")
}

function title {
  clear
  msg -bar
  if [[ -z $2 ]]; then
    print_center -azu "$1"
  else
    print_center "$1" "$2"
  fi
  msg -bar
}

function stop_install {
  [[ ! -e /bin/pweb ]]  && {
    title "INSTALAÇÃO CANCELADA" "\033[1;31m[\033[1;33mX\033[1;31m]"
    msg -verm "\n        ⚠️ A instalação foi cancelada pelo usuário! ⚠️\n\n"
    msg -bar
    exit 0
  }
  [[ ! -e /bin/pweb ]] && {
    clear
    title "REMOVENDO SCRIPTS" "\033[1;31m[\033[1;33mX\033[1;31m]"
    msg -azu "\n        Removendo arquivos, aguarde...\n"
    msg -bar2
    sleep 2
    rm -rf /etc/ger-frm /usr/bin/gefr /bin/pweb > /dev/null 2>&1
    msg -bar
    msg -verd "         ✅ REMOVIDO COM SUCESSO! ✅"
    msg -bar
    exit 0
  }
}

function download_scripts {
  [[ -e /etc/ger-frm ]] && {
    title "ATUALIZANDO SCRIPTS" "\033[1;31m[\033[1;33mX\033[1;31m]"
    msg -azu "\n        Atualizando arquivos, aguarde...\n"
    msg -bar2
    sleep 2
    wget -O /bin/pweb https://raw.githubusercontent.com/PatoGordo/ger-frm/main/ger-fram.sh > /dev/null 2>&1
    wget -O /usr/bin/gefr https://raw.githubusercontent.com/PatoGordo/ger-frm/main/ger-frm.sh > /dev/null 2>&1
    wget -O /etc/ger-frm https://raw.githubusercontent.com/PatoGordo/ger-frm/main/ger-frm.sh > /dev/null 2>&1
    chmod +x /bin/pweb /usr/bin/gefr /etc/ger-frm
    msg -bar
    msg -verd "        ✅ ATUALIZADO COM SUCESSO! ✅"
    msg -bar
    exit 0
  }
  [[ ! -e /etc/ger-frm ]] && {
    title "INSTALANDO SCRIPTS" "\033[1;31m[\033[1;33mX\033[1;31m]"
    msg -azu "\n        Baixando arquivos, aguarde...\n"
    msg -bar2
    sleep 2
    wget -O /bin/pweb https://raw.githubusercontent.com/PatoGordo/ger-frm/main/ger-frm.sh > /dev/null 2>&1
    wget -O /usr/bin/gefr https://raw.githubusercontent.com/PatoGordo/ger-frm/main/ger-frm.sh > /dev/null 2>&1
    wget -O /etc/ger-frm https://raw.githubusercontent.com/PatoGordo/ger-frm/main/ger-frm.sh > /dev/null 2>&1
    chmod +x /bin/pweb /usr/bin/gefr /etc/ger-frm
    msg -bar
    msg -verd "       ✅ INSTALADO COM SUCESSO! ✅"
    msg -bar
    exit 0
  }
}

function get_vncpasswd {
  [[ ! -e /root/.vnc/passwd ]] && {
    title "DEFINIR SENHA VNC" "\033[1;31m[\033[1;33mX\033[1;31m]"
    msg -azu "\n        Configure uma senha para o VNC\n"
    vncpasswd
    msg -verd "\n      Senha VNC definida com sucesso!"
    msg -bar
    exit 0
  }
}

function alterar_vncpasswd {
  [[ -e /root/.vnc/passwd ]] && {
    title "ALTERAR SENHA VNC" "\033[1;31m[\033[1;33mX\033[1;31m]"
    msg -azu "\n        Altere a senha atual do VNC\n"
    vncpasswd
    msg -verd "\n      Senha VNC alterada com sucesso!"
    msg -bar
    exit 0
  }
}

function mudar_porta {
  [[ -z $porta ]] && {
    title "ALTERAR PORTA SSH" "\033[1;31m[\033[1;33mX\033[1;31m]"
    echo -ne "\n\033[1;32m  Nova Porta: \033[1;37m"
    read porta
  }
  [[ ! -z $porta ]] && {
    if [[ ! -z $(grep -wE $porta /etc/ssh/sshd_config) ]]; then
      title "PORTA EM USO!" "\033[1;31m[\033[1;33mX\033[1;31m]"
      msg -verm "\n       A porta $porta já está em uso. Escolha outra porta."
      msg -bar
      exit 1
    else
      title "ALTERANDO PORTA SSH" "\033[1;31m[\033[1;33mX\033[1;31m]"
      msg -azu "\n        Alterando porta SSH para $porta\n"
      sed -i "s/Port .*/Port $porta/" /etc/ssh/sshd_config
      service ssh restart > /dev/null 2>&1
      msg -verd "\n     Porta SSH alterada com sucesso!"
      msg -bar
      exit 0
    fi
  }
}

function fun_ip {
  ip=$(curl -s -H 'Cache-Control: no-cache' -H 'Pragma: no-cache' --compressed ifconfig.me 2>/dev/null || echo '')
  if [[ -z $ip ]]; then
    ip=$(curl -s -H 'Cache-Control: no-cache' -H 'Pragma: no-cache' --compressed ipinfo.io/ip 2>/dev/null || echo '')
  fi
  if [[ -z $ip ]]; then
    ip=$(curl -s -H 'Cache-Control: no-cache' -H 'Pragma: no-cache' --compressed ident.me 2>/dev/null || echo '')
  fi
  if [[ -z $ip ]]; then
    ip=$(curl -s -H 'Cache-Control: no-cache' -H 'Pragma: no-cache' --compressed api.ipify.org 2>/dev/null || echo '')
  fi
  if [[ -z $ip ]]; then
    ip=$(curl -s -H 'Cache-Control: no-cache' -H 'Pragma: no-cache' --compressed "https://v4.ident.me" 2>/dev/null || echo '')
  fi
  if [[ -z $ip ]]; then
    ip=$(curl -s -H 'Cache-Control: no-cache' -H 'Pragma: no-cache' --compressed "https://ipinfo.io/ip" 2>/dev/null || echo '')
  fi
  if [[ -z $ip ]]; then
    ip=$(curl -s -H 'Cache-Control: no-cache' -H 'Pragma: no-cache' --compressed "https://ipinfo.io" 2>/dev/null || echo '')
  fi
  if [[ -z $ip ]]; then
    ip=$(curl -s -H 'Cache-Control: no-cache' -H 'Pragma: no-cache' --compressed "https://www.trackip.net/ip" 2>/dev/null || echo '')
  fi
  if [[ -z $ip ]]; then
    ip=$(curl -s -H 'Cache-Control: no-cache' -H 'Pragma: no-cache' --compressed "https://www.trackip.net/ip?json" 2>/dev/null || echo '')
  fi
  if [[ -z $ip ]]; then
    ip=$(curl -s -H 'Cache-Control: no-cache' -H 'Pragma: no-cache' --compressed "https://checkip.amazonaws.com" 2>/dev/null || echo '')
  fi
  if [[ -z $ip ]]; then
    ip="IP não encontrado"
  fi
  echo $ip
}

function print_info {
  info=$(cat << EOF
  \n  • IP VPS: $(fun_ip)
  \n  • Painel de Gerenciamento: \033[1;36mpweb\033[0m
  \n  • Script Gerenciador de Frames: \033[1;36mgefr\033[0m
  \n  • Arquivos de Configuração: \033[1;36m/etc/ger-frm\033[0m
  \n  • Senha VNC: \033[1;36m/root/.vnc/passwd\033[0m
  \n  • Alterar Senha VNC: \033[1;36m/root/.vnc/passwd\033[0m
  \n  • Alterar Porta SSH: \033[1;36m/etc/ssh/sshd_config\033[0m
EOF
  )
  print_center -verd "$info"
  msg -bar
}

function menu {
  clear
  msg -bar
  echo -e "         \033[1;32mGERENCIADOR DE FRAMES\033[0m"
  msg -bar
  echo -e "\033[1;36m[\033[1;31m01\033[1;36m] \033[1;33m-\033[1;37m Instalar Painel de Gerenciamento"
  echo -e "\033[1;36m[\033[1;31m02\033[1;36m] \033[1;33m-\033[1;37m Atualizar Painel de Gerenciamento"
  echo -e "\033[1;36m[\033[1;31m03\033[1;36m] \033[1;33m-\033[1;37m Remover Painel de Gerenciamento"
  echo -e "\033[1;36m[\033[1;31m04\033[1;36m] \033[1;33m-\033[1;37m Instalar Script Gerenciador de Frames"
  echo -e "\033[1;36m[\033[1;31m05\033[1;36m] \033[1;33m-\033[1;37m Atualizar Script Gerenciador de Frames"
  echo -e "\033[1;36m[\033[1;31m06\033[1;36m] \033[1;33m-\033[1;37m Remover Script Gerenciador de Frames"
  echo -e "\033[1;36m[\033[1;31m07\033[1;36m] \033[1;33m-\033[1;37m Definir Senha VNC"
  echo -e "\033[1;36m[\033[1;31m08\033[1;36m] \033[1;33m-\033[1;37m Alterar Senha VNC"
  echo -e "\033[1;36m[\033[1;31m09\033[1;36m] \033[1;33m-\033[1;37m Alterar Porta SSH"
  echo -e "\033[1;36m[\033[1;31m10\033[1;36m] \033[1;33m-\033[1;37m Informações do Painel e Scripts"
  echo -e "\033[1;36m[\033[1;31m11\033[1;36m] \033[1;33m-\033[1;37m Sair"
  msg -bar
  echo -ne "\033[1;32mOpção:\033[1;37m "
  read option
  case $option in
  1) download_scripts ;;
  2) download_scripts ;;
  3) stop_install ;;
  4) download_scripts ;;
  5) download_scripts ;;
  6) stop_install ;;
  7) get_vncpasswd ;;
  8) alterar_vncpasswd ;;
  9) mudar_porta ;;
  10) print_info ;;
  11) clear && exit ;;
  *) msg -verm "\n   Opção inválida! Digite um número válido." && sleep 2 ;;
  esac
}

menu
