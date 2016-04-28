# == Resource: murano::application
#
#  murano application importer
#
# === Parameters
#
# [*package_name*]
#  (Optional) Application package name
#  Defaults to $title
#
# [*package_category*]
#  (Optional) Application category
#  Defaults to 'undef'
#
define murano::application (
  $package_name     = $title,
  $package_category = undef,
) {

  $package_path="/var/cache/murano/meta/${package_name}.zip"

  murano_application { $package_name:
    ensure       => 'present',
    package_path => $package_path,
    category     => $package_category,
  }
}
