# Relational Database Management

<!-- Source: https://raw.githubusercontent.com/adr/madr/master/template/template.md -->

- Status: Approved
- Deciders: Eady, Rebecca, Nate
- Date: 2021-08-13

Technical Story: [Evaluate DB Migration](https://github.com/OHS-Hosting-Infrastructure/infrastructure/issues/25)

## Table of Contents

<!-- mdformat-toc start --slug=github --no-anchors --maxlevel=6 --minlevel=1 -->

- [Relational Database Management](#relational-database-management)
  - [Table of Contents](#table-of-contents)
  - [Context and Problem Statement](#context-and-problem-statement)
  - [Decision Drivers](#decision-drivers)
  - [Considered Options](#considered-options)
  - [Decision Outcome](#decision-outcome)
    - [Positive Consequences](#positive-consequences)
    - [Negative Consequences](#negative-consequences)
  - [Pros and Cons of the Options](#pros-and-cons-of-the-options)
    - [Make the current ec2 instance larger](#make-the-current-ec2-instance-larger)
    - [Split the current databases into multiple ec2 instances](#split-the-current-databases-into-multiple-ec2-instances)
    - [Migrate the databases onto RDS (shared tenancy)](#migrate-the-databases-onto-rds-shared-tenancy)
    - [Migrate the databases into their own RDS instances](#migrate-the-databases-into-their-own-rds-instances)

<!-- mdformat-toc end -->

## Context and Problem Statement

The relational databases for many different subcomponents of the ECLKC share the same ec2 instance.
In the last weeks we have learned this resource can get constrained with a massive influx of traffic from one of the subcomponents.
Additionally, the team has been considering migrating the database off ec2 to ease management overhead.

How should we manage relational databases in the OHS hosting environment?

## Decision Drivers

- isolation of data across components
  - Data should be isolated between components and applications as a matter of best practice. If applications need to share data, the applications that manage the data should create an api.
- isolation of compute resources
- ease of management:
  - ease of access, granting granular access etc
  - ease of backups and restores
  - ease of scaling
  - ease of monitoring and alerting integration

## Considered Options

- Make the current ec2 instance larger
- Split the current databases into multiple ec2 instances
- Migrate the databases onto RDS (shared tenancy)
- Migrate the databases into their own RDS instances

## Decision Outcome

Chosen option: "Migrate databases into their own RDS instances", because this gives us isolation of data and resources.
This also allows the OHS Hosting team to leverage AWS features to better manage and monitor the database.

### Positive Consequences <!-- optional -->

- we get data and resource isolation.
- we get instrumentation into Cloudwatch automatically.
- we get free minor patches.
- we get easier read replicas or new instances.
- we get easier backups/restores.
- we get the ability to more easily scale the database.

### Negative Consequences <!-- optional -->

- we'll need to watch the resources to ensure we can purchase and manage resources or reservations.
- we'll need to better manage the backups to ensure we only keep what we need.

## Pros and Cons of the Options <!-- optional -->

### Make the current ec2 instance larger

Make the instance bigger, faster, stronger!

- Good, because OHSH team wouldn't really have to touch the data directly.
- Good, because devs won't have to change any configuration.
- Bad, because does not provide resource isolation.
- Bad, because does not provide data isolation.
- Bad, because this is harder to restore and manage backups.
- Bad, because we would need to instrument connection counts and fix query logging then integrate into Cloudwatch.
- Bad, because to stand up a read replica or a new db will need to be automated anyways.

### Split the current databases into multiple ec2 instances

More instances!

- Good, because we get data and resource isolation.
- Good, because it'll be easier to grant more granular access.
- Bad, because we have to change configuration for devs anyways.
- Bad, because this is harder to restore and manage backups.
- Bad, because we would need to instrument connection counts and fix query logging then integrate into Cloudwatch.
- Bad, because it would still be hard to stand up a new read replica or db.

### Migrate the databases onto RDS (shared tenancy)

Let's just put it on RDS!

- Good, because we get instrumentation into Cloudwatch automatically.
- Good, because we get free minor patches.
- Good, because we get easier read replicas or new instances.
- Good, because we get easier backups/restores.
- Good, because we get the ability to more easily scale the database.
- Bad, because does not provide data or resource isolation.
- Bad, because does not set us up to treat components as separate services.

### Migrate the databases into their own RDS instances

Split the databases into their own instances on RDS.

- Good, because we get data and resource isolation.
- Good, because we get instrumentation into Cloudwatch automatically.
- Good, because we get free minor patches.
- Good, because we get easier read replicas or new instances.
- Good, because we get easier backups/restores.
- Good, because we get the ability to more easily scale the database.
- Bad, because we'll need to watch the resources to ensure we can purchase and manage resources or reservations.
- Bad, because we'll need to better manage the backups to ensure we only keep what we need.
