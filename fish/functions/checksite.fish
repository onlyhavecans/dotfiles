function checksite
  if not test 1 -eq (count $argv)
    echo "Only pass one domain name"
    return 1
  end

  function _checksite_status_message
    echo " "
    echo "~~ $argv"
  end

  begin
    _checksite_status_message "who is it?"
    whois $argv

    _checksite_status_message "Dig Google"
    dig @8.8.8.8 $argv +noall +answer +dnssec

    _checksite_status_message "Dig NS1"
    dig @ns1.dnsimple.com $argv +noall +answer +dnssec

    _checksite_status_message "HTTP"
    curl -ILvsS --stderr - http://$argv/
    _checksite_status_message "HTTPS"
    curl -ILvsS --stderr - https://$argv/

    functions -e _checksite_status_message
  end | less
end
