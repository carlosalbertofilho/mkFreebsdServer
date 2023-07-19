#!/bin/sh
set -e

echo
echo Configure /etc/rc.conf
echo

# Nome do arquivo de configuração
rc_conf="/etc/rc.conf"

# Função para extrair valor de um parâmetro
extract_value() {
  _line="$1"
  _parameter="$2"
  _value=""

  if echo "$_line" | grep -q "^$_parameter="; then
    _value=$(echo "$_line" | cut -d'=' -f2)
    _value=$(echo "$_value" | tr -d '"' | tr -d ' ')
  fi

  echo "$_value"
}

# Verifica se o arquivo de configuração existe
if [ -f "$rc_conf" ]; then
  # Lê o arquivo linha por linha
  while IFS= read -r line; do
    # Extrai o valor do hostname, keymap, ifconfig_vtnet0 e defaultrouter
    hostname=$(extract_value "$line" "hostname")
    keymap=$(extract_value "$line" "keymap")
    ifconfig_vtnet0=$(extract_value "$line" "ifconfig_vtnet0")
    defaultrouter=$(extract_value "$line" "defaultrouter")
  done < "$rc_conf"
fi

# Cria um arquivo temporário com as novas configurações
tmp_rc_conf="/tmp/rc.conf.tmp"
cat > "$tmp_rc_conf" <<EOF
# MODULES/COMMON/BASE # ------------------------------------------------------
hostname="$hostname"
keymap="$keymap"

#
# NETWORK # ------------------------------------------------------------------
ifconfig_vtnet0="$ifconfig_vtnet0"
defaultrouter="$defaultrouter"
#
# FIREWALL # ------------------------------------------------------------------
pf_enable="YES"
pf_rules="/usr/local/etc/pf.conf"
pflog_enable="YES"
pflog_logfile="/var/log/pflog"

#
# DAEMONS | yes # ------------------------------------------------------------
sshd_enable="YES"             # SSH 
ntpdate_enable="YES"          # NTP 
rctl_enable="YES"             # Resource Control Enable
devfs_load_rulesets="YES"     # Device rulesets load
jail_enable="YES"             # Enable Jails

#
# DAEMONS | no # -------------------------------------------------------------
dumpdev="NO"
sendmail_enable="NONE"
sendmail_submit_enable="NO"
sendmail_outbound_enable="NO"
sendmail_msp_queue_enable="NO"

#
# FS # -----------------------------------------------------------------------
zfs_enable="YES"
clear_tmp_enable="YES"
clear_tmp_X="YES"
growfs_enable="YES"

#
# OTHER # --------------------------------------------------------------------
syslogd_flags="-ss"
virecover_enable="NO"
devfs_system_ruleset="server"
savecore_enable="NO"
EOF

# Copia o conteúdo original do rc.conf para o arquivo temporário
if [ -f "$rc_conf" ]; then
  cat "$rc_conf" >> "$tmp_rc_conf"
fi

# Move o arquivo temporário para substituir o rc.conf original
mv "$tmp_rc_conf" "$rc_conf"

echo "Configurações atualizadas em $rc_conf."
