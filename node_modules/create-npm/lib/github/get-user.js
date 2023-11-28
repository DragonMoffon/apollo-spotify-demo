export default async function (githubApi) {
  const {
    data: {login},
  } = await githubApi.users.getAuthenticated()
  return login
}
