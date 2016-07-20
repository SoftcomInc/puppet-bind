# Class: bind
#
# Install and enable an ISC BIND server.
#
# Parameters:
#  $chroot:
#   Enable chroot for the server. Default: false
#  $acls:
#   Hash of client ACLs, name as key and array of config lines. Default: empty
#  $masters:
#   Hash of master ACLs, name as key and array of config lines. Default: empty
#  $listen_on_port:
#   IPv4 port to listen on. Set to false to disable. Default: '53'
#  $listen_on_addr:
#   Array of IPv4 addresses to listen on. Default: [ '127.0.0.1' ]
#  $listen_on_v6_port:
#   IPv6 port to listen on. Set to false to disable. Default: '53'
#  $listen_on_v6_addr:
#   Array of IPv6 addresses to listen on. Default: [ '::1' ]
#  $forwarders:
#   Array of forwarders IP addresses. Default: empty
#  $directory:
#   Base directory for the BIND server. Default: '/var/named'
#  $host_name:
#   Hostname returned for hostname.bind TXT in CHAOS. Set to 'none' to disable.
#   Default: undef, bind internal default
#  $server_id:
#   ID returned for id.server TXT in CHAOS. Default: undef, empty
#  $version:
#   Version string override text. Default: none
#  $dump_file:
#   Dump file for the server. Default: '/var/named/data/cache_dump.db'
#  $statistics_file:
#   Statistics file for the server. Default: '/var/named/data/named_stats.txt'
#  $memstatistics_file:
#   Memory statistics file for the server.
#   Default: '/var/named/data/named_mem_stats.txt'
#  $allow_query:
#   Array of IP addrs or ACLs to allow queries from. Default: [ 'localhost' ]
#  $recursion:
#   Allow recursive queries. Default: 'yes'
#  $allow_recursion:
#   Array of IP addrs or ACLs to allow recursion from. Default: empty
#  $allow_transfer:
#   Array of IP addrs or ACLs to allow transfer to. Default: empty
#  $check_names:
#   Array of check-names strings. Example: [ 'master ignore' ]. Default: empty
#  $extra_options:
#   Hash for any additional options that must go in the 'options' declaration.
#   Default: empty
#  $dnssec_enable:
#   Enable DNSSEC support. Default: 'yes'
#  $dnssec_validation:
#   Enable DNSSEC validation. Default: 'yes'
#  $dnssec_lookaside:
#   DNSSEC lookaside type. Default: 'auto'
#  $zones:
#   Hash of managed zones and their configuration. The key is the zone name
#   and the value is an array of config lines. Default: empty
#  $tsig:
#   Hash of managed tsig keys and their configuration. The key is the tsig keys name
#   and the value is an array of config lines. Default: empty
#  $includes:
#   Array of absolute paths to named.conf include files. Default: empty
#
# Sample Usage :
#  include bind
#  class { 'bind':
#    chroot            => true,
#    acls => {
#      'rfc1918' => [ '10/8', '172.16/12', '192.168/16' ],
#    },
#    masters => {
#      'mymasters' => [ '192.0.2.1', '198.51.100.1' ],
#    },
#    zones => {
#      'example.com' => [
#        'type master',
#        'file "example.com"',
#      ],
#      'example.org' => [
#        'type slave',
#        'file "slaves/example.org"',
#        'masters { mymasters; }',
#      ],
#    }
#    keys                 => {
#      'example.org-tsig' => [
#        'algorithm hmac-md5',
#        'secret "aaabbbcccddd"',
#      ],
#    }
#  }
#
class bind (

  $chroot                 = $::bind::params::chroot,
  $acls                   = $::bind::params::acls,
  $masters                = $::bind::params::masters,
  $listen_on_port         = $::bind::params::listen_on_port,
  $listen_on_addr         = $::bind::params::listen_on_addr,
  $listen_on_v6_port      = $::bind::params::listen_on_v6_port,
  $listen_on_v6_addr      = $::bind::params::listen_on_v6_addr,
  $forwarders             = $::bind::params::forwarders,
  $directory              = $::bind::params::directory,
  $managed_keys_directory = $::bind::params::managed_keys_directory,
  $hostname               = $::bind::params::hostname,
  $server_id              = $::bind::params::server_id,
  $version                = $::bind::params::version,
  $allow_query            = $::bind::params::allow_query,
  $allow_query_cache      = $::bind::params::allow_query_cache,
  $recursion              = $::bind::params::recursion,
  $allow_recursion        = $::bind::params::allow_recursion,
  $allow_transfer         = $::bind::params::allow_transfer,
  $check_names            = $::bind::params::check_names,
  $extra_options          = $::bind::params::extra_options,
  $dnssec_enable          = $::bind::params::dnssec_enable,
  $dnssec_validation      = $::bind::params::dnssec_validation,
  $dnssec_lookaside       = $::bind::params::dnssec_lookaside,
  $zones                  = $::bind::params::zones,
  $keys                   = $::bind::params::keys,
  $includes               = $::bind::params::includes,
  $views                  = $::bind::params::views,
  $conf_file              = $::bind::params::conf_file,
  $dump_file              = $::bind::params::dump_file,
  $stats_file             = $::bind::params::stats_file,
  $mem_stats_file         = $::bind::params::mem_stats_file,


) inherits ::bind::params {

  anchor { 'bind::begin': } ->
  class { '::bind::install': } ->
  class { '::bind::config': } ->
  class { '::bind::service': } ->
  anchor { 'bind::end': }

}
