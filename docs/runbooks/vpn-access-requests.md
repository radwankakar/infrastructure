# VPN Access Policies

## How to request a new VPN account - most secure method

### Person needing access

#### Create a Certificate request (macOS instructions)

1. Keychain Access
1. Certificate Assistent
1. Request a Certificate from a Certificate Authority
1. CN should be `<<USERNAME>>.vpn.eclkc.info`
1. Save to disk

TODO: add instructions for generating CSR on windows

#### Send CSR file to Hosting team

Email the CSR to `<<INSERT EMAIL>>`

#### Export and Transform private key

1. Export the generated private key from Keychain Access as a p12 file.
1. Transform to `.key` file in Terminal: `openssl pkcs12 -in <<FILE_NAME>>.p12 -nodes -out <<FILE_NAME>>.key -nocerts`


### Hosting team

1. Copy CSR file to VPN server
1. Log into VPN server
1. Run `easyrsa import-req <<PATH_TO_CSR>> <<USERNAME>>`
1. Run `easyrsa sign-req client <<USERNAME>>`
1. Send `east.ovpn`, `/etc/openvpn/pki/ca.crt`, and `/etc/openvpn/pki/issued/<<USERNAME>>.crt` to the user
1. Repeat for `us-west-1` if the user should have access to the west region.

`east.ovpn` file:

```
client
dev tun
proto udp
remote vpn.eclkc.info 1194
resolv-retry infinite
nobind
persist-key
persist-tun
comp-lzo
verb 3
ca ca.crt
cert <<USERNAME>>.crt
key <<USERNAME>>.key
cipher AES-256-CBC
```

`west.ovpn` file:

```
client
dev tun
proto udp
remote westvpn.eclkc.info 1194
resolv-retry infinite
nobind
persist-key
persist-tun
comp-lzo
verb 3
ca ca.crt
cert <<USERNAME>>.crt
key <<USERNAME>>.key
cipher AES-256-CBC
```

## How to request a new VPN account - less secure method

### Hosting team

1. Log into VPN server
1. Switch to root
1. `sudo -s`
1. `cd /etc/openvpn/easy-rsa/`
1. `source vars`
1. Create a random passphrase at least 12 characters long. Write down in a temporary place.
1. `./build-key-pass <<USERNAME>>`
1. `cp keys/<<USERNAME>>.* /home/centos`
1. Download `<<USERNAME>>.*` files and send to new VPN user over a secure channel. The `.key` file must be protected.


## How to remove an unneeded VPN account

1. Log into VPN server
1. Run `easyrsa revoke <<USERNAME>>`
1. Run `easyrsa gen-crl`
1. Run `cp /etc/openvpn/pki/crl.pem /etc/openvpn/crl.pem`
1. Run `chmod 644 /etc/openvpn/crl.pem`
