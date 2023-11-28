import fetch from 'cross-fetch'

export default async function (request) {
  const fetchResponse = await fetch(request.url, {
    method: request.method,
    headers: Object.assign({}, request.headers, {
      'Content-Type': 'application/json',
    }),
    body: JSON.stringify(request.body),
  })

  const headers = {}

  // eslint-disable-next-line unicorn/no-array-for-each
  fetchResponse.headers.forEach((value, key) => {
    headers[key] = headers[key] ? `${headers[key]}, ${value}` : value
  })

  return {
    status: fetchResponse.status,
    headers,
    body: await fetchResponse.json(),
  }
}
