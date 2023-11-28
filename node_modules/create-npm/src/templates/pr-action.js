export default function () {
  return {
    path: '.github/workflows/pr.yml',
    content: `
      name: PR
      on: pull_request
      jobs:
        pr:
          if: \${{ github.event.pull_request.user.login != 'dependabot[bot]' }}
          runs-on: ubuntu-latest
          steps:
            - uses: actions/checkout@v3
            - uses: actions/setup-node@v3
              with:
                node-version: latest
                cache: yarn
            - run: yarn
            - run: yarn test
    `,
  }
}
