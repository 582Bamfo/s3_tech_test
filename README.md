# tech-test
Hi! Firstly, thank you for applying for SCPE (Senior Cloud Platform Engineer) role at Twinkl, we’re really excited to meet you and find out about how your experience can help those who teach!
We’ve come up with a few questions below to help us figure out where your knowledge is, it shouldn’t take too long to complete and will form an integral part of the technical interview.

If you are unsure of anything at all please get in touch with us, we’d be more than happy to elaborate further on any questions you may have.

● In your own words, explain terraform and its primary components.
Terraform is an open-source  (IaC) tool(mainly use for provisioning infra) . It allows  to define, manage, and provision infrastructure resources across various cloud providers and services using HashiCorp configuration language HCL/JSON.

The primary components of Terraform are:
    1.Configuration Files and Synthax: Written in HCL or JSON, these allow to describe the desired state of infrastructure.
    2.Providers: Plugins that interact with specific cloud platforms, SaaS providers, and other APIs. 
    3.Resources: The individual infrastructure components you want to create or manage (e.g.,storage, virtual machines, networks, databases).
    4.State Management: Terraform tracks the current state of your infrastructure and uses it to plan and execute changes.
    5.Modules: Reusable and shareable components of Terraform code for organizing and encapsulating resource configurations.
    6.Block and Arguments

● What are the benefits of using terraform?
    1. Multi-Cloud and Provider Agnostic
    2.Consistency and Reproducibility
    3. Resource Management
    4. Collaboration and Teamwork
    5.Integration with Other Tools


● You’ve been given the task of assisting a team within Twinkl; they are new to AWS and Terraform and need a bit of help getting off the ground. They have 4 services that manage and a multi-account 3 stage environment model (Dev, Stage, Prod). Each service needs an S3 bucket with appropriate permissions and tags. The buckets have differing requirements,
a. Buckets A and B will be used to host a Single Page Application behind cloudfront
b. Bucket C will be used to store objects like images of customer signatures
c. Bucket D will be used as a temporary store for text documents before they’ve
been processed and ingested after 24 hours. After 48 hours the objects are
no longer required.
You can safely assume that the team already has pipelines, access and terraform set up with state buckets, locking etc..
Write some terraform to create infrastructure for the above scenario

● Twinkl has a 20TB MySQL 5.7 database that needs to be migrated from Rackspace to AWS. What steps would you take to move this in a safe and reliable fashion?

A step-by-step approach to perform this migration safely and reliably:

1.Assessment and Planning:
    Evaluate the current database structure, size, and performance characteristics.
    Identify any dependencies or application integrations.
    Choose the target AWS service (likely Amazon RDS for MySQL or Amazon Aurora MySQL-compatible).
    Plan for downtime or determine if zero-downtime migration is possible/required.
2.Set up AWS Environment:
    Create a Virtual Private Cloud (VPC) in AWS.
    Set up necessary security groups and network access controls.
    Provision the target database instance in AWS, ensuring it has sufficient storage and performance capabilities.
3.Establish Connectivity:
    Set up a secure connection between Rackspace and AWS (e.g., VPN or AWS Direct Connect).
    Ensure network routes and firewall rules allow necessary traffic.
4.Perform Initial Data Transfer:
    Use AWS Database Migration Service (DMS) for an initial full load transfer.
    Alternatively, use native MySQL tools like mysqldump for smaller datasets, or physical backups for larger ones.
    For very large datasets, consider using AWS Snowball to physically ship the data.
5.Set Up Replication:
    Configure MySQL replication from the source (Rackspace) to the target (AWS).
    Use AWS DMS for continuous replication to keep the databases in sync during the migration process.
6.Validate Data:
    Perform thorough data validation to ensure all data has been transferred correctly.
    Use checksums, row counts, and sample data comparisons.
7.Application Testing:
    Set up a test environment in AWS.
    Point test applications to the new AWS database.
    Perform comprehensive application testing to ensure functionality and performance.
8.Performance Tuning:
    Monitor the performance of the new database in AWS.
    Adjust instance size, storage type, or other parameters as needed.
9.Cut-over Planning:
    Develop a detailed cut-over plan, including a rollback strategy.
    Communicate with all stakeholders and plan for any necessary downtime
10.Final Cut-over:
    Stop write operations to the source database.
    Ensure replication has caught up completely.
    Update application connection strings to point to the new AWS database.
    Perform final validation.
11.Post-migration Tasks:
    Monitor the new environment closely for any issues.
    Optimize performance based on actual production workload.
    Decommission the old database after a stable period.
12.Documentation and Knowledge Transfer:
    Document the new AWS setup and any changes made during migration.
    Ensure your team is trained on managing the database in the AWS environme


Given the size of your database (20TB), here's a recommended strategy combining these approaches:

A well-planned migration strategy such as:
  Online Migration with Minimal Downtime:
    .Uses replication to keep source and target databases in sync
    .Requires a brief period of downtime during final cutover
    .Pros: Minimizes downtime, allows for extensive testing
    .Cons: More complex, requires careful management of replication lag
    .Best for: Most production systems

Initial Data Transfer:
    Use AWS Snowball for the initial bulk data transfer
    This avoids network bottlenecks and reduces transfer time

Set Up Replication:
    Once the initial data is loaded into AWS, set up MySQL replication or use AWS DMS for continuous replication
    This keeps the source and target databases in sync
Application Testing:
    Point a copy of your application to the new AWS database for testing
    Perform thorough testing while keeping the production system on Rackspace
Incremental Updates:
    Continue replication to transfer any new data that has been added since the initial transfer
Final Cutover:
    Schedule a maintenance window for the final cutover
    Stop writes to the source database
    Ensure replication has fully caught up
    Switch application connections to the new AWS database
    Verify functionality and performance
Post-Migration Validation:
    Perform thorough checks to ensure data integrity and application functionality

This strategy combines the benefits of bulk data transfer (minimizing network impact) with online replication (minimizing downtime). 

Migration tools and services that would be required:
  aws application discovery service - to collect data/inf about the server, migration hub to monitor the migration
  1.AWS Database Migration Service (DMS)
  2.AWS Schema Conversion Tool (SCT)
  3.AWS Snowball or Snowmobile
  4.AWS Direct Connect/AWS Virtual Private Network (VPN)
  5.MySQL Replication
  6.Monitoring and Logging Tools
  7.Data Validation Tools
  8.AWS Command Line Interface (CLI)

● You are just starting to build a landing zone in AWS to allow Twinkl product teams to begin using AWS to host their applications. How can the cloud platform team help Twinkl product work to AWS Good Practice?


First gather and understand the requirement and further leverage on AWS Well-Architected Framework pillars of operational excellence, security, reliability, performance efficiency, and cost optimization.

Implement AWS Control Tower with landing zone:
    Set up multi-account environments -audit,logging,sanddbox, others
    Enforce governance and compliance

Use AWS Organizations:
    Centrally manage multiple AWS accounts
    Apply service control policies (SCPs)

Implement Identity and Access Management (IAM), identity center:
    Use principle of least privilege
    Implement role-based access control
    Group level policies

Logging and Monitoring:
    Enable AWS CloudTrail
    Set up Amazon CloudWatch
    Use AWS Config for resource tracking

Cost Management:
    Implement tagging strategies
    Set up AWS Budgets and Cost Explorer

Security Best Practices:
    Enable AWS GuardDuty for threat detection
    Use AWS Security Hub for security posture management

Infrastructure as Code:
    AWS CloudFormation or Terraform


Continuous Integration/Continuous Deployment (CI/CD):
    CICD tool - Jenkins

Training and Documentation:
    Provide AWS training resources
    Create internal best practice guides