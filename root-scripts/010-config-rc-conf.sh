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
    # Extrai o valor do hostname
    hostname=$(extract_value "$line" "hostname")

    # Extrai o valor do keymap
    keymap=$(extract_value "$line" "keymap")

    # Extrai o valor do ifconfig_vtnet0
    ifconfig_vtnet0=$(extract_value "$line" "ifconfig_vtnet0")

    # Extrai o valor do defaultrouter
    defaultrouter=$(extract_value "$line" "defaultrouter")
  done < "$rc_conf"
fi

cat <<EOF> "$rc_conf"
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
  sendmail_enable="NONE"
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