# Understanding Current VPN implementation

## Context

The hosting team does not have necessary background on how the VPN is configured given gaps in documentation, older systems, older configurations. This will bring some clarity to how this is configured and connects with AWS and other teams.

### OpenVPN

After going over the configuration, the __server.conf__ is nearly Identical to the __sample-server.conf__ that is provided by OpenVPN CE. That being said there are some key difference.
If the hosting team wants to follow a HOWTO guide that can be found here: [OpenVPN HOWTO](https://community.openvpn.net/openvpn/wiki/HOWTO)

#### Version

The current Version is __"openVPN2.4.11"__ which was released April 21, 2021 and is the Community edition. At the moment the latest release is __"openVPN2.5.6"__ which was released March 16, 2022. All release notes and versions can be found here: [OpenVPN: Community Downloads](https://openvpn.net/community-downloads/)

#### Logging

Logs are being stored `/var/log/openvpn.log`. The log Structure follows a FIFO model. Logs will be grouped into 7 days. They will then be kept for 4 weeks and well delete itself after.

#### Routing & ports

For the VPN to communicate to all the services in AWS,  the __“server.conf”__ needs to PUSH the Below range of IPs. Each range allows each server to communicate with the VPN.

The server itself sets in the subnet of __10.8.0.0/24__ and all the clients virtual Ip address are stored in an _ipp.txt_ file. This is in case if the Server is restarted or fails.

Port 1194 UDP, Is the the main and default listening port for OpenVPN.

The table below shows all subnets and what servers are connected to those subnets. There are 6 subnets that currently have no servers connected.

|  IP Address  |                                                                                 Service                                                                                  |
| :----------: | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
| 10.0.0.0/24  | EEC, CoachingCompanion, Varnish1 , <br> Varnish2, injuryillness, Tomcart 1, <br> Tomcart 2,LifeboatDB, NAT, Paradise IPD, <br> ZTT-APPS, <br> ZTT-Notifications, ZTT-NAT |
| 10.0.1.0/24  |                                                                         LifeboatDB, LDAP,MariaDB                                                                         |
| 10.0.2.0/24  |                                                                                                                                                                          |
| 10.0.3.0/24  |                                                                                                                                                                          |
| 10.0.4.0/24  |                                                                                                                                                                          |
| 10.0.5.0/24  |                                                                                                                                                                          |
| 10.0.7.0/24  |                                                                                   Solr                                                                                   |
| 10.1.0.0/24  |                                                  ECLKCDev, Stage, DrupalDemo1, DrupalDemo2, DrupalDemo3, Stage1, Stage2                                                  |
| 10.1.1.0/24  |                                                                                 Solr-Dev                                                                                 |
| 10.1.2.0/24  |                                                                           Coachingcompain-dev                                                                            |
| 10.1.4.0/24  |                                                                                                                                                                          |
| 10.1.6.0/24  |                                                                            injuryillness-dev                                                                             |
| 10.1.8.0/24  |                                                        ZTT-APPS-DEV, <br> ZTT-notification-DEV, <br> ZTT-NAT-DEV                                                         |
| 10.1.9.0/24  |                                                                                                                                                                          |
| 10.1.10.0/24 |                                                                             ParadisoLMS-dev                                                                              |
| 10.1.12.0/24 |                                                                                 EEC-Dev                                                                                  |
| 10.2.0.0/24  |                                                             Mail, SFTP, Qualys, Jenkins,VPN, Ansible-nagios                                                              |
| 10.2.1.0/24  |                                                                                 IDS-logs                                                                                 |

#### CA Keys and Cert Structure

Creating a root Cert (CA) is made by using [easy-rsa](https://github.com/OpenVPN/easy-rsa) repo and is kept `/etc/openvpn,easy-rsa/keys`. The hosting team should be able to copy all the keys and certs over to a new server with little effort. although some testing may be needed before deployment.

##### Diffie Hellman

crypto was generated using Diffle Hellman Command
`openssl dhparam -out dh2048.pem 2048`

##### CRL ( Certificate Revocation list)

Located `/etc/openvpn/easy-rsa-keys-crl.pem`. This is where users should be pleased once they no longer need access to the VPN.

#### VPN Requesting

Requesting and giving access methods can be found here: [VPN Access Policies](https://github.com/OHS-Hosting-Infrastructure/infrastructure/blob/main/docs/runbooks/vpn-access-requests.md)

Following the request, Requestors would need SSH Access and those steps can be found here: [how to get SSH Access](https://github.com/OHS-Hosting-Infrastructure/infrastructure/blob/main/docs/runbooks/how-to-get-ssh-access.md)

### AWS Configuration

#### VPC

OpenVPN is located in the Shared-VPC and can communicate to dev and prod because of __server.conf__ it is allowing those IPs trough.

shared VPC is peered with the other VPCs. This allows communication and that security groups are leveraged at individual EC2 level.

##### Security Groups / ports

As with the OpenVPN Server Port 1194 UDP needs to be open and allowed traffic.

The main SG attached to the VPN and all SGs must have an inbound rule to allow SSH from VPN.
