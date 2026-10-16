# manifests/role/webapp.pp
class pupexa::role::webapp {
  case $facts['os']['family'] {
    'Debian', 'RedHat': {
      include pupexa::profile::lin_firewall
      include pupexa::profile::apache
      include pupexa::profile::lin_webpage
    }
    'windows': {
      include pupexa::profile::win_firewall
      include pupexa::profile::win_webpage
      include pupexa::profile::iis
    }
    default: {
      fail("Operating system not supported: ${facts['os']['family']}")
    }
  }
}
