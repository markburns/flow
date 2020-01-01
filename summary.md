# choose a ticket
flow-start
flow-start TECH-456

flow-create title <<-EOF
  description
EOF

# context switching
flow-tickets
  flow-status for each local branch

flow-switch TECH-234
  checkout branch
  show CI/PR status and links
  show unresolved PR comments


# development
flow-status
flow-ci
flow-ci-run-failed-locally

# review
flow-review-start
flow-status
flow-review-bump
flow-deploy-staging
flow-merge

flow-deploy-announce
flow-deploy-start
flow-deploy-finish

# standup
flow-kanban
