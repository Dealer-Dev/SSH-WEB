#!/bin/bash
clear
echo -e "\033[1;36mINSTALANDO SINCRONIZADOR SSH WEB\033[0m"
echo "America/Sao_Paulo" > /etc/timezone
ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata
clear
echo -e "\033[1;36mPOR FAVOR AGUARDE...\033[0m"
crack=$(cut -d"'" -f2 /opt/sshplus/licenca.txt) > /dev/null 2>&1
sleep 1.5
echo -e "\033[1;36m🐇 REGISTRANDO LICENCIA 🐇\033[0m"
rm *.sh* > /dev/null 2>&1
rm *.zip > /dev/null 2>&1
apt install unzip -y > /dev/null 2>&1
wget https://raw.githubusercontent.com/CoutySSH/SSH-WEB/main/sshplus.zip.001 > /dev/null 2>&1
wget https://raw.githubusercontent.com/CoutySSH/SSH-WEB/main/sshplus.zip.002 > /dev/null 2>&1
wget https://raw.githubusercontent.com/CoutySSH/SSH-WEB/main/sshplus.zip.003 > /dev/null 2>&1
cat sshplus.zip* > monitor.zip && zip -F monitor.zip > /dev/null 2>&1
rm -rf /opt/sshplus > /dev/null 2>&1
unzip monitor.zip -d  /opt/sshplus/ > /dev/null 2>&1
chmod -R 777 /opt/sshplus > /dev/null 2>&1
sleep 1
if [[ -e "/opt/sshplus/licenca.txt" ]]; then
sed -i "s;ATIVADO;$crack;g" /opt/sshplus/licenca.txt > /dev/null 2>&1
fi
clear
wget https://raw.githubusercontent.com/CoutySSH/SSH-WEB/main/sincpainel.zip > /dev/null 2>&1
unzip sincpainel.zip > /dev/null 2>&1
chmod +x *sh > /dev/null 2>&1
service ssh restart
echo -e "\n\033[1;32mCONCLUÍDO!\033[0m"
sleep 15
echo -e "\033[1;36mENTRE AL PAINEL Y CREE UNA CUENNTA SSH PARA VER SI ESTÁ TODO BIEN!\033[0m"
sleep 5
cat /dev/null > ~/.bash_history && history -c && clear
rm sincpainel* > /dev/null 2>&1
rm *.zip > /dev/null 2>&1
rm *.001 > /dev/null 2>&1
rm *.002 > /dev/null 2>&1
rm *.003 > /dev/null 2>&1
clear
menu
