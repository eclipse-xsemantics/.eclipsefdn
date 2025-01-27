local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('modeling.xsemantics', 'eclipse-xsemantics') {
  settings+: {
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
    },
  },
  webhooks+: [
    orgs.newOrgWebhook('https://ci.eclipse.org/xsemantics/github-webhook/') {
      content_type: "json",
      events+: [
        "pull_request",
        "push"
      ],
    },
  ],
  _repositories+:: [
    orgs.newRepo('xsemantics') {
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "Xsemantics is a DSL (implemented in Xtext itself) for writing type systems, reduction rules, interpreters (and in general relation rules) for languages implemented in Xtext. It then generates Java code that can be used in your language implemented in Xtext for scoping and validation (it can also generate a validator in Java).",
      homepage: "",
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      webhooks: [
        orgs.newRepoWebhook('https://notify.travis-ci.org') {
          events+: [
            "create",
            "delete",
            "issue_comment",
            "member",
            "public",
            "pull_request",
            "push",
            "repository"
          ],
        },
      ],
      secrets: [
        orgs.newRepoSecret('COVERALLS_TOKEN') {
          value: "********",
        },
        orgs.newRepoSecret('SONARCLOUD_TOKEN') {
          value: "pass:bots/modeling.xsemantics/sonarcloud.io/token",
        },
      ],
    },
  ],
} + {
  # snippet added due to 'https://github.com/EclipseFdn/otterdog-configs/blob/main/blueprints/add-dot-github-repo.yml'
  _repositories+:: [
    orgs.newRepo('.github')
  ],
}