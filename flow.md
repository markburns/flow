```
+--------------------+----------------------------+-------------------------------------+-----------------------+-----------------------+
| JIRA               | local                      | github                              | circle                | Slack                 |
| id, title , status | git branch, pushed status  | PR, title, branch, status, comments | build_number, status  | Review request status |
+--------------------+----------------------------+-------------------------------------+-----------------------+-----------------------+
| JIRA               | local                      | github                              | circle                | Slack                 |
| id, title , status | <jira>,  git status        | PR, <jira>, <jira>, status,comments | build_number, status  | Review request status |
+--------------------+----------------------------+-------------------------------------+-----------------------+-----------------------+


+--------------------------+-----------------------------------------------------------------+------------------------------------+
| interactions             | Activity                                                        +  flow tool that can help           |
+--------------------------+-----------------------------------------------------------------+------------------------------------+
| Find a ticket            | JIRA View Next up                                               | flow-jira next                     |
+--------------------------+-----------------------------------------------------------------+------------------------------------+
| Start a ticket           | JIRA Next up -> In progress                                     | flow-start <JIRA_ID>               |
+--------------------------+-----------------------------------------------------------------+------------------------------------+
| Develop                  | Local: create a git branch, name with JIRA id and title         | flow-start <JIRA_ID>               |
+--------------------------+-----------------------------------------------------------------+------------------------------------+
| Create a PR              | GH   Create a PR [use JIRA id and title]                        | flow-pr                            |
+--------------------------+-----------------------------------------------------------------+------------------------------------+
| Author: Request a review | JIRA In Progress -> review                                      | flow-jira <state> [JIRA_ID]        |
|                          | Slack Request a review [JIRA id and title, GH link]             | copy flow-pr output for slack msg  |
+--------------------------+-----------------------------------------------------------------+------------------------------------+
| Reviewer: Review code    | View slack or GH notifications, or visit PR,                    |                                    |
|                          | go to GH write comments, maybe pull down branch                 |                                    |
+--------------------------+-----------------------------------------------------------------+------------------------------------+
| Author: address comments | View slack, go to GH read comments, maybe reply in there,       | flow-comments, flow-status         |
|                          | maybe copy filename, maybe copy snippet of code,                | N.B. resolved status only available|
|                          | update code locally, push                                       | in graphql api working on that     |
+--------------------------+-----------------------------------------------------------------+------------------------------------+
| Reviewer: Review code    | Possibly repeat cycle a few times                               |                                    |
+--------------------------+-----------------------------------------------------------------+------------------------------------+
| Author: address comments | Possibly repeat cycle a few times, maybe waste a bit of time    | flow-comments                      |
|                          | re-reading already resolved comments                            |                                    |
+--------------------------+-----------------------------------------------------------------+------------------------------------+
| Author: fix tests        | Wait 15 minutes, Go to GH, click CI link, or go straight to CI  | flow-status, ci, open-ci           |
|                          | Click a few more places and copy and paste a filename,          | spring-parallel-specs              |
|                          | Run tests locally, see failure, red,green, refactor X times     |                                    |
|                          | Push, repeat this step X times                                  |                                    |
+--------------------------+-----------------------------------------------------------------+------------------------------------+
| Reviewer: Approve code   | Message on slack, visit GH, check resolutions are satisfactory, | flow-comments                      |
|                          | click approve                                                   |                                    |
+--------------------------+-----------------------------------------------------------------+------------------------------------+
| Author: Merge code       | Message on slack, visit GH, maybe read comment possibly,        | flow-comments, flow-status, ci     |
|                          | address further comments, push, repeat fix tests step X times   |                                    |
|                          | maybe get confirmation from reviewer again                      |                                    |
|                          | message on slack, wait for response, wait for approval          |                                    |
|                          | click merge                                                     |                                    |
+--------------------------+-----------------------------------------------------------------+------------------------------------+
| Reviewer: Re-approve code| Message on slack, visit GH, check resolutions are satisfactory, |                                    |
|                          | click approve                                                   |                                    |
+--------------------------+-----------------------------------------------------------------+------------------------------------+
| Author: update JIRA      | Find JIRA ticket, mark as 'UAT' or 'Awaiting Release'           | flow-jira-transition               |
+--------------------------+-----------------------------------------------------------------+------------------------------------+
| Deploy manager           | The deploy process has lots of steps, I'm going to keep         | flow-deploy                        |
|                          | working on this                                                 |                                    |
+--------------------------+-----------------------------------------------------------------+------------------------------------+
```
