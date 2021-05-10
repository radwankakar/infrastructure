# VPN Access Policies

## How to request a new VPN account

### Person needing access

#### Create a Certificate request

1. Keychain Access
1. Certificate Assistent
1. Request a Certificate from a Certificate Authority
1. CN should be `<<USERNAME>>.vpn.eclkc.info`
1. Save to disk

TODO: add instructions for generating CSR on windows

#### Send CSR file to Hosting team

Email the CSR to <<INSERT EMAIL>>

#### Export and Transform private key

1. Export the generated private key from Keychain access as a p12 file.
1. Transform to `.key` file: `openssl pkcs12 -in <<FILE_NAME>>.p12 -nodes -out <<FILE_NAME>>.key -nocerts`

TODO: try to get things working with the p12 file instead of having to transform it

### Hosting team

1. Copy CSR file to VPN server
1. Log into VPN server
1. Run `easyrsa import-req <<PATH_TO_CSR>> <<USERNAME>>`
1. Run `easyrsa sign-req client <<USERNAME>>`
1. Send `/etc/openvpn/pki/ca.crt` and `/etc/openvpn/pki/issued/<<USERNAME>>.crt` to the user

TODO: create template OVPN config file to also send.

## How to remove an unneeded VPN account

1. Log into VPN server
1. Run `easyrsa revoke <<USERNAME>>`
1. Run `easyrsa gen-crl`
1. Run `cp /etc/openvpn/pki/crl.pem /etc/openvpn/crl.pem`
1. Run `chmod 644 /etc/openvpn/crl.pem`
