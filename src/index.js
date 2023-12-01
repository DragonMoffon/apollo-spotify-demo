// APOLLO IMPORTS
import { ApolloServer } from '@apollo/server'
import { startStandaloneServer } from '@apollo/server/standalone'

// MISC IMPORTS
import { loadSchema } from '@graphql-tools/load'
import { GraphQLFileLoader } from '@graphql-tools/graphql-file-loader'

// INTERNAL IMPORTS
import { SPF_search_resolvers } from './spotify/search.js'
import { AccessToken } from './spotify/auth.js'

AccessToken.request_new_token()

const typeDefs = await loadSchema( './**/compressed_schema.graphql',  { loaders: [new GraphQLFileLoader()]} );

const server = new ApolloServer(
    {
        typeDefs,
        resolvers: SPF_search_resolvers
    }
);

const { url } = await startStandaloneServer(server, {
    listen: {port: 4000}
});

console.log(`🚀  Server ready at: ${url}`)