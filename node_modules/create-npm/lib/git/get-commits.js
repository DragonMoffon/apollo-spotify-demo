import childProcess from 'node:child_process'
import {promisify} from 'node:util'

const exec = promisify(childProcess.exec)

export default async function (projectDirectory) {
  const {stdout} = await exec(
    'git log --pretty=oneline --abbrev-commit --decorate',
    {
      cwd: projectDirectory,
    },
  )
  return stdout.trim().split('\n')
}
