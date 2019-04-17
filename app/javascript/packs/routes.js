import VueRouter from 'vue-router';
import WelcomePage from './components/Welcome.vue';
import ProductsPage from './components/Products.vue';

const routes = [
  {
    path: '/',
    component: WelcomePage
  },
  {
    path: '/products',
    component: ProductsPage
  }
];
export default new VueRouter({routes});