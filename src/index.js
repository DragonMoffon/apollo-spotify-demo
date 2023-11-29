// APOLLO IMPORTS
import { ApolloServer } from '@apollo/server'
import { startStandaloneServer } from '@apollo/server/standalone'

// MISC IMPORTS
import { loadSchema } from '@graphql-tools/load'
import { GraphQLFileLoader } from '@graphql-tools/graphql-file-loader'

// INTERNAL IMPORTS
import { resolvers } from './resolvers.js'

const typeDefs = await loadSchema( './**/*.graphql',  { loaders: [new GraphQLFileLoader()]} );

const server = new ApolloServer(
    {
        typeDefs,
        resolvers
    }
);

const { url } = await startStandaloneServer(server, {
    listen: {port: 4000}
});

console.log(`🚀  Server ready at: ${url}`)

