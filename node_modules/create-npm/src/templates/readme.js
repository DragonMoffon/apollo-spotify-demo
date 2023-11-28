export default function ({repoName}) {
  const [, packageName] = repoName.split('/')

  return {
    path: 'README.md',
    content: `
      # ${packageName}
      [![npm](https://img.shields.io/npm/v/${packageName}.svg)](https://www.npmjs.com/package/${packageName})
      [![CI Status](https://github.com/${repoName}/workflows/CI/badge.svg)](https://github.com/${repoName}/actions?query=workflow%3ACI)

      An awesome package

      ## Usage
      Install [${packageName}](https://www.npmjs.com/package/${packageName})
      by running:

      \`\`\`sh
      yarn add ${packageName}
      \`\`\`
    `,
  }
}
