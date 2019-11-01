<template>
  <div class="container">
    <div class="container sp_sidebar">
      <div class="col-md-8 col-sm-12">
        <posts-component/>
      </div>
      <div>
        
      </div>
    </div>
  </div>
</template>

<script>
import axios from "../common/axios";
import PostsComponent from './Posts.vue'; 

export default {
  components: { 
    PostsComponent

  },
  data() {
    return {
      unauthenticated: true
    };
  },
  beforeCreate() {
    this.unauthenticated = !this.$store.state.authenticated;
  },
  computed: {
    isLoggin() {
      return this.$store.state.authenticated;
    }
  }
};
</script>
