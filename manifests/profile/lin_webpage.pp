# Profile to add custom webserver content
class pupexa::profile::lin_webpage (
  String $webcontent,
  String $weblocation
) {

  file { $weblocation:
    ensure  => file,
    content => $webcontent,
    require => Class['pupexa::profile::apache'],   # this makes sure the directory is already there on first agent run
  }
}
