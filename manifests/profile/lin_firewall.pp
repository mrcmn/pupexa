# Profile to open ports for HTTP/HTTPS access on Linux (Debian and RedHat family)
#
# @param manage_firewall
#   Set to false if the firewall is already managed elsewhere (for example
#   firewalld, ufw or your own puppetlabs-firewall setup). The profile then
#   does nothing and the ports 80/443 must be opened by that solution.
class pupexa::profile::lin_firewall (
  String  $fw_web_jump,
  String  $fw_web_proto,
  Array   $fw_web_port_list,
  String  $fw_web_description,
  Boolean $manage_firewall = false
) {

  if $manage_firewall {
    # On the RedHat family this stops and disables firewalld (firewalld_manage)
    include firewall

    firewall { $fw_web_description:
      dport => $fw_web_port_list,
      proto => $fw_web_proto,
      jump  => $fw_web_jump,
    }
  }
}
