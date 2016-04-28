# == Class: murano:db
#
# Configure the Murano database
#
# == Parameters
#
# [*database_connection*]
#   (Optional) Non-sqllite database for murano
#   Defaults to 'mysql://murano:secrete@localhost:3306/murano'
#
# [*database_max_retries*]
#   (Optional) Maximum number of database connection retries during startup.
#   Set to -1 to specify an infinite retry count.
#   Defaults to 10.
#
# [*database_idle_timeout*]
#   (Optional) Timeout before idle SQL connections are reaped.
#   Defaults to 3600.
#
# [*database_retry_interval*]
#   (optional) Interval between retries of opening a database connection.
#   Defaults to 10.
#
# [*database_min_pool_size*]
#   (optional) Minimum number of SQL connections to keep open in a pool.
#   Defaults to 1.
#
# [*database_max_pool_size*]
#   (optional) Maximum number of SQL connections to keep open in a pool.
#   Defaults to 10.
#
# [*database_max_overflow*]
#   (optional) If set, use this value for max_overflow with sqlalchemy.
#   Defaults to 20.
#
class murano::db (
  $database_connection     = 'mysql://murano:secrete@localhost:3306/murano',
  $database_idle_timeout   = 3600,
  $database_min_pool_size  = 1,
  $database_max_pool_size  = 10,
  $database_max_retries    = 10,
  $database_retry_interval = 10,
  $database_max_overflow   = 20,
) {

# NOTE(aderyugin): In order to keep backward compatibility we rely on the pick function
# to use murano::<myparam> if murano::db::<myparam> isn't specified.
  $database_connection_real     = pick($::murano::database_connection, $database_connection)
  $database_idle_timeout_real   = pick($::murano::database_idle_timeout, $database_idle_timeout)
  $database_min_pool_size_real  = pick($::murano::database_min_pool_size, $database_min_pool_size)
  $database_max_pool_size_real  = pick($::murano::database_max_pool_size, $database_max_pool_size)
  $database_max_retries_real    = pick($::murano::database_max_retries, $database_max_retries)
  $database_retry_interval_real = pick($::murano::database_retry_interval, $database_retry_interval)
  $database_max_overflow_real   = pick($::murano::database_max_overflow, $database_max_overflow)

  validate_re($database_connection_real, '(mysql|postgresql):\/\/(\S+:\S+@\S+\/\S+)?')

  case $database_connection_real {
    /^mysql:\/\//: {
      $backend_package = false
      require mysql::bindings
      require mysql::bindings::python
    }
    /^postgresql:\/\//: {
      $backend_package = false
      require postgresql::lib::python
    }
    default: {
      fail('Unsupported db backend configured')
    }
  }

  if $backend_package and !defined(Package[$backend_package]) {
    package {'murano-backend-package':
      ensure => present,
      name   => $backend_package,
      tag    => 'openstack',
    }
  }

  murano_config {
    'database/connection':     value => $database_connection_real;
    'database/idle_timeout':   value => $database_idle_timeout_real;
    'database/min_pool_size':  value => $database_min_pool_size_real;
    'database/max_retries':    value => $database_max_retries_real;
    'database/retry_interval': value => $database_retry_interval_real;
    'database/max_pool_size':  value => $database_max_pool_size_real;
    'database/max_overflow':   value => $database_max_overflow_real;
  }

}
