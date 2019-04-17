import Vue from 'vue';
import Vuex from 'vuex';
import VueRouter from 'vue-router';
import router from './routes';
import App from './components/App';
Vue.use(Vuex);
Vue.use(VueRouter);

document.addEventListener('DOMContentLoaded', () => {

  var store = new Vuex.Store({});
  var app = new Vue({
    el: '#app',
    store: store,
    router,
    render: (h) => h(App)
  })
})
