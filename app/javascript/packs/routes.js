import Vue from 'vue';
import VueRouter from 'vue-router';
  
import WelcomePage from './components/Welcome.vue';
import ProductsPage from './components/Products.vue';
import PostsPage from './components/Posts.vue';
import NewPostPage from './components/NewPost.vue';
import EditPostPage from './components/EditPost.vue';
import PostPage from './components/Post.vue';
import LoginPage from './components/Login.vue';
import RegisterPage from './components/Register.vue';

const routes = [
  {
    path: '/',
    component: WelcomePage
  },
  {
    path: '/login',
    component: LoginPage
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
    component: NewPostPage,
    name: 'NewPost'
  },
  {
    path: '/posts/:postId',
    component: PostPage,
    props: true,
    name: 'Post'
  },
  {
    path: '/posts/:postId/edit',
    component: EditPostPage,
    props: true,
    name: 'EditPost'
  },
  {
    path: '/register',
    component: RegisterPage
  },
  // otherwise redirect to home
  { path: '*', redirect: '/' }
];

export default new VueRouter({routes});