/* eslint-disable camelcase */

export default async function (githubApi, repoName) {
  const [org, name] = repoName.split('/')

  await githubApi.actions.setGithubActionsDefaultWorkflowPermissionsRepository({
    owner: org,
    repo: name,
    default_workflow_permissions: 'write',
    can_approve_pull_request_reviews: true,
  })
}
