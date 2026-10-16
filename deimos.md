# PupExa in deimos!

In the deimos control-repo do the following:

Make sure you are on the production branch. Add this to the Puppetfile:

```
mod 'pupexa',
  git:  'https://github.com/mrcmn/pupexa.git',
  branch:   'production'
```

In manifests/site.pp add this to `node default`:

```
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
```

Create a file in data/nodes, for example xyzabc-ubuntu24-0.se.automationdemos.com.yaml with following content:

```
classes:
  - pupexa::role::webapp
profile::platform::baseline::firewall::allow_ingress:
  - name: SSH
    port: 22
    protocol: tcp
    description: Secure Shell Access
  - name: RDP
    port: 3389
    protocol: tcp
  - name: HTTP
    port: 80
    protocol: tcp
    description: Secure Shell Access
  - name: HTTPS
    port: 443
    protocol: tcp
```

Test with http://xyzabc-ubuntu24-0.se.automationdemos.com (no ssl).

Try the same content for xyzabc-win2019-0.se.automationdemos.com.yaml.

Done!
