export default function () {
  return {
    path: '.npmignore',
    content: `
      .gitignore
      .github/

      .yarn/
      .yarnrc.yml
      yarn.lock

      **/*.test.js
      **/test.js
      test/
    `,
  }
}
