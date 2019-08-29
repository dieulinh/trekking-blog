import Vue from 'vue';
import Vuex from 'vuex';
import moment from 'moment';
import VueRouter from 'vue-router';
import BootstrapVue from 'bootstrap-vue';
import router from './routes';
import App from './components/App';
import store from './store';
Vue.use(Vuex);
Vue.use(BootstrapVue);
Vue.use(VueRouter);
Vue.filter('formatDate', function(value) {
  if (value) {
    return moment(String(value)).format('MM/DD/YYYY hh:mm')
  }
});
document.addEventListener('DOMContentLoaded', () => {

  var app = new Vue({
    el: '#app',
    store: store,
    router,
    render: (h) => h(App)
  })
})
