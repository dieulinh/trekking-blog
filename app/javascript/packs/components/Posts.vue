<template>
  <b-container>
    <b-row v-for="(post, index) in posts" :key="index">
      <div class="row col-md-12 no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-100 position-relative">
        <div class="col p-4 d-flex flex-column position-static">
          <strong class="d-inline-block mb-2 text-primary">World</strong>
          <h5 class="mb-0">{{ post.title }}</h5>
          <div class="mb-1 text-muted">Nov 12</div>
          <p class="card-text mb-auto">{{ post.description }}</p>
          <router-link :to="{ name: 'Post', params: { postId: post.slug } }">
            Read More
          </router-link>
        </div>
        <div class="col-auto d-none d-lg-block">
          <img v-bind:src="post.thumb_url" class="bd-placeholder-img" height="250"/>
        </div>
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
