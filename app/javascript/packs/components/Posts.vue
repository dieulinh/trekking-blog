<template>
  <b-container>
    <b-row v-for="(post, index) in posts" :key="index">
      <div class="row col-md-12 no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-100 position-relative">
        <div class="col p-4 d-flex flex-column position-static">
          <strong class="d-inline-block mb-2 text-primary text-title">{{ post.category }}</strong>
          <h5 class="mb-0" >{{ post.title }}</h5>
          <div class="mb-1 text-muted">Nov 12</div>
          <p class="card-text mb-auto">{{ post.description }}</p>
          <router-link :to="{ name: 'Post', params: { postId: post.slug } }">
            Read More
          </router-link>
        </div>
        <div class="col-auto d-none d-lg-block">
          <img v-bind:src="post.thumb_url" class="bd-placeholder-img" width="250" height="auto"/>
        </div>
      </div>
    </b-row>
    <div class="row mt-5">
      <div class="col-md-12 text-center">
        <nav aria-label="Page navigation" class="text-center">
          <ul class="pagination">
            <li class="page-item active">
              <a class="page-link" @click="page=page-1">&lt;</a>
            </li>
            <li class="page-item" v-for="(item, index) in pages" v-bind:key="index">
              <a class="page-link" @click="getPosts(0)">{{ item + 1 }}</a>
            </li>
            
            
            <li class="page-item">
              <a class="page-link" @click="getPosts(page+1)">&gt;</a>
            </li>
          </ul>
        </nav>
      </div>
    </div>
  </b-container>
</template>
<script>
import Router from 'vue-router';
import axios from '../common/axios';
const postApiUrl = `${process.env.ROOT_API}/posts`;
export default {
  data() {
    return { 
      posts: [],
      page: 0,
      pages: [],
      totalPages: 0
    };
  },
  methods: {
    getPosts(page) {
      axios.get(`${postApiUrl}?page=${page}`).then((response) => {
      this.posts = response.data;
      this.page = page;
      this.pages = [...Array(response.data.total_pages).keys()];
    })
    .catch((err) => {
      console.log(err);
    });
    }
  },
  mounted(){
    axios.get(`${postApiUrl}?page=${this.page}`)
    .then((response) => {
      this.posts = response.data.posts;
      this.totalPages = response.data.total_pages;
      this.pages = [...Array(response.data.total_pages).keys()]
    })
    .catch((err) => {
      console.log(err);
    });
  }
}
</script>
