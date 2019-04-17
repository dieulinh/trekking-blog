import VueRouter from 'vue-router';
import WelcomePage from './components/Welcome.vue';

const routes = [
  {
    path: '/',
    component: WelcomePage
  }
];
export default new VueRouter({routes});