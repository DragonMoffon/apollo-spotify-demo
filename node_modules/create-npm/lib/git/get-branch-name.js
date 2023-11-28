import childProcess from 'node:child_process'
import {promisify} from 'node:util'

const exec = promisify(childProcess.exec)

export default async function (projectDirectory) {
  try {
    const {stdout} = await exec('git branch --show-current', {
      cwd: projectDirectory,
    })

    return stdout.trim()
  } catch {
    return ''
  }
}
