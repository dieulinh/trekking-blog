process.env.NODE_ENV = process.env.NODE_ENV || 'production'
process.env.ROOT_API='https://trekking-blog.herokuapp.com/api/v1'
process.env.GOOGLE_MAP_API_KEY = 'AIzaSyDdB12teSjaIYUIRQAqAxVU3iJfaYfDD-o'
const environment = require('./environment')

module.exports = environment.toWebpackConfig()
