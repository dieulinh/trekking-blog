<template>
  <div class="container">
    <div class="container sp_sidebar">
      <div class="col-md-8 col-sm-12">
        <posts-component/>
      </div>
      <div>
        <login-component />
      </div>
    </div>
  </div>
</template>

<script>
import axios from "../common/axios";
import PostsComponent from './Posts.vue'; 
import AboutMeComponent from './AboutMe.vue';
import LoginComponent from './Login.vue';
export default {
  components: { PostsComponent, AboutMeComponent, LoginComponent },
  data() {
    return {
      
      unauthenticated: true
    };
  },
  beforeCreate() {
    console.log(this.$store.state.authenticated);
    this.unauthenticated = !this.$store.state.authenticated;
  },
  computed: {
    isLoggin() {
      return this.$store.state.authenticated;
    }
  }
  // beforeCreate() {
  //   var authToken = localStorage.getItem('auth_token');
  //   if(authToken) {
  //     this.$store.dispatch('authenticate', authToken)
  //     .then(result => {
  //       this.unauthenticated = false;
  //     })
  //   }
  // }
  
};
</script>
