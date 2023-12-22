# Standard Operating Procedure: Network Changes and Backup Policies

## Purpose:
- This Standard Operating Procedure (SOP) outlines the procedures for configuring and scheduling automated data backups for disaster recovery using Windows Server within an AWS environment, encompassing both on-site and off-site backup strategies. It also covers network changes and updating procedures.

## Scope:
- This procedure applies to IT technicians responsible for configuring and managing Backup and Disaster Recovery (BDR) on Windows Server hosted within AWS.

## Responsibilities:
- Implementation: IT Technicians
- Following: All IT technicians involved in BDR configuration
- Reviewing: IT Management
- Maintaining and Updating: IT Technicians

## Prerequisites:
- Windows Server configured and operational within AWS.
- Identification of critical data for backup.

## Definitions:
- Policy: Broad, overarching guidance explaining "why" certain practices are implemented.

## Procedure:
- Identification of Critical Data:
  - Identify and document critical data that requires backup for disaster recovery.
- Windows Server Backup Configuration:
  - Utilize the Windows Server Backup feature for data backup.
  - Configure backup settings, including destination and retention policies.
  - Schedule automated on-site backups to occur daily during non-working hours for all systems hosted within AWS.

### Automated Off-site Backup Schedules (AWS S3):
- Define off-site backup schedules based on the criticality of data.
- Utilize AWS S3 for off-site backups.
- Configure Windows Server to automatically replicate backups to AWS S3 during non-working hours.

### Testing BDR Functionality:
- Regularly test the BDR functionality to ensure successful backup and recovery.
- Simulate a disaster recovery scenario to verify data restoration.

### Updates for All Systems:
- Force necessary system and network updates during non-working hours in conjunction with the backup schedule to minimize operational impact.

### Expected Results:
- Successful configuration and scheduling of automated on-site and off-site data backups for disaster recovery within AWS, ensuring the integrity and availability of critical data. On-site backups will occur daily at night during non-working hours, while off-site backups will be replicated to AWS S3 during the same timeframe.

## References:
- Microsoft User Guide: https://learn.microsoft.com/en-us/windows-server/
- Code Fellows Github: https://github.com/codefellows/seattle-ops-301d14/blob/main/class-15/SOP-example-template.md

## Revision History:
- Version 1.0 (12-18-2023): Initial document creation by Dominique Bruso.


