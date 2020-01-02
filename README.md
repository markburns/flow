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

config in text format:
```
launch firefox:
  firefox $0
  ((http[s]?):\/)\/([^:\/\s]+)((\/\w+)*\/)([\w\-\.]+[^#?\s]+)(#[\w\-]+)?

run single spec in spring:
  run-command spring rspec $0 $1 $2 $3 $4
  (rspec (([\.]\/[a-z][a-z0-9_\.\/\-]+):(\d+)))

gvim:
  relative:
    launch-gvim 'relative' $0 $1 $2 $3
    (([\.]\/[a-z][a-z0-9_\.\/\-]+):(\d+))

    launch-gvim 'relative-no-line' $0 $1 $2 $3
    (([\.]\/[a-z][a-z0-9_\.\/\-]+))

    launch-gvim 'relative-no-dot' $0 $1 $2 $3
    (([a-z][a-z0-9_\.\/\-]+):(\d+))

    launch-gvim 'relative-no-dot-no-line' $0 $1 $2 $3
    (([a-z][a-z0-9_\.\/\-]+))

    launch-gvim 'full' $0 $1 $2 $3
    ((\/[a-z][a-z0-9_\.\/\-]+):(\d+))

    launch-gvim 'full-no-line' $0 $1 $2 $3
    ((\/[a-z][a-z0-9_\.\/\-]+))

git branch switching:
  run-command git checkout $2
  (branch: ([a-z]+\-[0-9]+\-[a-z\-]+))
```


N.B. similar set up should be possible for iTerm on Mac OS with Command click

Add environment variables GH_TOKEN, JIRA_USERNAME, JIRA_TOKEN, JIRA_SUBDOMAIN.
Get github token here: https://github.com/settings/tokens
JIRA token here: https://id.atlassian.com/manage/api-tokens

# Usage
prefix your branch names with the JIRA ticket ID. E.g.`ASDF-123-some-jira-ticket-title`
N.B. this will be automatic in the future with unification of JIRA ticket titles, PR titles and branch names (or their path/URL friendly slugified equivalents)

```
flow-status # shows status of your local branches including JIRA ticket, GitHub and CI status
flow-status verbose # as above but includes information on local branches and PRs that don't match JIRA tickets
flow-status verbose ci # as above but fetches failure info from circle
ci  [branch] # fetch status and/or failures from CI
ci-status [branch] # fetch only the CI status
clean-branches # delete branches that are up to date with the current branch and not named master or develop
kb # open the kanban board in firefox
open-ci # open Circle for the current branch's PR
spring-parallel-matching
```

## Tilix commands
By commands we mean, hold down <CTRL> and click the highlighted link given that you've set up Tilix as defined lower down.
This should be extensible to work in iTerm too, and I'd like to find out how iTerm/Tilix config is persisted and ideally manage it from this repo. At the moment it's just a case of manually editing the config.

```
switch branch [matches on `branch: <branch_name>`]
open in gvim [matches on relative URLs in project, full paths, and both with or without line numbers]
open URL [matches on any URL and defaults to opening in firefox]
run spec in spring [matches on rspec output for lines beginning with `rspec ./spec/...`]
```



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

# Parallel RSpec
I currently have a 16 core machine. By running parallel_tests with glob matching I can quickly run all the most likely relevant tests for a specific feature.

Example
```
 specs-parallel-matching '*/integrations/shopify/'
Running via Spring preloader in process 21716
14 processes for 14 specs, ~ 1 specs per process
Running via Spring preloader in process 21766
Running via Spring preloader in process 21769
Running via Spring preloader in process 21772
Running via Spring preloader in process 21775
Running via Spring preloader in process 21778
Running via Spring preloader in process 21781
Running via Spring preloader in process 21784
Running via Spring preloader in process 21787
Running via Spring preloader in process 21790
Running via Spring preloader in process 21793
Running via Spring preloader in process 21796
Running via Spring preloader in process 21799
Running via Spring preloader in process 21802
Running via Spring preloader in process 21805
..............

Finished in 1.6 seconds (files took 0.99127 seconds to load)
2 examples, 0 failures

......

Finished in 1.93 seconds (files took 1.23 seconds to load)
3 examples, 0 failures

....

Finished in 1.91 seconds (files took 1.03 seconds to load)
3 examples, 0 failures

..............

Finished in 2.53 seconds (files took 1.34 seconds to load)
4 examples, 0 failures

...............

Finished in 2.04 seconds (files took 0.9734 seconds to load)
4 examples, 0 failures

..

Finished in 3.06 seconds (files took 1.35 seconds to load)
11 examples, 0 failures

............

Finished in 3.38 seconds (files took 1.31 seconds to load)
13 examples, 0 failures

...

Finished in 2.78 seconds (files took 0.90789 seconds to load)
4 examples, 0 failures

.

Finished in 2.84 seconds (files took 1.03 seconds to load)
8 examples, 0 failures

..................

Finished in 4.39 seconds (files took 1.04 seconds to load)
11 examples, 0 failures

.................

Finished in 5.66 seconds (files took 0.80507 seconds to load)
5 examples, 0 failures

.....

Finished in 6.03 seconds (files took 1.01 seconds to load)
6 examples, 0 failures

....

Finished in 6.29 seconds (files took 0.83598 seconds to load)
38 examples, 0 failures

.....

Finished in 9.58 seconds (files took 1.22 seconds to load)
8 examples, 0 failures


120 examples, 0 failures

Took 12 seconds

```

# Current workflow description
The following section is very specific to our workflow at the moment.
I'll be using this as a guideline to identify and remove pain points.

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
