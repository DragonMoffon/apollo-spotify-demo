import path from 'node:path'
import dedent from 'dedent'
import fs from 'fs-extra'

export default async function (rootDirectory, template) {
  await fs.outputFile(
    path.join(rootDirectory, template.path),
    `${dedent(template.content)}\n`,
  )
}
