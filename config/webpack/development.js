process.env.NODE_ENV = process.env.NODE_ENV || 'development'
process.env.ROOT_API = 'http://localhost:3000/api/v1'
const environment = require('./environment')

module.exports = environment.toWebpackConfig()
