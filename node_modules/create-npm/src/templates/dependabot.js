export default function () {
  return {
    path: '.github/dependabot.yml',
    content: `
      version: 2
      updates:
        - package-ecosystem: npm
          directory: /
          schedule:
            interval: daily
          commit-message:
            prefix: 'fix(deps):'
            prefix-development: 'chore(deps):'
    `,
  }
}
