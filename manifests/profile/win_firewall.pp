# Profile to open ports for HTTP/HTTPS access on Windows (uses webalex-windows_firewall)
#
# @param manage_firewall
#   Set to false if the firewall is already managed elsewhere (for example
#   with puppet-windows_firewall or GPO). The profile then does nothing and
#   the ports 80/443 must be opened by that solution.
class pupexa::profile::win_firewall (
  String        $win_fw_ensure,
  String        $win_fw_exception,
  String        $win_fw_exception_ensure,
  String        $win_fw_direction,
  String        $win_fw_action,
  Boolean       $win_fw_enabled,
  String        $win_fw_protocol,
  Array[String] $win_fw_local_port,
  String        $win_fw_remote_port,
  String        $win_fw_display_name,
  String        $win_fw_description,
  Boolean       $manage_firewall = false
) {

  if $manage_firewall {
    windows_firewall_rule { $win_fw_exception:
      ensure       => $win_fw_exception_ensure,
      direction    => $win_fw_direction,
      action       => $win_fw_action,
      enabled      => $win_fw_enabled,
      protocol     => $win_fw_protocol,
      local_port   => $win_fw_local_port,
      remote_port  => $win_fw_remote_port,
      display_name => $win_fw_display_name,
      description  => $win_fw_description,
    }
  }
}
