process.env.NODE_ENV = process.env.NODE_ENV || 'production'
process.env.ROOT_API='"https://trekking-blog.herokuapp.com/api/v1"'

const environment = require('./environment')

module.exports = environment.toWebpackConfig()
