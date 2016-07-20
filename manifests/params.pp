class bind::params {

  $chroot                 = false
  $acls                   = {}
  $masters                = {}
  $forwarders             = []
  $hostname               = undef
  $server_id              = undef
  $version                = undef
  $allow_query_cache      = []
  $allow_recursion        = []
  $allow_transfer         = []
  $check_names            = []
  $extra_options          = {}
  $zones                  = {}
  $keys                   = {}
  $includes               = []
  $views                  = {}

  $package_ensure         = 'present'
  $service_reload         = true
  $service_enable         = true
  $service_ensure         = 'running'

  case $::osfamily {
    'RedHat': {
      $conf_dir          = '/etc'
      $data_dir          = '/var/named'
      $listen_on_port    = '53'
      $listen_on_addr    = [ '127.0.0.1' ]
      $listen_on_v6_port = '53'
      $listen_on_v6_addr = [ '::1' ]
      $recursion         = 'yes'
      $allow_query       = [ 'localhost' ]
      $dnssec_enable     = 'yes'
      $dnssec_validation = 'yes'
      $dnssec_lookaside  = 'auto'
      $dump_file         = 'cache_dump.db'
      $stats_file        = 'named_stats.txt'
      $mem_stats_file    = 'named_mem_stats.txt'
      $managed_keys_dir  = '/var/named/dynamic'
      $bind_keys_file    = 'named.iscdlv.key'
      if $chroot == true {
        $package_name = 'bind-chroot'
      } else {
        $package_name = 'bind'
      }
      if $chroot == true and versioncmp($::operatingsystemrelease, '7') >= 0 {
        $service_name = 'named-chroot'
      } else {
        $service_name = 'named'
      }
      $bind_user         = 'root'
      $bind_group        = 'named'
    }
    'Debian': {
      $conf_dir          = '/etc/bind'
      $data_dir          = '/var/cache/bind'
      $listen_on_port    = undef
      $listen_on_addr    = []
      $listen_on_v6_port = undef
      $listen_on_v6_addr = [ 'any' ]
      $recursion         = undef
      $allow_query       = []
      $dnssec_enable     = undef
      $dnssec_validation = 'auto'
      $dnssec_lookaside  = undef
      $dump_file         = undef
      $stats_file        = undef
      $mem_stats_file    = undef
      $managed_keys_dir  = undef
      $bind_keys_file    = undef
      $package_name      = 'bind9'
      $service_name      = 'bind9'
      $bind_user         = 'bind'
      $bind_group        = 'bind'
    }
  }

}

