[[ $(curl -s "https://www.duckdns.org/update/{{ duckdns_subdomain }}/{{ duckdns_token }}") == 'OK' ]] || echo "DuckDNS Update FAILED"
