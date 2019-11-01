<template>
  <div class="container">
    <div class="container sp_sidebar">
      <div class="col-md-8 col-sm-12">
        <posts-component/>
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
  }
};
</script>
