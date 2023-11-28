import {promisify} from 'node:util'

const sleep = promisify(setTimeout)

export default async function (githubApi, repoName) {
  const [owner, repo] = repoName.split('/')
  await githubApi.repos.delete({owner, repo})

  // There's sometimes a delay before the update is reflected in the API
  await sleep(2000)
}
