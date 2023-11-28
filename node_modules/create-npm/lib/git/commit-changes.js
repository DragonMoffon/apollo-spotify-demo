import childProcess from 'node:child_process'
import {promisify} from 'node:util'

const exec = promisify(childProcess.exec)

export default async function (projectDirectory, message) {
  await exec('git init', {cwd: projectDirectory})
  await exec('git add -A', {cwd: projectDirectory})
  await exec(`git commit -m '${message}'`, {cwd: projectDirectory})
}
