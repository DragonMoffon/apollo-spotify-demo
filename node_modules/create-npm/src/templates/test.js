export default function () {
  return {
    path: 'test.js',
    content: `
      import test from 'ava'
      import greeting from './index.js'

      test('exporting "Hello World!"', (t) => {
        t.is(greeting, 'Hello World!')
      })
    `,
  }
}
