# Update SSL Cert

## How to update SSL cert for ECLKC Manually

1. Receive a cert package from contact at ACF (potentially via email).

1. Put the cert package in 1Password Vault as a zip file so team can access.

1. Login to AWS and select the appropriate cert in the ACM console.

1. Select Reimport.

1. Enter the Cert body, Cert private key, and Cert chain.

1. To update the cert on Varnish1/Varnish2 `SSH` into the servers.

1. `sudo su` to be able to see files in the ssl dir.

1. `cd /etc/nginx/ssl`

1. Run `cat eclkc-san.crt | openssl x509 -noout -text` to confirm the cert has the same alternative names as you expect:

   ```txt
   Subject: C=US, ST=District of Columbia, L=Washington, O=Administration for Children and Families, CN=eclkc.ohs.acf.hhs.gov
   X509v3 Subject Alternative Name:
                   DNS:eclkc.ohs.acf.hhs.gov, DNS:www.eclkc.ohs.acf.hhs.gov, DNS:secure.eclkc.ohs.acf.hhs.gov
   ```

1. Use `scp` to secure copy the cert/key zip (i.e. `scp key-cert.zip centos@xx.x.x.xx:/etc/nginx/ssl`)

1. Combine the certificate and the chain bundle files. (`cat ServerCertificate.crt ChainBundle.crt > eclkc-san.cert`)

1. Replace `eclkc-san.cert` with the combined cert you just created.

1. Replace `eclkc-san.key` with the private key you have from the ACF contact.

1. Attempt to restart nginx `systemctl restart nginx` and then check the status `systemctl status nginx`. You may need to resolve errors.

## How to check that the private key you have is for the cert

See full documenation for this on [SSL.com](https://www.ssl.com/faqs/how-do-i-confirm-that-a-private-key-matches-a-csr-and-certificate/)

TL;DR: You need to compare the modulus values in the crt vs the key.

```sh
openssl x509 -noout -modulus -in ServerCertificate.crt > cert-mod.txt
openssl rsa -noout -modulus -in ssl.key > privkey-mod.txt
diff cert-mod.txt privkey-mod.txt
```

If diff shows a difference then the key isn't for that cert.

You can also try running an openssl server using the key and the certificate

```sh
openssl s_server -key ssl.key -cert ServerCertificate.crt
```

## Archaeology

In the homedir for the root user on the Ansible management server there is configuration for how these CSRs were originally generated.

There may also be additional resources in `/etc/ssl/certs`.
