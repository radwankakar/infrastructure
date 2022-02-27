# How to Determine Who Gets Which SSH Access

## Context

When providing VPN and SSH access to the different application developers based on request, it is helpful to have a clear understanding of who should have what permission where so that we can consistently grant those permissions when needed.

Currently, we grant SSH access to the engineers who ask for it for different machines. We want to formalize our process so we always use the same rationale to determine who gets what access. This decision tree should help folks determine whether requesters get SSH access to a machine.

## Who Gets Access

### Prerequisites

1. Has the person been granted VPN access? Refer to our [VPN access doc](https://github.com/OHS-Hosting-Infrastructure/infrastructure/blob/9b5029af6606b355bd671e485dc7e1023241cbb4/docs/how-we-work/vpn-access-list.md).
   - If so, continue.
   - If not, determine whether they should be granted VPN access.

### To determine access

1. What [role in terms of the access control](https://github.com/OHS-Hosting-Infrastructure/infrastructure/blob/9b5029af6606b355bd671e485dc7e1023241cbb4/docs/adr/0004-access-controls.md) does the requester have?

   - If an Auditor/Business role, do **NOT** grant access.
   - If an Infrasec/Admin role, do grant access.
   - If an Engineer role, continue on decision tree.

1. Are they requesting SSH access to an application server that is relevant to their team?

   - If not, do **NOT** grant access.
   - If so, continue on decision tree.

1. Does the server have sensitive information (PII) on it (the MariaDB server or the LDAP server)?

   - If so, do **NOT** grant access without OHS Stakeholder team discussion.
   - If not, continue with decision tree.

1. Are they requesting access to a non-prod machine?

   - If not (i.e. requesting access to prod), do **NOT** grant access.
   - If so, grant them access to the machine as the app user and notify OHS Stakeholders [as described in the System Security Plan](https://app.box.com/file/818459519857?s=vx32bq6mpns73cq2mbmrdkoj1qjhnfpq).

   | Server            | User        | Team  |
   | ----------------- | ----------- | ----- |
   | Varnish1          | drupal      | HSICC |
   | Varnish2          | drupal      | HSICC |
   | CoachingCompanion | cc          | CC    |
   | ParadisoLMS-Dev   | zerotothree | IPD   |
   | Tomcat1           | tomcat      | HSICC |
   | Tomcat2           | tomcat      | HSICC |

**Note**: Sam Nevares on the HSICC team has permissions similar to the Truss infrasec team because he participates in the on-call rotation.
