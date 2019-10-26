<template>
  <ul class="menu-fixed-top white-bg">
    <li class="active"><a href="/">Works</a></li>
    <li><a href="/#/posts">Blog</a></li>
    <li v-if="!isLoggin"><a href="javascript:void(0);" @click="toggleLogin()">Sign in</a></li>
    <li v-if="isLoggin"><a @click="()=> console.log(logout)">Logout</a></li>
    <li><a href="#aboutme">About</a></li>
  </ul>
</template>
<script>

export default {
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
    toggleLogin() {
      console.log('toggleLoggin');
      console.log(this.$store.state);
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