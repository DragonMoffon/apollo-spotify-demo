// APOLLO IMPORTS
import { ApolloServer } from '@apollo/server'
import { startStandaloneServer } from '@apollo/server/standalone'

// MISC IMPORTS
import { loadSchema } from '@graphql-tools/load'
import { GraphQLFileLoader } from '@graphql-tools/graphql-file-loader'

// INTERNAL IMPORTS
import { SPF_search_resolvers } from './spotify/search.js'
import { get_access_token, AccessToken } from './spotify/auth.js'

const typeDefs = await loadSchema( './**/compressed_schema.graphql',  { loaders: [new GraphQLFileLoader()]} );

const server = new ApolloServer(
    {
        typeDefs,
        resolvers: SPF_search_resolvers
    }
);

console.log(SPF_search_resolvers)

const { url } = await startStandaloneServer(server, {
    listen: {port: 4000}
});

const next_access_token = await get_access_token()
AccessToken.set_token(next_access_token.token, next_access_token.expires)

console.log(`🚀  Server ready at: ${url}`)
console.log(AccessToken.get_token())