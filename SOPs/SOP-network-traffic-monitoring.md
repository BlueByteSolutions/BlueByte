# Standard Operating Procedure: Network Traffic Monitoring

## Purpose:
- This SOP outlines procedures for managing critical network alerts and guiding the Network Operations team in identifying, analyzing, and resolving issues. It also emphasizes documenting incidents and solutions for future reference.

## Scope:
- This procedure applies to the Network Operations team, covering the identification, analysis, and resolution of critical network alerts.

## Responsibilities:
- The team member overseeing network operations is accountable for implementing, following, reviewing, maintaining, and updating this policy. The IT manager is responsible for regularly checking the Event Viewer and Performance Monitor, which are configured to notify of critical events.

## Prerequisites:
- Access to the alert monitoring system.
- Familiarity with network monitoring tools, including Wireshark.

## Procedure:
Alert Identification:
- Continuously monitor the alert dashboard for critical network alerts.
- Prioritize alerts based on severity and potential impact on network performance.

Root Cause Analysis:
- Investigate identified alerts to determine the underlying cause.
- Utilize network monitoring tools, such as Wireshark, to capture and analyze relevant network traffic.
- If a real-time networking issue is identified through Event Viewer or Performance Monitor alerts, further investigate with Wireshark.
- Examine packet-level details to gain insights into the nature of the issue.

Corrective Actions:
- Implement corrective actions based on the root cause analysis.
- Take necessary steps to promptly resolve the identified network issue.

Incident Documentation:
- Document incident details, including alert information and root cause analysis.
- Include findings from Wireshark analysis in the incident report:
  - Incident Report - [Date and Time]
  - Alert Information: [Provide details on the triggered alert.]
  - Root Cause Analysis: [Describe the findings from the analysis.]
  - Implemented Solutions: [Specify the actions taken to resolve the issue.]
  - Wireshark Findings: [Include relevant insights gained from Wireshark analysis.]
    
## References:
- Microsoft User Guide: https://learn.microsoft.com/en-us/windows-server/
- Wireshark User Guide: https://www.wireshark.org/docs/wsug_html_chunked/
- Code Fellows Github: https://github.com/codefellows/seattle-ops-301d14/blob/main/class-15/SOP-example-template.md

## Definitions:
- Policy: Provides broad, overarching guidance on the "why" of this procedure.
- SOP: Specifies "what, when, why," and there could be multiple SOPs to support a specific policy.
- Work Instructions: Offer in-depth, step-by-step directions for a particular task.

## Revision History:
- Version 1.0 (12-18-2023): Initial document creation by Dominique Bruso
