<template>
  <b-container>
    <b-row v-for="(post, index) in posts" :key="index">
      <div class="card-body">
        <h2 class="card-title">{{ post.title }}</h2>
        <div class="card-text">{{ post.description }}</div>
        <router-link :to="{ name: 'Post', params: { postId: post.slug|post.id } }">
          Read More
        </router-link>
      </div>
    </b-row>
  </b-container>
</template>
<script>
import Router from 'vue-router';
import axios from '../common/axios';
const postApiUrl = `${process.env.ROOT_API}/posts`;
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
