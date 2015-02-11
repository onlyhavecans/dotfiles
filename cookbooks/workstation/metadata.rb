name             'workstation'
maintainer       'tBunnyMan'
maintainer_email 'WagThatTail@Me.com'
license          'BSD'
description      'Installs/Configures workstation'
long_description 'Installs/Configures workstation'
version          '2.1.0'

%w(mac_os_x mac_os_x_server ubuntu).each do |os|
  supports os
end

depends 'homebrew'
