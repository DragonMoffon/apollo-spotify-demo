export default function () {
  return {
    path: '.github/workflows/dependabot.yml',
    content: `
      name: Dependabot
      on: pull_request_target
      jobs:
        dependabot:
          if: \${{ github.event.pull_request.user.login == 'dependabot[bot]' }}
          runs-on: ubuntu-latest
          steps:
            - uses: actions/checkout@v3
              with:
                ref: \${{ github.event.pull_request.head.sha }}
            - uses: actions/setup-node@v3
              with:
                node-version: latest
                cache: yarn
            - run: yarn
            - run: yarn test
            - run: gh pr merge --auto --rebase \${{ github.event.pull_request.html_url }}
              env:
                GITHUB_TOKEN: \${{ secrets.GITHUB_TOKEN }}
    `,
  }
}
