# Flow

![screenshot](https://imgur.com/JJa4pwI.png)

This README roughly defines the current workflow for getting from ideas into
production for a specific client of mine.

As such it will act as a high level initial design document for a suite of CLI
utilititis to make this process less fiddly.

# Setup
Clone this repo and add it to your path.

Set up Tilix like this for useful actions when control clicking to open links
![tilix](https://i.imgur.com/gf1erMh.png)

N.B. similar set up should be possible for iTerm on Mac OS with Command click

## Dependencies

This project is pre-alpha. I'm gradually adding minor tweaks each day that make
my developer day more enjoyable and productive.
I currently work on Ubuntu in Tilix as my terminal and gvim as my text editor.

I'm happy to try
* make it more text editor agnostic
* more terminal agnostic
* more OS agnostic
* remove dependencies

Initial known dependencies. (There may be more I haven't realised just yet)

* hub
* httpie
* bash
* zsh
* git
* get-github-pr-review-comments

Also there's a dependency on opening gvim for my current client's project.
I think my github handle is also in here at the moment.  Those are easy to sort out.

I'm not in any rush to do these things, as the main goal is  making
my life easier and better first, with it being re-usable elsewhere being
a secondary goal.


```
TICKET -> CODE -> REVIEW -> DEPLOY
```


# STANDUP

* released          - anything to talk about?
* project release   - anything new?
* ready for release - any reason can't go out? who's releasing?
* UAT               - one by one
* In progress       - one by one
* Next up           - has anyone
* Batman            - who was it?  anything to talk about
*                     who is it today?
* Any work outside the board?


# GET TICKET
00. refine tickets
01. choose ticket                       (flow-next-ticket)

```
flow-status
no tickets in progress. Look for one with `flow-next-ticket`
```

02. mark jira ticket as in progress                 -
03. assign self to ticket                           |- (flow-next-ticket TECH-704)
04. checkout a branch with jira-id-slugified-title  |
05. display jira description and link to ticket     -

# WRITE CODE
05. develop
 * a. write tests
 * b. run tests      (spring_parallel_matching)
 * c. write code
 * d. run tests
 * e. fix tests
 * f. refactor
 * g. repeat 5 until ticket development done

```
flow-status
  JIRA     Status   CI     Title                PR                       Jira
* TECH-704 Progress -      "do a thing"         -                        https://....
  TECH-710 Review   Failed "do something else"  https://github.com/...   https://....
           Review   OK     some-branch-name     https://github.com/...   https://....
```

# nice to have
```
flow-create "Ticket Title" <<-EOF
description goes here
EOF

flow-status TECH-845
  JIRA     Status   CI      Title                PR                       Jira
  TECH-845 Progress Running "do something else"  https://github.com/...   https://....
```

# REVIEW
06. push code to github                                                - use hub pull-request and JIRA title/ticket
07. request review on slack, include JIRA ticket id and github PR link |
08. mark jira ticket as Review                                         |- (flow-review-start)
09. chase up if no response after a few hours (slack reminder)         -

10. address comments                                                   -
11. push code                                                          |- (flow-status) shows unresolved comments
12. repeat from 5 until approved                                       |
13. check ci maybe 20 minutes later                                    -

14. merge into develop                                                 |- (flow-merge)
15. mark in JIRA as UAT or awaiting release                            -

# DEPLOY
16. announce on slack release channel                                  |-(flow-release-start SHA/PR/JIRA)
18. wait to see if any objection

19. create a PR                                                        -
20. send an email                                                      |-(flow-release-deploy)
21. announce releasing slack                                           |
22. deploy code                                                        -

23. announce on release channel                                        |
24. wait for responses                                                 |-(flow-release-finish)
25. if all ok send email                                               |
