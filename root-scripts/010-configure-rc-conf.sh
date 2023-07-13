echo
echo Configure /etc/rc.conf
echo


# Nome do arquivo de configuração
rc_conf="/etc/rc.conf"

# Função para extrair valor de um parâmetro
extract_value() {
  local line=$1
  local parameter=$2
  local value=""

  if echo "$line" | grep -q "^$parameter="; then
    value=$(echo "$line" | cut -d'=' -f2)
    value=$(echo "$value" | tr -d '"' | tr -d ' ')
  fi

  echo "$value"
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

{
echo # MODULES/COMMON/BASE # ------------------------------------------------------
echo   hostname=\"$hostname\"
echo   keymap=\"$keymap\"
echo 
echo #
echo # NETWORK # ------------------------------------------------------------------
echo   ifconfig_vtnet0=\"$ifconfig_vtnet0\"
echo   defaultrouter=\"$defaultrouter\"
echo 
echo #
echo # DAEMONS | yes # ------------------------------------------------------------
echo   sshd_enable=\"YES\"             # SSH 
echo   ntpdate_enable=\"YES\"          # NTP 
echo   rctl_enable=\"YES\"             # Resource Control Enable
echo   devfs_load_rulesets=\"YES\"     # Device rulesets load
echo   jail_enable=\"YES\"             # Enable Jails
echo
echo 
echo #
echo # DAEMONS | no # -------------------------------------------------------------
echo   sendmail_enable=\"NONE\"
echo   dumpdev=\"NO\"
echo   sendmail_enable=NONE
echo   sendmail_submit_enable=\"NO\"
echo   sendmail_outbound_enable=\"NO\"
echo   sendmail_msp_queue_enable=\"NO\"
echo 
echo #
echo # FS # -----------------------------------------------------------------------
echo   zfs_enable=\"YES\"
echo   clear_tmp_enable=\"YES\"
echo   clear_tmp_X=\"YES\"
echo   growfs_enable=\"YES\"
echo 
echo #
echo # OTHER # --------------------------------------------------------------------
echo   syslogd_flags=\"-ss\"
echo   virecover_enable=\"NO\"
echo   # devfs_system_ruleset=\"desktop\"
echo   savecore_enable=\"NO\"
} > "$rc_conf"