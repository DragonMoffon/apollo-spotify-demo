# create-npm
[![CI Status](https://github.com/vinsonchuong/create-npm/workflows/CI/badge.svg)](https://github.com/vinsonchuong/create-npm/actions?query=workflow%3ACI)

Bootstrap [npm](https://www.npmjs.com) packages.

## Usage
```sh
yarn create npm github-user/my-pkg
```

Running the above command will:

* Bootstrap a JavaScript project with:
  * Package management using [Yarn Classic](https://classic.yarnpkg.com/lang/en/)
  * Testing via [AVA](https://github.com/avajs/ava)
  * Linting via [XO](https://github.com/xojs/xo)
* Create a GitHub repository for the project
* Enable continuous integration and deployment via
  [GitHub Actions](https://github.com/features/actions) and
  [semantic-release](https://github.com/semantic-release/semantic-release)
* Automatic updates of dependencies using Dependabot
  * Security updates
  * Versions of `dependencies` and `devDependencies`

### Prerequisites
To use `create-npm`, the following tools must be installed:

* [Node.js](https://nodejs.org/en/)
* [git](https://git-scm.com/)

The following credentials must be given as environment variables:

* `NPM_TOKEN`
* `GITHUB_TOKEN`

The GitHub token is used to add the NPM token to your newly created repository.
