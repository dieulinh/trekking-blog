process.env.NODE_ENV = process.env.NODE_ENV || 'production'
process.env.ROOT_API='https://trekking-blog.herokuapp.com/api/v1'
process.env.GOOGLE_MAP_API_KEY='AIzaSyB87QOBbL18pW8vfnFFakEgWTBR5yvPJns'
const environment = require('./environment')

module.exports = environment.toWebpackConfig()
