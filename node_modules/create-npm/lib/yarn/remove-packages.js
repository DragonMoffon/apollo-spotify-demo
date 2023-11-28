import childProcess from 'node:child_process'
import {promisify} from 'node:util'

const exec = promisify(childProcess.exec)

export default async function (projectDirectory, packages) {
  await exec(`yarn remove ${packages.join(' ')}`, {
    cwd: projectDirectory,
  })
}
