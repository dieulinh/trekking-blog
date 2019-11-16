process.env.NODE_ENV = process.env.NODE_ENV || 'development'
process.env.ROOT_API = 'http://localhost:3000/api/v1'
process.env.GOOGLE_MAP_API_KEY = 'AIzaSyDdB12teSjaIYUIRQAqAxVU3iJfaYfDD-o'
const environment = require('./environment')

module.exports = environment.toWebpackConfig()
