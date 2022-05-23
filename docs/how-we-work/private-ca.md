## Private Certificate Authority (CA) Background and Creation

The OHS private CA was created using the [ACM Private Certificate Authority](https://docs.aws.amazon.com/acm-pca/latest/userguide/PcaWelcome.html) Terraform [module](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acmpca_certificate_authority). Note that as stated in the Terraform module, the manual step of installing the root CA certificate from the console is required to change the status of the CA from pending to active. This is a one time action that only has to be done when creating a new Private CA.

## Creating Certificate With Private CA

Certificates can be created manually via the ACM console but the preference is to create certificates via terraform when possible. An example of a certificate created with our private CA via terraform is below:

```
resource "aws_acm_certificate" "cert_name" {
  domain_name               = "example.domain.com"
  certificate_authority_arn = aws_acmpca_certificate_authority.private_ca.arn
  lifecycle {
    create_before_destroy = true
  }
}
```

## Importing Private CA For Use in Terraform

Terraform supports importing a aws_acmpca_certificate_authority resource as a datatype by its arn, if needed to be used in a different terraform stack. An example of this is below:

```
data "aws_acmpca_certificate_authority" "example" {
  arn = "arn:aws:acm-pca:us-east-1:123456789012:certificate-authority12345678-012"
}
```

More information about importing a private CA via terraform can be found [here](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acmpca_certificate_authority).

## Using a Private CA Cert

A certificate can be referenced / used with it's arn:

```
certificate_arn   = aws_acm_certificate.cert_name.arn
```

## Resolving Cert Errors

Without any modifications to your local machine "trust" settings, navigating to a website that uses a certificate signed by the OHS Private CA will result in certificate errors. To resolve these, you must download and save a copy of the root CA cert on your local machine in your home directory as  `ohs-private-ca-cert.pem`, and "trust" it. The root CA certificate can be found on AWS in the ACM console.

For Mac OS navigate to your home directory and run the following:

```
sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ohs-private-ca-cert.pem
```

For Windows navigate to your home directory and run the following:

```
certutil -addstore -f "ROOT" new-root-certificate.crt
```

If desired, after running these commands, you can remove the certificate from your local machine.

For more information about resolving cert errors view the following resources and documentation:

- [add-trusted-cert man page](https://www.unix.com/man-page/mojave/1/security)
- [certutil documentation](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/certutil)

## Note for Firefox users

There is one more necessary step to access sites with certificates from our private CA without certificate errors for Mozilla Firefox users. The following [article](https://support.mozilla.org/en-US/kb/setting-certificate-authorities-firefox) has more information.

Specifically, the below steps will be need to be completed:

1. Enter “about:config” in the address bar and continue to the list of preferences.
1. Set the preference "security.enterprise_roots.enabled" to true.
1. Restart Firefox.
