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
    _checksite_status_message "Any SSL error messsages at the top!"
    # This is works because of the ^&1 AFTER the end

    _checksite_status_message "who is it?"
    whois $argv

    _checksite_status_message "Dig Google"
    dig @8.8.8.8 $argv +dnssec

    _checksite_status_message "Dig NS1"
    dig @ns1.dnsimple.com $argv +dnssec

    _checksite_status_message "Dig trace"
    dig $argv +trace

    _checksite_status_message "HTTP"
    curl -ILvsS --stderr - http://$argv/
    _checksite_status_message "HTTPS"
    curl -ILvsS --stderr - https://$argv/

    _checksite_status_message "Certificate Check"
    echo QUIT | openssl s_client -servername $argv -showcerts -connect $argv:443 | openssl x509 -text

    functions -e _checksite_status_message
  end ^&1 | less
end
