<template>
  <b-container>
    <b-row v-for="(post, index) in posts" :key="index">
      <div class="card-body">
        <h2 class="card-title">{{ post.title }}</h2>
        <p class="card-text">{{ post.content }}</p>
        <a href="#" class="btn btn-primary">Read More →</a>
      </div>
    </b-row>
  </b-container>
</template>
<script>
import axios from '../common/axios';
const postApiUrl = 'https://trekking-blog.herokuapp.com/api/v1/posts';
export default {
  data() {
    return { posts: []};
  },
  mounted(){
    axios.get(postApiUrl).then(response => {
      this.posts = response.data
      })
    .catch((err) => {
      console.log(err);
    });
  }
  
}
</script>
