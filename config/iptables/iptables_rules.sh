#!/bin/bash
# IPTables configuration for VM-KL (Kali) in lab NET051
# Basado en el proyecto de laboratorio de seguridad ASIR.

# Limpieza de reglas previas
iptables -F
iptables -X
iptables -t nat -F
iptables -t mangle -F
iptables -t nat -X
iptables -t mangle -X

# Políticas por defecto
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP

# Permitir loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Permitir tráfico ya establecido/relacionado
iptables -A INPUT  -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Permitir SSH y HTTP desde VM-WIN (192.168.10.4) hacia VM-KL (este host)
iptables -A INPUT -p tcp -s 192.168.10.4 --dport 22 -m conntrack --ctstate NEW -j ACCEPT
iptables -A INPUT -p tcp -s 192.168.10.4 --dport 80 -m conntrack --ctstate NEW -j ACCEPT
# (Opcional) permitir ping ICMP desde VM-WIN
iptables -A INPUT -p icmp -s 192.168.10.4 -j ACCEPT

# Reglas de salida necesarias para navegar (DNS + HTTP/HTTPS)
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 80 -m conntrack --ctstate NEW -j ACCEPT
iptables -A OUTPUT -p tcp --dport 443 -m conntrack --ctstate NEW -j ACCEPT

# Ejemplo de NAT para red VPN 10.8.0.0/24 si esta máquina actúa como gateway
# iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE

# Ejemplos de bloqueo de IPs (UOC / YouTube) - solo válidos como demostración
# iptables -A OUTPUT -d 52.84.66.30 -p tcp --dport 80 -j REJECT
# iptables -A OUTPUT -d 216.58.215.174 -p tcp --dport 443 -j REJECT

# Mostrar reglas
iptables -L -n -v
