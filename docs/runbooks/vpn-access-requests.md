# VPN Access Policies

## How to request a new VPN account - most secure method

### Person needing access

#### Create a Certificate request (macOS instructions)

1. Open the Keychain Access utility
1. Click "Keychain Access" in the menu bar
1. Choose "Certificate Assistant" then "Request a Certificate from a Certificate Authority"
1. Enter your email and use the following for Common Name: `<<USERNAME>>.vpn.eclkc.info`
1. You do not need to fill out the CA Email Address
1. Save to disk (you may want to make a new directory to group this file and files from the following steps)

TODO: add instructions for generating CSR on windows

#### Send Certificate Signing Request file to Hosting team

Email the Certificate Signing Request file to the hosting team: `<<INSERT EMAIL>>`

#### Export and Transform private key

1. In Keychain Access, locate "login" on the lefthand side and then select "keys".
1. Locate the keys which share the name of the certificate you just created
1. Right click on the generated private key and select "Export" with the private key name. Export it as a `.p12` file.
1. Select a password for your private key
1. Open the terminal and transform your new `.p12` file to a `.key` file:

```bash
openssl pkcs12 -in <<FILE_NAME>>.p12 -nodes -out <<USER_NAME>>.key -nocerts
```

#### Set up VPN

1. You should receive several files from the Hosting team:
    - `ca.crt`
    - `<<username>>.west.crt`
    - `<<username>>.east.crt`
    - `eclkc_centos_id_rsa` (may be sent separately and named differently)
1. Create two files: `east.ovpn` and `west.ovpn`.
    - Copy in the text for the files found in the [Hosting team](#hosting-team) instructions
    - Change `<<USERNAME>>` to match the `.crt` files you were sent

#### Log into VPN (macOS instructions)

1. Install Tunnelblick with `brew install --cask tunnelblick`
1. The Tunnelblick icon will appear in your top menu. Click "VPN Details"
1. Drag `east.ovpn` and `west.ovpn` into the Configurations bar on the left
1. Connect!

#### SSH

1. From the AWS instances dashboard, note the private IP you would like to access
1. Change the file permissions: `chmod 600 eclkc_centos_id_rsa`
1. `ssh -i eclkc_centos_id_rsa centos@<<PRIVATE_IP>>`

### Hosting team

1. Copy CSR file to VPN server
1. Log into VPN server
1. Switch to root: `sudo -s`
1. `cd /etc/openvpn/easy-rsa/`
1. `source vars`
1. `cp /home/centos/<<USERNAME>>.csr keys/`
1. `./sign-req keys/<<USERNAME>>` (note the lack of `.csr` here)
1. Send `east.ovpn`, `/etc/openvpn/easy-rsa/keys/ca.crt`, and `/etc/openvpn/easy-rsa/keys/<<USERNAME>>.crt` to the user.
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
1. Switch to root: `sudo -s`
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
