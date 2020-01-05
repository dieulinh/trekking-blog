<template>
<div class="menu-fixed-top white-bg">
  <ul class="menu-right">
    <li class="active"><a href="/">Works</a></li>
    <li v-if="!isLoggin"><a href="javascript:void(0);" @click="toggleLogin()">Sign in</a></li>
    <li v-if="isLoggin"><a href="javascript:void(0);" @click="logout()">Logout</a></li>
    <li><a href="https://github.com/dieulinh/">About</a></li>
  </ul>
  <div>
    <login-component></login-component>
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
