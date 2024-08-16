# Postmortem: Outage in SecureSide (Neighborhood Watch Web App)

## Issue Summary

- **Duration**: The outage lasted for 2 hours, from 10:00 AM to 12:00 PM EAT on August 15th, 2024.
- **Impact**: During this period, 80% of users were unable to access the neighborhood messaging feature in the Neighborhood Watch web application. Users experienced slow load times, with some experiencing complete timeouts when trying to send or receive messages. Approximately 50% of the messages sent during this time were delayed or lost.
- **Root Cause**: The root cause was a misconfiguration on the load balancer that failed to distribute traffic evenly across the backend servers, leading to server overloading and the eventual failure of the messaging service.

## Timeline

- **10:00 AM**: Issue detected via Datadog alert indicating a spike in response times and error rates for the messaging service.
- **10:05 AM**: The engineering team began investigating the issue, initially suspecting a database bottleneck due to high query times.
- **10:15 AM**: A misleading path was taken as the database was optimized, but that had no effect.
- **10:30 AM**: The issue was escalated to the DevOps team after database optimizations failed to resolve the problem.
- **10:45 AM**: The DevOps team identified the load balancer was routing all traffic to a single backend server rather than distributing it across multiple servers.
- **11:00 AM**: A temporary fix was applied by manually redistributing the traffic to relieve the overloaded server.
- **11:30 AM**: A permanent fix was implemented to correct the load balancer configuration.
- **12:00 PM**: The system was fully operational, and the incident was declared resolved.

## Root Cause and Resolution

- **Root Cause**: The load balancer was incorrectly configured after a recent update. Instead of balancing traffic evenly across the three backend servers, it funneled all incoming requests to a single server. This server became overwhelmed, leading to high response times, dropped connections, and a partial outage of the messaging service.
- **Resolution**: As part of the resolution, the DevOps team first applied a temporary fix by manually distributing the traffic across the available servers. A permanent fix involved correcting the load balancer configuration so that it could properly distribute traffic. This was done by reverting to a previous version and slowly applying the updates to avoid recurrence of the issue.

## Corrective and Preventive Measures

### Improvements
- Enhance load balancer configuration testing protocol before deployment.
- Implement more granular monitoring and alerts to detect uneven traffic distribution earlier.
- Improve documentation on load balancer configuration for the DevOps team.

### TODO List
- **Patch Nginx Load Balancer**: Apply a patch to address the specific bug that caused the misconfiguration.
- **Review and Update Deployment Procedures**: Update the deployment process to include a checklist for verifying load balancer configurations.
- **Conduct Postmortem Meeting**: Hold a meeting with the engineering and DevOps teams to discuss the incident and ensure lessons learned are applied.
- **Enhance Logging**: Add more detailed logging around load balancer operations to aid in faster diagnosis of similar issues in the future.

---

By addressing the root cause and implementing these corrective measures, we aim to prevent a recurrence of this type of outage and improve the overall reliability of the web application.

