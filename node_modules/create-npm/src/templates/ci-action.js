export default function ({branchName}) {
  return {
    path: '.github/workflows/ci.yml',
    content: `
      name: CI
      on:
        push:
          branches:
            - ${branchName}
      jobs:
        ci:
          runs-on: ubuntu-latest
          steps:
          - uses: actions/checkout@v3
          - uses: actions/setup-node@v3
            with:
              node-version: latest
              cache: yarn
          - run: yarn
          - run: yarn test
          - run: yarn release
            env:
              GITHUB_TOKEN: \${{ secrets.GITHUB_TOKEN }}
              NPM_TOKEN: \${{ secrets.NPM_TOKEN }}
    `,
  }
}
