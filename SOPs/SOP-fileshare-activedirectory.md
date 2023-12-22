# Standard Operating Procedure: File Share and Active Directory Management 

## Purpose:
- This Standard Operating Procedure (SOP) outlines the procedures for configuring and managing file shares using Active Directory on a Windows Server, ensuring seamless access for users across domain-attached systems.

## Scope:
- This procedure applies to IT technicians responsible for configuring and maintaining file sharing and Active Directory on Windows Server.

## Responsibilities:
- Implementation: IT Technicians
- Following: All IT technicians involved in file share and Active Directory configuration
- Reviewing: IT Management
- Maintaining and Updating: IT Technicians

## Prerequisites:
- Windows Server configured with Active Directory.

## Procedures:

- File Share Configuration:
  - Identify and document data to be shared, considering user access requirements.

- Active Directory Integration:
  - Utilize Active Directory to create user accounts and groups.
  - Configure security groups in Active Directory for file access permissions.

- Shared Folder Setup:
  - Create shared folders on the Windows Server for collaborative file storage.
  - Assign appropriate permissions to Active Directory security groups for each shared folder.

- Access from Any Domain-Attached System:
  - Configure security groups in Active Directory for each shared folder to enable access from any domain-attached system.

- Monitoring and Access Auditing:
  - Regularly monitor file share usage and access logs.
  - Conduct periodic access audits to ensure adherence to security policies.

- Testing File Share Functionality:
  -  Test file share functionality from various domain-attached systems.
  - Verify seamless access for users across different domains.

### Security Measures:
  - Enforce strong password policies for Active Directory accounts.
  - Regularly review and update access permissions based on user roles.


### Expected Results:
- Successful configuration of file shares and Active Directory, ensuring users can access their files from any domain-attached system. Implementation of security measures guarantees data integrity and confidentiality.

## Definitions:
- Policy: Broad, overarching guidance explaining "why" certain practices are implemented.

## References:
- Microsoft User Guide for Windows Server and Active Directory.
- Code Fellows Github: https://github.com/codefellows/seattle-ops-301d14/blob/main/class-15/SOP-example-template.md

## Revision History:
- Version 1.0 (12-18-2023): Initial document creation by Dominique Bruso.

