# Partitions
200MB -- UEFI
500MB -- /boot
4GB -- swap
//lvm total
//5GB -- /
10GB -- /home
//5GB -- /tmp
//20GB -- /usr
//20GB -- /var
1GB -- /var/log
//20GB -- /opt
estGB -- /

# Bootstrap commands
```bash
sudo apt update ; sudo apt upgrade -y ; sudo apt install -y git

cd ~
git clone https://github.com/olegische/intelsteam.git
sudo chmod +x intelsteam/script/ansible/ansible-srv.sh ;\
	sudo chmod +x intelsteam/script/setup.sh
sudo intelsteam/script/setup.sh
sudo intelsteam/script/ansible/ansible-srv.sh --install
```

# Comments
- Проверить файлы /etc/systemd/network/?.link на машине, с которой будут сниматься сетевые интерфейсы, чтобы запомнить соответствие мак адресов и имен интерфейсов sn и bnc
