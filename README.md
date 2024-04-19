# Task 1
* See [watcher.sh](https://github.com/j-Edge/sre-week-three-task/blob/main/watcher.sh) for the shutdown script, and [nohup.out](https://github.com/j-Edge/sre-week-three-task/blob/main/nohup.out) for the output from the script running on minikube in GitHub CodeSpaces.


# Task 2
## Ticketing System Challenges
> The ticketing system for alert management had been a major point of contention among engineers. Complaints included recurring obsolete issues and a lack of clear prioritization for incoming issues.
### Recommended Changes
* We should add a Priority to each ticket, set based on the type of alert and zone that the issue occurred in (Critical, High, Medium, Low)
* We should consolidate tickets with the same alert type and use comments to add the date of each additional occurrence instead of creating many tickets for the same issue. We can add a count of instances to the top-level ticket for visibility on alerts that fire many times.
  * For example: the EndpointRegistrationTransientFailure in Zone HQ would create a single open ticket at a time, with each alert date added as a comment, instead of generating 13 individual tickets for SREs to track.
  * These are still separated out by Zone in case we need to address the issues per-zone. They could be combined for multiple zones if we find this is still too granular for some alerts.
* These changes would reduce our current tickets from **31** tickets down to **8** clearly prioritized tickets.
* We can also consider auto-closing tickets when alerts resolve if that makes them no longer actionable (possibly the TransientFailures?)

### Ticketing system's output with recommended changes:
```
Zone AB: TooFewEndpointsRegistered, Priority: Critical, AlertCount: 1
Zone AB: LLMModelVeryStale, Priority: High, AlertCount: 1
Zone AB: LLMModelStale, Priority: Medium, AlertCount: 1
Zone AB: LLMBatchProcessingJobFailures, Priority: Medium, AlertCount: 3
  (task has 3 comment of date/time of additional alert created)
Zone AB: EndpointRegistrationFailure, Priority: Medium, AlertCount: 2
  (task has 2 comment of date/time of additional alert created)
Zone OH-1: EndpointRegistrationTransientFailure, Priority: Low, AlertCount: 8
  (task has 8 comments of date/time of each additional alert created)
Zone XQ: EndpointRegistrationTransientFailure, Priority: Low, AlertCount: 13
  (task has 13 comments of date/time of each alert created)
Zone AB: EndpointRegistrationTransientFailure, Priority: Low, AlertCount: 3
  (task has 3 comments of date/time of each additional alert created)
```

### An example of the ticketing system's output is as follows:
```
Zone XQ: EndpointRegistrationTransientFailure
Zone OH-1: EndpointRegistrationTransientFailure
Zone OH-1: EndpointRegistrationTransientFailure
Zone XQ: EndpointRegistrationTransientFailure
Zone XQ: EndpointRegistrationTransientFailure
Zone OH-1: EndpointRegistrationTransientFailure
Zone OH-1: EndpointRegistrationTransientFailure
Zone XQ: EndpointRegistrationTransientFailure
Zone XQ: EndpointRegistrationTransientFailure
Zone XQ: EndpointRegistrationTransientFailure
Zone AB: EndpointRegistrationTransientFailure
Zone AB: LLMBatchProcessingJobFailures
Zone AB: EndpointRegistrationFailure
Zone XQ: EndpointRegistrationTransientFailure
Zone XQ: EndpointRegistrationTransientFailure
Zone OH-1: EndpointRegistrationTransientFailure
Zone OH-1: EndpointRegistrationTransientFailure
Zone XQ: EndpointRegistrationTransientFailure
Zone AB: EndpointRegistrationTransientFailure
Zone AB: LLMBatchProcessingJobFailures
Zone AB: TooFewEndpointsRegistered
Zone AB: LLMModelStale
Zone OH-1: EndpointRegistrationTransientFailure
Zone OH-1: EndpointRegistrationTransientFailure
Zone XQ: EndpointRegistrationTransientFailure
Zone XQ: EndpointRegistrationTransientFailure
Zone XQ: EndpointRegistrationTransientFailure
Zone AB: EndpointRegistrationTransientFailure
Zone AB: LLMBatchProcessingJobFailures
Zone AB: EndpointRegistrationFailure
Zone AB: LLMModelVeryStale
```
