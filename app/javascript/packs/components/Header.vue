<template>
<div>
  <div class="white-bg sm-column-lo">
    <ul class="menu-right">
      <li class="active"><a href="/">Works</a></li>
      <li> <a href="javascript:void(0);" @click="toggleHackerNews()">News</a></li>
      <li v-if="!isLoggin"><a href="javascript:void(0);" @click="toggleLogin()">Sign in</a></li>
      <li v-if="isLoggin"><a href="javascript:void(0);" @click="logout()">Logout</a></li>
      <li><a href="#">About</a></li>
    </ul>
    <div class="main-menu-sm">
      <div class="toggle-menu-btn-wrapper">
        <div class="toggle-menu-btn" @click="toggleMenu($event)">
          <div class="burger-menu-item"></div>
          <div class="burger-menu-item"></div>
          <div class="burger-menu-item"></div>
        </div>
      </div>
      <div class="burger-menu-wrapper">
        <div class="menu-expanded">
          <a href="/">Home</a>
          <a href="javascript:void(0);" @click="toggleHackerNews()">News</a>
          <a  v-if="!isLoggin" href="javascript:void(0);" @click="toggleLogin()">Sign in</a>
          <a  v-if="isLoggin" href="javascript:void(0);" @click="logout()">Logout</a>

          <a href="/">About</a>

        </div>
      </div>
    </div>
    <div>
      <login-component></login-component>
    </div>
  </div>
</div>
</template>
<script>
import LoginComponent from './Login.vue';
import axios from '../common/axios';

export default {
  components: { LoginComponent },
  data() {
    return {
    }
  },
  computed: {
    isLoggin() {
      return this.$store.state.authenticated;
    }
  },
  methods: {
    toggleMenu(event) {
      $('.menu-expanded').toggleClass("active");
    },
    toggleHackerNews() {
      // this.$store.dispatch("getNews");
      this.$store.dispatch("getPosts", { page: 1});
    },
    logout() {
      this.$store.dispatch("logout");
    },
    toggleLogin() {
      this.$store.dispatch('showLogin', true);
    }
  }
}
</script>
<style scoped>
  .app-header {
    width: 100%;
    display: flex;
    flex-direction: row;
    margin-bottom: 20px;
    justify-content: flex-end;
    align-items: center;
  }
  .relative-search {
    display: flex;
    flex-direction: row;
    width: 50%;
  }
  .search-box {
    width: 97%;
  }
</style>
