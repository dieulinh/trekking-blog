<template>
  <b-container>
    <b-row v-for="(post, index) in posts" :key="index">
      
      {{ post.title }}

    </b-row>
    
  </b-container>
</template>
<script>
import axios from '../common/axios';
const postApiUrl = 'http://localhost:3000/api/v1/posts';
export default {
  data() {
    return { posts: []};
  },
  mounted(){

    axios.get(postApiUrl).then(response => {
      console.log(response.data);
      this.posts = response.data
      })
    .catch((err) => {
      console.log(err);
    });
  }
  
}
</script>
