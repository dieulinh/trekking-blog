import Vue from 'vue';
import Vuex from 'vuex';
import moment from 'moment';
import VueRouter from 'vue-router';
import BootstrapVue from 'bootstrap-vue';
import router from './routes';
import App from './components/App';
import store from './store';
import Axios from 'axios';
import VueSession from 'vue-session';
Vue.use(VueSession);

Vue.use(Vuex);
Vue.use(BootstrapVue);
Vue.use(VueRouter);
Vue.prototype.$http = Axios;
let authToken = localStorage.getItem('auth_token');
if(authToken) {
  Vue.prototype.$http.defaults.headers.common['Authorization'] = `Bearer ${authToken}`;
}

Vue.filter('formatDate', function(value) {
  if (value) {
    return moment(String(value)).format('MM/DD/YYYY hh:mm A')
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
