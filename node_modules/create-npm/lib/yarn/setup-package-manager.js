import childProcess from 'node:child_process'
import {promisify} from 'node:util'

const exec = promisify(childProcess.exec)

export default async function (projectDirectory) {
  await exec('yarn set version stable', {
    cwd: projectDirectory,
  })
  await exec('yarn config set nodeLinker node-modules', {
    cwd: projectDirectory,
  })

  await exec('yarn config set nodeLinker node-modules', {
    cwd: projectDirectory,
  })

  await exec('yarn config set enableGlobalCache false', {
    cwd: projectDirectory,
  })
}
