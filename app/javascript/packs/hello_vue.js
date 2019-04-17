import Vue from 'vue';
import Vuex from 'vuex';
import VueRouter from 'vue-router';
import BootstrapVue from 'bootstrap-vue';
import router from './routes';
import App from './components/App';
import store from './store';
Vue.use(Vuex);
Vue.use(BootstrapVue);
Vue.use(VueRouter);

document.addEventListener('DOMContentLoaded', () => {

  // var store = new Vuex.Store({});
  var app = new Vue({
    el: '#app',
    store: store,
    router,
    render: (h) => h(App)
  })
})
