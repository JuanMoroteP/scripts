#\bin\bash
systemctl stop NetworkManager      #Parar NetworkManager
systemctl disable NetworkManager   #deshabilitar NetworkManager
systemctl enable --now systemd-networkd    #habilitar systemd-networkd
systemctl enable --now systemd-resolved    #habilitar systemd-resolved
for file in /etc/netplan/*.yaml; do mv -- "$file" "${file%.yaml}.yaml.old"; done
echo "introduce el valor de la IP que has recibido (se parece a esta: 10.10.x.x) - ponla SIN mascara"
read ip
echo "network:" > /etc/netplan/00_ipsMPO.yaml
echo "    ethernets:" >> /etc/netplan/00_ipsMPO.yaml
echo "        enp1s0:" >> /etc/netplan/00_ipsMPO.yaml
echo "            dhcp4: true" >> /etc/netplan/00_ipsMPO.yaml
echo "        enp2s0:" >> /etc/netplan/00_ipsMPO.yaml
echo "          dhcp4: no" >> /etc/netplan/00_ipsMPO.yaml
echo "          addresses:" >> /etc/netplan/00_ipsMPO.yaml
echo "            - \""$ip"/23\"" >> /etc/netplan/00_ipsMPO.yaml
echo "    version: 2" >> /etc/netplan/00_ipsMPO.yaml
chmod g-r /etc/netplan/00_ipsMPO.yaml
chmod o-r /etc/netplan/00_ipsMPO.yaml
netplan apply
