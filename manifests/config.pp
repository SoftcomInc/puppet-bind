define bind::config inherits bind {

  case $::osfamily {
    'RedHat': {
      file { "${conf_dir}/named.conf":
        content => template('bind/RedHat-named.conf.erb'),
        notify  => Service["$service_name"],
      }
    }
    'Debian': {
      file { "${conf_dir}/named.conf":
        content => template('bind/Debian-named.conf.erb'),
        notify  => Service["$service_name"],
      }
      file { "${conf_dir}/named.conf.options":
        content => template('bind/Debian-named.conf.options.erb'),
        notify  => Service["$service_name"],
      }
      file { "${conf_dir}/named.conf.local":
        content => template('bind/Debian-named.conf.local.erb'),
        notify  => Service["$service_name"],
      }
    }
  }

}
