#!/bin/sh
set -e

echo
echo Configure firewall
echo


cat <<EOF> /usr/local/etc/pf.conf

# Define as interfaces de rede
ext_if="vtnet0"
int_if="bridge1"

# Opções globais
set skip on lo0

# Normalização (opcional)
scrub in on $ext_if all fragment reassemble
scrub out on $ext_if random-id

# Fila de pacotes (opcional)
# Exemplo: priorize o tráfego de saída do int_if
# altq on $int_if cbq bandwidth 100M queue { myqueue }
# queue myqueue bandwidth 80% default

# Tradução (NAT)
nat on $ext_if from $int_if:network to any -> ($ext_if)

# Filtragem
pass out on $int_if from $int_if:network to any keep state
pass in on $int_if from any to $int_if:network keep state


# Regras padrão
block all

# Regras para o ext_if
pass in on $ext_if proto tcp to port { 22 }

pass out proto { tcp udp } to port { 22 53 80 123 443 }
pass inet proto icmp icmp-type { echoreq unreach }

# liberar o tráfego UDP para o DNS na interface int_if
pass in on $int_if proto udp from $int_if:network to any port 53 keep state

# liberar as portas 80 e 443 na interface int_if
pass in on $int_if proto tcp from $int_if:network to any port { 80, 443 } keep state
EOF