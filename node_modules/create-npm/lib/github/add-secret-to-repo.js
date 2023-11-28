/* eslint-disable camelcase */
import {Buffer} from 'node:buffer'
import libsodium from 'libsodium-wrappers'

export default async function (githubApi, repoName, secretName, secretValue) {
  const [owner, repo] = repoName.split('/')

  const {
    data: {key_id: keyId, key},
  } = await githubApi.actions.getRepoPublicKey({owner, repo})

  await libsodium.ready
  const encryptedValue = libsodium.crypto_box_seal(
    new TextEncoder().encode(secretValue),
    Buffer.from(key, 'base64'),
  )

  await githubApi.actions.createOrUpdateRepoSecret({
    owner,
    repo,
    secret_name: secretName,
    encrypted_value: Buffer.from(encryptedValue).toString('base64'),
    key_id: keyId,
  })
}
