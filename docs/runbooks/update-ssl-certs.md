# Update SSL Cert

## How to update SSL cert for ECLKC Manually

1. Receive a cert package from contact at ACF (potentially via email).
1. Put the cert package in 1Password Vault as a zip file so team can access.
1. Login to AWS and select the appropriate cert in the ACM console.
1. Select Reimport.
1. Enter the Cert body and Cert private key.
1. `SSH` into the Varnish1 and Varnish2 servers.
1. `sudo su` to be able to see files in the ssl dir.
1. `cd /etc/nginx/ssl`
1. Run `cat eclkc-san.crt | openssl x509 -noout -text` to confirm the cert has the same alternative names as you expect:
    ```
    Subject: C=US, ST=District of Columbia, L=Washington, O=Administration for Children and Families, CN=eclkc.ohs.acf.hhs.gov
    X509v3 Subject Alternative Name: 
                    DNS:eclkc.ohs.acf.hhs.gov, DNS:www.eclkc.ohs.acf.hhs.gov, DNS:secure.eclkc.ohs.acf.hhs.gov
    ```
1. Use `scp` to secure copy the cert/key zip (i.e. `scp key-cert.zip centos@xx.x.x.xx:/etc/nginx/ssl`)
1. Replace `eclkc-san.cert` with the cert you have from the ACF contact.
1. Replace `eclkc-san.key` with the private key you have from the ACF contact.
1. `SSH` into mariadb server.
