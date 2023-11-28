export default async function (githubApi, repoName) {
  const [owner, repo] = repoName.split('/')
  try {
    const response = await githubApi.repos.get({owner, repo})
    return response.data
  } catch {
    return null
  }
}
