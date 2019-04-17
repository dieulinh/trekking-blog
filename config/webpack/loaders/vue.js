module.exports = {
  test: /\.vue(\.erb)?$/,
  resolve: { 
    alias :  { 
      'vue $' :  'vue/dist/vue.esm.js' 
    }
  },
  use: [{
    loader: 'vue-loader'
  }]
}
