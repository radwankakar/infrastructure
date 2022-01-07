# VPN Access Policies

## How to request a new VPN account - most secure method

### For the person requesting access

#### Create a Certificate request

##### macOS Instructions

1. Open the Keychain Access utility
1. Click "Keychain Access" in the menu bar
1. Choose "Certificate Assistant" then "Request a Certificate from a Certificate Authority"
1. Enter your email and use the following for Common Name: `<<USERNAME>>.vpn.eclkc.info`
1. You do not need to fill out the CA Email Address
1. Save to disk (you may want to make a new directory to group this file and files from the following steps)

##### Windows Instructions

1. Open the Certmgr utility. This can be done by searching for "cert" in the start menu and selecting "Manage user certificates".
1. Under "Certificates - Current User", right click "Personal" and select "All Tasks" > "Advanced Operations" > "Create Custom Request".
1. A "Certificate Enrollment" wizard will pop up. Click the "Next" button.
1. In the menu "Select Certificate Enrollment Policy", highlight "Proceed without enrollment policy" and click "Next".
1. In the menu "Custom request", in the dropdown for "Template" select "(No template) CNG key" and for "Request format" select the "PKCS #10" radial. Click the "Next" button.
1. In the menu "Certificate Information", expand the "Details" on the "Custom request" and click the "Properties" button.
1. A "Certificate Properties" window will pop up and adjust the following settings:
   - Under the "General" tab, add a "Friendly name" `<<USERNAME>>.vpn.eclkc.info` is suggested but optional.
   - Under the "Subject" tab, in the "Subject name" section, add "Type" "Common name" in the drop down with a "Value" `<<USERNAME>>.vpn.eclkc.info` and click the "Add >" button to move the value into the list on the left.
   - Under the "Private Key" tab, expand the "Key options" section and select "2048" from the dropdown for "Key size" and check the box "Make private key exportable".
1. Click the "Apply" button then the "OK" button. This will close the "Certificate Properties" window.
1. Back in the "Certificate Enrollment" wizard, you'll still see the "Certificate Information" menu. Click "Next".
1. In the menu 'Where do you want to save the offline request?" save to a file of your choosing but select the "File format" "Base 64". Click "Finish" to generate your certificate request.

##### Ubuntu Instructions

Following instructions are based on those from this [webpage](https://vitux.com/how-to-generate-a-certificate-signing-request-csr-on-ubuntu/).

1. Check whether OpenSSL is installed already on your machine. If not, install it.
2. Run the following command replacing 'private key' with a name of your choice
   - ```sudo openssl genrsa -out <private key>.key 2048```
   - This will generate a private key
3. Run the following command
   - ```sudo openssl req -new -key <private key>.key -out <username>_eclkc.csr```
4. In the prompts that appear, enter "." for everything except Common Name. For Common Name, enter `<username>.vpn.eclkc.info` replacing username with your username

   Once completed, you will have a CSR file to send to the hosting team.

#### Send Certificate Signing Request file to Hosting team

Email the Certificate Signing Request file to the hosting team: `<<INSERT EMAIL>>`

They will sign the certificate request and send you a zip file containing the following files:

- `ca.crt`
- `<<username>>.crt`
- `east.ovpn`

#### Export and Transform private key

##### macOs Instructions

1. In Keychain Access, locate "login" on the lefthand side and then select "keys".
1. Locate the keys which share the name of the certificate you just created
1. Right click on the generated private key and select "Export" with the private key name. Export it as a `.p12` file.
1. Select a password for your private key
1. Open the terminal and transform your new `.p12` file to a `.key` file:

```bash
openssl pkcs12 -in <<FILE_NAME>>.p12 -nodes -out <<USER_NAME>>.key -nocerts
```

##### Windows Instructions

1. After receiving the set of files from the hosting team, open the Certmgr utility again.
1. Right click "Personal" again and select "Import..".
1. A "Certificate Import Wizard" window will pop up. Click the "Next" button.
1. In the "File to Import" menu, select the `<<USER_NAME>>.crt` file the headstart hosting team sent. Click the "Next" button.
1. In the "Certificate Store" menu, select the "Place all certificates in the following store" radial and ensure it says "Personal" for "Certificate store". Click the "Next" button.
1. In the "Completing the Certificate Import Wizard" menu, verify the import information and click the "Finish" button.
1. You should see the newly imported certificate under "Personal" > "Certificates".
1. Right click the newly imported certificate and select "All Tasks" > "Export...".
1. A "Certificate Export Wizard" will pop up. On the "Welcome to the Certificate Export Wizard" menu Click the "Next" button.
1. In the "Export Private Key" menu, select "Yes, export the private key". Click the "Next" button.
1. In the "Export File Format" menu, select the "Personal Information Exchange" radial and check "Include all certificates in the certification path if possible" and "Enable certificate privacy". Click the "Next" button.
1. In the "Security" menu, check the "Password" box and input a password of your choosing and then select "AES256-SHA256" in the "Encryption" dropdown. Click the "Next" button.
1. In the "File to Export" menu, select file to export to. Click the "Next" button.
1. In the "Completing the Certificate Export Wizard" menu, validate your configuration choices. Click the "Finish" button.

#### Set up VPN

1. You should receive several files from the Hosting team:
    - `ca.crt`
    - `<<username>>.crt`
    - `east.ovpn`
1. If you haven't received `east.ovpn`, you can create the file: `east.ovpn`.
    - Copy in the text for the files found in the [Hosting team](#hosting-team) instructions
    - Change `<<USERNAME>>` to match the `.crt` files you were sent

#### Log into VPN

##### macOS Instructions

1. Install Tunnelblick with `brew install --cask tunnelblick`
1. The Tunnelblick icon will appear in your top menu. Click "VPN Details"
1. Drag `east.ovpn` and `west.ovpn` into the Configurations bar on the left
1. Connect!

##### Windows Instructions

1. Install the [OpenVPN connect app](https://openvpn.net/client-connect-vpn-for-windows/).
1. In the "Certificates & Tokens" menu select the "PKCS #12" tab.
1. Click "Add Certificate" and select the `.pfx` file you created earlier. Type in the password you chose.
1. For each `.ovpn` file:
    - Remove the lines referencing `<<username>>.crt` and `<<username>>.key` then save.
    - In the OpenVPN connect app, "Import profile" from file and drag the `.ovpn` file.
    - In the configuration menu that pops up, update the profile name if necessary and click "Certificate and Key" then "Assign". Select the certificate profile you just created earlier. Click "Confirm".
    - Click "Connect" to try the connection.

#### Ubuntu Instructions

1. OpenVPN should be included with your Ubuntu server. If not, install it.
2. Open the file with VPN extension that you received from the hosting team in a text editor and remove the lines referencing `<<username>>.crt` and `<<username>>.key` then save.
3. In Settings, go to Network.
4. In VPN section, click the +
5. Select Import from file and select the VPN file you just saved
6. Provide a meaningful name for the connection, i.e. ECLKC VPN
7. In the dialog that then appears, select the `<<username>>.crt` file for the User Certificate and `<<private key>>.key` for the User private key and click Add
8. You can then enable the VPN

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
1. `./sign-req /home/centos/<<USERNAME>>` (note the lack of `.csr` here)
1. `sudo cp /home/centos/<<USERNAME>>.crt /etc/openvpn/easy-rsa/keys/`
1. Send `east.ovpn`, `/etc/openvpn/easy-rsa/keys/ca.crt`, and `/etc/openvpn/easy-rsa/keys/<<USERNAME>>.crt` to the user.
1. Repeat for `us-west-1` if the user should have access to the west region.

`east.ovpn` file:

```txt
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

```txt
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

1. Log into VPN server and change to root user.
1. Run `cd /etc/openvpn/easy-rsa`
1. Run `source vars`
1. Run `easyrsa revoke <<USERNAME>>`
1. Run `easyrsa gen-crl`
1. Run `cp /etc/openvpn/pki/crl.pem /etc/openvpn/crl.pem`
1. Run `chmod 644 /etc/openvpn/crl.pem`
1. Run `openssl ca -gencrl -keyfile keys/ca.key -cert keys/ca.crt -out keys/crl.pem -config ./openssl.cnf` to regenerate the crl file.
