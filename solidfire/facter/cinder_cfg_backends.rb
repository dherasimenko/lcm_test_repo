require 'facter'

cinder_cfg = '/etc/cinder/cinder.conf'
cfg = nil
if File.exist?(cinder_cfg)
  File.open(cinder_cfg).each do |line|
    if line =~ /enabled_backends/
      cfg = line.split('=')[1].strip.delete(' ').split(',').uniq.join(',')
      break
    end
  end
end
Facter.add('cinder_cfg_backends') do
  setcode { cfg }
end
