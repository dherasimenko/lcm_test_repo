notice("MODULE: MAINTENANCE: SOLIDFIRE")

# Make changes according to Your needs
$backend_name        = "SOLIDFIRE"
$volume_driver       = "cinder.volume.drivers.solidfire.SolidFireDriver"
$volume_backend_name = "SOLIDFIRE_BE"
$sf_san_ip           = "1.1.1.1"
$sf_san_login        = "solidfire_login"
$sf_san_password     = "solidfire_password"
$sf_san_emulate_512  = "True"
$sf_allow_tenant_qos = "False"

if $cinder_cfg_backends {
  $backends_array = split($cinder_cfg_backends, ',')
  if $backend_name in $backends_array {
    $backends = $cinder_cfg_backends
  }
  else {
    $backends = "${cinder_cfg_backends},${backend_name}"
  }
}
else {
  $backends = $backend_name
}

if !defined(Package['cinder-volume']){
  package { 'cinder-volume':
    ensure => $package_ensure,
    name   => $::cinder::params::volume_package,
  }
}

if !defined(Service['cinder-volume']){
  service { 'cinder-volume':
    ensure     => $ensure,
    name       => $::cinder::params::volume_service,
    enable     => $enabled,
    hasstatus  => true,
    hasrestart => true,
  }
}

if !defined(Package['open-iscsi']){
  package { 'open-iscsi' :
    ensure => $package_ensure,
  }
}

cinder_config {
  "DEFAULT/enabled_backends":                value => $backends;
  "${backend_name}/volume_backend_name":     value => $volume_backend_name;
  "${backend_name}/volume_driver":           value => $volume_driver;
  "${backend_name}/san_ip":                  value => $sf_san_ip;
  "${backend_name}/san_login":               value => $sf_san_login;
  "${backend_name}/san_password":            value => $sf_san_password;
  "${backend_name}/sf_emulate_512":          value => $sf_san_emulate_512;
  "${backend_name}/sf_allow_tenant_qos":     value => $sf_allow_tenant_qos;
}


