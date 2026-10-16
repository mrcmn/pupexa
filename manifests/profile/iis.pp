# Profile to install a basic IIS webserver
class pupexa::profile::iis (
  Array $iis_feature_list,
) {
  $iis_features = $iis_feature_list

     iis_feature { $iis_features:
       ensure => 'present',
     }
}
