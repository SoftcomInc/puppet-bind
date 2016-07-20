class bind::install inherits bind {

  package { $package_name:
    ensure => $package_ensure,
  }

}
