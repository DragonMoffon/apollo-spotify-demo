import {promisify} from 'node:util'
import {getUser} from './index.js'

const sleep = promisify(setTimeout)

export default async function (githubApi, repoName) {
  const [org, name] = repoName.split('/')

  const user = await getUser(githubApi)
  await (org === user
    ? githubApi.repos.createForAuthenticatedUser({name})
    : githubApi.repos.createInOrg({org, name}))

  // There's sometimes a delay before the update is reflected in the API
  await sleep(2000)
}
