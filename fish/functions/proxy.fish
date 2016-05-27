function proxy --description "Control my vagrant proxy"
  switch $argv
    case on
      set -gx VAGRANT_HTTP_PROXY "http://127.0.0.1:8123"
      set -gx VAGRANT_HTTPS_PROXY "http://127.0.0.1:8123"
      set -gx VAGRANT_FTP_PROXY "http://127.0.0.1:8123/"
      set -gx VAGRANT_NO_PROXY "localhost,127.0.0.1"
    case off
      set -ge VAGRANT_HTTP_PROXY
      set -ge VAGRANT_HTTPS_PROXY
      set -ge VAGRANT_FTP_PROXY
      set -ge VAGRANT_NO_PROXY
    case '*'
      status_message "Use on or off"
  end
end
