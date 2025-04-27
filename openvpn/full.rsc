/certificate
add name=OVPNCA common-name="CA" key-size=4096 days-valid=3650 key-usage=crl-sign,key-cert-sign
sign CA ca-crl-host=<your public ip / ddns name>

add name=OVPNServer common-name="SERVER" key-size=4096 days-valid=3650 key-usage=digital-signature,key-encipherment,tls-server
sign SERVER ca="CA"
set SERVER trusted=yes

add name=OVPNClient common-name="CLIENT" key-size=4096 days-valid=3650 key-usage=tls-client
sign CLIENT ca="CA"
set CLIENT trusted=yes

/ip pool
add name="vpn-pool" ranges=10.10.10.2-10.10.10.254

/ppp profile
add name="vpn-users" local-address="10.10.10.1" remote-address=vpn-pool dns-servers=10.10.10.1,1.1.1.1,8.8.8.8

/ppp secret
add name=admin password=admin123 profile=ovpn-profile1 service=ovpn

/interface ovpn-server server
add auth=sha256,sha512 certificate=SERVER cipher=aes128-gcm,aes192-gcm,aes256-gcm \
    default-profile=ovpn-profile1 disabled=no name=ovpn-server1 netmask=20 port=35324 \
    push-routes="10.0.0.0 255.255.255.0 10.0.16.1 10" require-client-certificate=yes \
    tls-version=only-1.2 user-auth-method=mschap2