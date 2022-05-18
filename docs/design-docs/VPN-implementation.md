# [VPN Implementation](https://ocio-jira.acf.hhs.gov/browse/OHSH-556)

Design doc
05/09/2022

## Context

Now that we understand how the current [OpenVPN](https://github.com/OHS-Hosting-Infrastructure/infrastructure/blob/main/docs/research/vpn-implentation.md) is configured. We are going to recreate it using [OpenVPN Access Server](https://openvpn.net/access-server/), with a focus on infrastructure and configuration as code.

We plan to implement infrastructure and configuration as code with our standard tooling:

- Ansible (server configuration management)
- Terraform (AWS infrastructure management)

We plan to migrate from OpenVPN Community Edition to OpenVPN Access Server. See [ADR](https://github.com/OHS-Hosting-Infrastructure/infrastructure/blob/main/docs/adr/0013-compare-vpn-edition.md) for details.

When we deploy the new VPN, we want to keep the old one up in parallel while we are migrating.

### Core Functionality Requirements

Technical Requirements

- 2FA / MFA required for users
- ability to sign CSR and return CRT to users (should double check this)
- admins have separate users and ssh keys to access the system

Process Requirements

- deployment plan
- maintenance plan
- disaster recovery plan
- user administration documentation (onboarding/offboarding)

## Architecture

### VPC / Region

We are going to use the existing `Shared VPC` for deployment of the new VPN in `us-east-1`. The existing VPN already resides in that VPC. While there is a VPN instance in `us-west-1`, we plan to leave that as the Community Edition until we figure out what we're doing with `us-west-1` more generally.

### SecurityGroups

We also plan to use the existing SecurityGroup (sgr-0229df23014d01c69), because it is currently deployed throughout the AWS environment already.

below is a chart that shows what ports are currently in use by the SG and what ports are needed in OpenVPN Access Service.

|   Port   |        Description         |     Currently in use     |
| :------: | :------------------------: | :----------------------: |
|  TCP 22  |            SSH             |    :heavy_check_mark:    |
| TCP 943  |   User web portal access   | :heavy_multiplication_x: |
| TCP 945  | Cluster control web portal | :heavy_multiplication_x: |
| TCP 443  |           HTTPS            |    :heavy_check_mark:    |
| UDP 1194 |      OpenVPN service       |    :heavy_check_mark:    |

We will want to create an Elastic IP address for our new OpenVPN instance and have the SGs that reference the old VPN allow our new elastic IP.

Once ready for deployment the SGs will need to be both updated from the console and in Terraform.

### EC2 / Route53

Although OpenVPN as a whole is not compatible with being behind a load balancer we will attempt to place the two public facing web portals behind. This will be similar to [moving Jenkins behind VPN](https://github.com/OHS-Hosting-Infrastructure/infrastructure/blob/main/docs/design-docs/moving-jenkins-behind-vpn.md) but we will know for sure once testing begins.

We will be deploying:

- a new ec2 instance using the OpenVPN AS AMI from AWS Marketplace
  - should make sure we use the latest version available
  - need to determine the instance type we want to deploy - currently an m3.medium
  - need to confirm if we can deploy with an EBS volume (we would like to)
- will need to assign a new elastic IP address to the ec2 instance
- will need a new route53 entry for the VPN

## Process

1. Initial deployment will be tested / developed in sandbox account due to access restrictions.
1. Development of Terraform configuration matching architecture
   - evaluate if the TF should be turned into a module
   - testing
   - documentation
1. Development of server configuration
1. Development of Ansible role for server configuration
   - testing
   - documentation
1. Development of user configuration (including 2FA)
   - evaluate migrating existing user certs vs. clean-slate migration
1. Development of Ansible role for user configuration
   - testing
   - documentation
1. End-to-end deployment test (testing TF, Ansible, and any manual config steps documented)
1. Port work to OHS accounts (TF and Ansible code)
1. Deploy new VPN to OHS AWS account
1. Update SecurityGroups to allow new VPN
   - do not remove/edit existing VPN rule (since both will run in parallel)
1. Testing by Hosting team
1. User migration
   - update [documentation](https://github.com/OHS-Hosting-Infrastructure/infrastructure/blob/main/docs/runbooks/vpn-access-requests.md) to reflect changes
   - Create a user migration documentation
1. Decommissioning old VPN
   - shutdown ec2 instance
   - clean-up old VPN SG rule
   - remove ec2, eip, and route53 resources in AWS

## Reference

- [Setting up OpenVPN Access Server](https://aws.amazon.com/blogs/awsmarketplace/setting-up-openvpn-access-server-in-amazon-vpc/)
- [OpenVPN:HowTO](https://openvpn.net/vpn-server-resources/amazon-web-services-ec2-tiered-appliance-quick-start-guide/)
- [Using Terraform to deploy OpenVPN](https://lekansogunle.medium.com/using-terraform-iac-to-deploy-your-free-vpn-server-on-aws-933204316980)
- [TOTP](https://openvpn.net/vpn-server-resources/google-authenticator-multi-factor-authentication/)
- [AWS deployment guide](https://openvpn.net/wp-content/uploads/Access-Server-AWS-Deployment-Guide.pdf)
