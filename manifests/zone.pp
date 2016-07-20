# Define: bind::zone
#
# ISC BIND server template-based or pre-created zone file definition.
# Either of $source or $content must be specificed when using it.
#
# Parameters:
#  $zonedir:
#    Directory where to store the zone file. Default: '/var/named'
#  $owner:
#    Zone file user owner. Default: 'root'
#  $group:
#    Zone file group owner. Default: 'named'
#  $mode:
#    Zone file mode: Default: '0640'
#  $source:
#    Zone file content source. Default: none
#  $source_base:
#    Zone file content source base, where to look for a file named the same as
#    the zone itselt. Default: none
#  $content:
#    Zone file content (usually template-based). Default: none
#  $ensure:
#    Whether the zone file should be 'present' or 'absent'. Default: present.
#
# Sample Usage :
#  bind::server::file { 'example.com':
#    zonedir => '/var/named',
#    source  => 'puppet:///files/dns/example.com',
#  }
#
define bind::zone (
  $zonedir     = $::bind::params::conf_dir,
  $owner       = $::bind::params::bind_user,
  $group       = $::bind::params::bind_group,
  $mode        = '0640',
  $dirmode     = '0750',
  $source      = undef,
  $source_base = undef,
  $content     = undef,
  $ensure      = undef,
) inherits ::bind::params {

  if $source      { $zone_source = $source }
  if $source_base { $zone_source = "${source_base}${title}" }

  if ! defined(File[$zonedir]) {
    file { $zonedir:
      ensure => directory,
      owner  => $owner,
      group  => $group,
      mode   => $dirmode,
    }
  }

  file { "${zonedir}/${title}":
    ensure  => $ensure,
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    source  => $zone_source,
    content => $content,
    notify  => Service["$service_name"],
    # For the parent directory
    require => [
      Class['::bind::install'],
      File[$zonedir],
    ],
  }

}
