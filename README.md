# PupExa - Puppet Examples for Demos and Training!

The examples in this puppet module contain very simplified (as best as possible) puppet examples. It is _not_ following any style guides or language best practices (like: https://help.puppet.com/core/9/Content/PuppetCore/style_guide.htm). I usually use these to explain classes, roles, profiles, hiera data and more. 

This module requires other modules. Ensure that the following is present in the Puppetfile (no need for the version numbers to be exactly the following, but modules should be working together):

```
forge 'https://forge.puppet.com'

mod 'puppetlabs-firewall',                    '8.1.3'
mod 'puppetlabs-apache',                      '12.3.1'
mod 'puppetlabs-stdlib',                      '10.0.1'
mod 'puppet-archive',                         '7.1.0' # not needed in the pupexa module

mod 'puppetlabs-pwshlib',                     '2.0.1'
mod 'puppetlabs-registry',                    '5.0.2'
mod 'puppetlabs-iis',                         '10.0.1'
mod 'webalex-windows_firewall',               '1.7.0'

mod 'puppetlabs-concat',                      '9.1.0'
```

To include this module in a Puppet Enterprise environment add the following to the Puppetfile in your control-repo:

```
mod 'pupexa',
  git:  'https://github.com/mrcmn/pupexa.git',
  branch:   'production'
```

Then, you only need to classify pupexa::role::webapp and assign nodes. Do this for example in Puppet Enterprise Node Groups. Or if you are interested in hiera classification, the following would be an example.

In the control-repo of the Puppet Enterprise server make sure this is the minimum functionality in manifests/site.pp:

```
File { backup => false }     # not needed in the pupexa module
node default {
  lookup( {
    'name'          => 'classes',
    'value_type'    => Array,
    'default_value' => [],
    'merge'         => {
      'strategy' => 'unique',
    },
  } ).each | $c | {
    include $c
  }
}
```

Then in the control-repo hiera file specify (for example for a node 'windows.vm' create a file data/nodes/windows.vm.yaml):

```
classes:
  - pupexa::role::webapp
```

## Firewall handling on Linux

The profile `pupexa::profile::lin_firewall` uses `puppetlabs-firewall` (iptables) for Debian and RedHat family systems. With the `true` settings it includes the `firewall` class, which on the RedHat family **stops and disables firewalld**. Ports that were opened through firewalld are then no longer active.

If the firewall is already managed in your control-repo (firewalld, ufw, an own puppetlabs-firewall setup, ...) or elswhere (sce modules), leave the firewall handling of this module disabled and open ports 80 and 443 with your existing solution. Turn on here in hiera with:

```
pupexa::profile::lin_firewall::manage_firewall: true
```

The firewall management here is turned off by default, because this is just an example and does not manage other ports like 22 or 3389.

## Firewall handling on Windows

The profile `pupexa::profile::win_firewall` uses `webalex-windows_firewall` to create the inbound rule for HTTP/HTTPS. Note that this module expects `local_port` as an array of strings (for example `['80', '443']`); a comma separated string or integers are rejected.

If the firewall is already managed in your control-repo (for example with `puppet-windows_firewall`), leave the firewall handling of this module disabled and open ports 80 and 443 with your existing solution. Turn on here in hiera with:

```
pupexa::profile::win_firewall::manage_firewall: true
```

The firewall management here is turned off by default, because this is just an example and does not manage other ports like 22 or 3389.
