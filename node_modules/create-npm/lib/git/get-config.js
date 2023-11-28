import childProcess from 'node:child_process'
import {promisify} from 'node:util'

const exec = promisify(childProcess.exec)

export default async function (name) {
  try {
    const {stdout} = await exec(`git config --get ${name}`)
    return stdout.trim()
  } catch {
    return ''
  }
}
