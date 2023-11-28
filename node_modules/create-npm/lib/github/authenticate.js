import octokit from '@octokit/rest'

export default function (token) {
  const githubApi = new octokit.Octokit({auth: `token ${token}`})
  return githubApi
}
