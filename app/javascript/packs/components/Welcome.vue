<template>
  <div class="container">
    <div class="container">
      <h5>
        Latest Posts
      </h5>
      <hr/>
    </div>
    <div class="container sp_sidebar">
      <div class="section col-md-8 col-sm-12" id="main">
        <posts-component/>
      </div>
       <div v-if='unauthenticated'>
          <login-component />
        </div>
      <div>
        <about-me-component />
      </div>
    </div>
  </div>
</template>

<script>
import axios from "../common/axios";
import PostsComponent from './Posts.vue'; 
import AboutMeComponent from './AboutMe.vue';
import LoginComponent from './Login.vue';
const postApiUrl = `${process.env.ROOT_API}/posts`;
export default {
  components: { PostsComponent, AboutMeComponent, LoginComponent },
  data() {
    return {
      unauthenticated: true
    };
  },
  beforeCreate() {
    var authToken = localStorage.getItem('auth_token');
    if(authToken) {
      this.$store.dispatch('authenticate', authToken)
      .then(result => {
        this.unauthenticated = false;
        
      })
    }
  }
  
};
</script>
