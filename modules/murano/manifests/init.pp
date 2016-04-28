# == Class: murano
#
#  murano base package & configuration
#
# === Parameters
#
# [*package_ensure*]
#  (Optional) Ensure state for package
#  Defaults to 'present'
#
# [*verbose*]
#  (Optional) Should the service log verbose messages
#  Defaults to false
#
# [*debug*]
#  (Optional) Should the service log debug messages
#  Defaults to false
#
# [*use_syslog*]
#  (Optional) Should the service use Syslog
#  Defaults to false
#
# [*use_stderr*]
#  (Optional) Should the service log to stderr
#  Defaults to false
#
# [*log_facility*]
#  (Optional) Syslog facility to recieve logs
#  Defaults to 'LOG_LOCAL0'
#
# [*log_dir*]
#  (Optional) Directory to store logs
#  Defaults to '/var/log/murano'
#
# [*data_dir*]
#  (Optional) Directory to store data
#  Defaults to '/var/cache/murano'
#
# [*notification_driver*]
#  (Optional) Notification driver to use
#  Defaults to 'messagingv2'
#
# [*rabbit_os_host*]
#  (Optional) Host for openstack rabbit server
#  Defaults to '127.0.0.1'
#
# [*rabbit_os_port*]
#  (Optional) Port for openstack rabbit server
#  Defaults to '5672'
#
# [*rabbit_os_user*]
#  (Optional) Username for openstack rabbit server
#  Defaults to 'guest'
#
# [*rabbit_os_password*]
#  (Optional) Password for openstack rabbit server
#  Defaults to 'guest'
#
# [*rabbit_ha_queues*]
#  (Optional) Should murano api use ha queues
#  Defaults to false
#
# [*rabbit_own_host*]
#  (Optional) Host for murano rabbit server
#  Defaults to '127.0.0.1'
#
# [*rabbit_own_port*]
#  (Optional) Port for murano rabbit server
#  Defaults to '5672'
#
# [*rabbit_own_user*]
#  (Optional) Username for murano rabbit server
#  Defaults to 'guest'
#
# [*rabbit_own_password*]
#  (Optional) Password for murano rabbit server
#  Defaults to 'guest'
#
# [*rabbit_own_vhost*]
#  (Optional) Virtual host for murano rabbit server
#  Defaults to 'murano'
#
# [*service_host*]
#  (Optional) Host for murano to listen on
#  Defaults to '0.0.0.0'
#
# [*service_port*]
#  (Optional) Port for murano to listen on
#  Defaults to 8082
#
# [*use_ssl*]
#   (optional) Enable SSL on the API server
#   Defaults to false
#
# [*cert_file*]
#   (optinal) Certificate file to use when starting API server securely
#   Defaults to undef
#
# [*key_file*]
#   (optional) Private key file to use when starting API server securely
#   Defaults to undef
#
# [*ca_file*]
#   (optional) CA certificate file to use to verify connecting clients
#   Defaults to undef
#
# [*use_neutron*]
#  (Optional) Whether to use neutron
#  Defaults to false
#
# [*external_network*]
#  (Optional) Name of the external Neutron network which will be used
#  Defaults to undef
#
# [*default_router*]
#  (Optional) Router name for Murano networks
#  Defaults to 'murano-default-router'
#
# [*default_nameservers*]
#  (Optional) Domain Name Servers to use in Murano networks
#  Defaults to '[]'
#
# [*use_trusts*]
#  (Optional) Whether to use trust token instead of user token
#  Defaults to false
#
# == database configuration options
#
# [*database_connection*]
#   (Optional) Database URI for murano
#   Defaults to undef.
#
# [*database_max_retries*]
#   (Optional) Maximum number of database connection retries during startup.
#   Set to -1 to specify an infinite retry count.
#   Defaults to undef.
#
# [*database_idle_timeout*]
#   (Optional) Timeout before idle SQL connections are reaped.
#   Defaults to undef.
#
# [*database_retry_interval*]
#   (optional) Interval between retries of opening a database connection.
#   Defaults to undef.
#
# [*database_min_pool_size*]
#   (optional) Minimum number of SQL connections to keep open in a pool.
#   Defaults to undef.
#
# [*database_max_pool_size*]
#   (optional) Maximum number of SQL connections to keep open in a pool.
#   Defaults to undef.
#
# [*database_max_overflow*]
#   (optional) If set, use this value for max_overflow with sqlalchemy.
#   Defaults to undef.
#
# [*sync_db*]
#   (Optional) Enable dbsync
#   Defaults to true.
#
# == keystone authentication options
#
# [*admin_user*]
#  (Optional) Username for murano credentials
#  Defaults to 'admin'
#
# [*admin_password*]
#  (Required) Password for murano credentials
#  Defaults to false
#
# [*admin_tenant_name*]
#  (Optional) Tenant for admin_username
#  Defaults to 'admin'
#
# [*auth_uri*]
#  (Optional) Public identity endpoint
#  Defaults to 'http://127.0.0.1:5000/v2.0/'
#
# [*identity_uri*]
#  (Optional) Admin identity endpoint
#  Defaults to 'http://127.0.0.1:35357/'#
#
# [*signing_dir*]
#  (Optional) Directory used to cache files related to PKI tokens
#  Defaults to '/tmp/keystone-signing-muranoapi'
#
class murano(
  $admin_password,
  $package_ensure          = 'present',
  $verbose                 = false,
  $debug                   = false,
  $use_syslog              = false,
  $use_stderr              = false,
  $log_facility            = 'LOG_LOCAL0',
  $log_dir                 = '/var/log/murano',
  $data_dir                = '/var/cache/murano',
  $notification_driver     = 'messagingv2',
  $rabbit_os_host          = '127.0.0.1',
  $rabbit_os_port          = '5672',
  $rabbit_os_user          = 'guest',
  $rabbit_os_password      = 'guest',
  $rabbit_ha_queues        = false,
  $rabbit_own_host         = '127.0.0.1',
  $rabbit_own_port         = '5672',
  $rabbit_own_user         = 'guest',
  $rabbit_own_password     = 'guest',
  $rabbit_own_vhost        = 'murano',
  $service_host            = '127.0.0.1',
  $service_port            = '8082',
  $use_ssl                 = false,
  $cert_file               = undef,
  $key_file                = undef,
  $ca_file                 = undef,
  $use_neutron             = false,
  $external_network        = $::murano::params::default_external_network,
  $default_router          = 'murano-default-router',
  $default_nameservers     = '[]',
  $use_trusts              = false,
  $database_connection     = undef,
  $database_max_retries    = undef,
  $database_idle_timeout   = undef,
  $database_min_pool_size  = undef,
  $database_max_pool_size  = undef,
  $database_max_retries    = undef,
  $database_retry_interval = undef,
  $database_max_overflow   = undef,
  $sync_db                 = true,
  $admin_user              = 'admin',
  $admin_tenant_name       = 'admin',
  $auth_uri                = 'http://127.0.0.1:5000/v2.0/',
  $identity_uri            = 'http://127.0.0.1:35357/',
  $signing_dir             = '/tmp/keystone-signing-muranoapi',
) {

  include ::murano::params
  include ::murano::policy
  include ::murano::db

  validate_string($admin_password)

  package { 'murano-common':
    ensure => $package_ensure,
    name   => $::murano::params::common_package_name,
    tag    => ['openstack', 'murano-package'],
  }

  $service_protocol = $use_ssl ? {
    true    => 'https',
    default => 'http',
  }

  murano_config {
    'DEFAULT/use_syslog' : value => $use_syslog;
  }

  if $use_syslog {
    murano_config {
      'DEFAULT/use_syslog_rfc_format' : value => true;
      'DEFAULT/syslog_log_facility':    value => $log_facility;
    }
  }

  if $use_neutron {
    murano_config {
      'networking/external_network' : value => $external_network;
      'networking/router_name' :      value => $default_router;
      'networking/create_router' :    value => true;
    }
  } else {
    murano_config {
      'networking/external_network' : ensure => absent;
    }
  }

  if $use_ssl {
    if !$ca_file {
      fail('The ca_file parameter is required when use_ssl is set to true')
    }
    if !$cert_file {
      fail('The cert_file parameter is required when use_ssl is set to true')
    }
    if !$key_file {
      fail('The key_file parameter is required when use_ssl is set to true')
    }
    murano_config {
      'ssl/cert_file' : value => $cert_file;
      'ssl/key_file' :  value => $key_file;
      'ssl/ca_file' :   value => $ca_file;
    }
  } else {
    murano_config {
      'ssl/cert_file' : ensure => absent;
      'ssl/key_file' :  ensure => absent;
      'ssl/ca_file' :   ensure => absent;
    }
  }

  murano_config {
    'DEFAULT/verbose' :                        value => $verbose;
    'DEFAULT/debug' :                          value => $debug;
    'DEFAULT/use_stderr' :                     value => $use_stderr;
    'DEFAULT/log_dir' :                        value => $log_dir;
    'DEFAULT/notification_driver' :            value => $notification_driver;

    'murano/url' :                             value => "${service_protocol}://${service_host}:${service_port}";

    'engine/use_trusts' :                      value => $use_trusts;

    'oslo_messaging_rabbit/rabbit_userid' :    value => $rabbit_os_user;
    'oslo_messaging_rabbit/rabbit_password' :  value => $rabbit_os_password;
    'oslo_messaging_rabbit/rabbit_hosts' :     value => $rabbit_os_host;
    'oslo_messaging_rabbit/rabbit_port' :      value => $rabbit_os_port;
    'oslo_messaging_rabbit/rabbit_ha_queues' : value => $rabbit_ha_queues;

    'rabbitmq/login' :                         value => $rabbit_own_user;
    'rabbitmq/password' :                      value => $rabbit_own_password;
    'rabbitmq/host' :                          value => $rabbit_own_host;
    'rabbitmq/port' :                          value => $rabbit_own_port;
    'rabbitmq/virtual_host' :                  value => $rabbit_own_vhost;

    'keystone_authtoken/auth_uri' :          value => $auth_uri;
    'keystone_authtoken/admin_user' :        value => $admin_user;
    'keystone_authtoken/admin_tenant_name' : value => $admin_tenant_name;
    'keystone_authtoken/signing_dir' :       value => $signing_dir;
    'keystone_authtoken/identity_uri' :      value => $identity_uri;
    'keystone_authtoken/admin_password' :    value => $admin_password;

    'networking/default_dns':                value => $default_nameservers;
  }

  if $sync_db {
    include ::murano::db::sync
  }
}
