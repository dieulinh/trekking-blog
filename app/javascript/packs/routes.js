import VueRouter from 'vue-router';
import WelcomePage from './components/Welcome.vue';
import ProductsPage from './components/Products.vue';
import PostsPage from './components/Posts.vue';
import NewPostPage from './components/NewPost.vue';


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
  },
  {
    path: '/new_post',
    component: NewPostPage
  }
];
export default new VueRouter({routes});