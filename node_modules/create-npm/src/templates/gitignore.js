export default function () {
  return {
    path: '.gitignore',
    content: `
      /node_modules
      /.yarn/install-state.gz
    `,
  }
}
