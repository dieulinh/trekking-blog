import VueRouter from 'vue-router';
import WelcomePage from './components/Welcome.vue';
import ProductsPage from './components/Products.vue';
import PostsPage from './components/Posts.vue';


const routes = [
  {
    path: '/',
    component: WelcomePage
  },
  {
    path: '/products',
    component: ProductsPage
  },
  {
    path: '/posts',
    component: PostsPage
  }
];
export default new VueRouter({routes});