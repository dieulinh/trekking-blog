<template>
  <b-container>
    <div v-if="authenticated" class="row mt-5">
      <div class="col-md-12 mb-5 float-left">
        <router-link class="btn btn-primary" :to="{ name: 'NewPost'}">
          + Create Post
        </router-link>
      </div>
    </div>
    <b-row v-for="(post, index) in posts" :key="index">
      <div class="row col-md-12 no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-100 position-relative">
        <div class="col p-4 d-flex flex-column position-static">
          <span class="d-inline-block mb-2 text-primary text-title post-category">{{ post.category }}</span>
          <h5 class="mb-0" >{{ post.title }}</h5>
          <div class="mb-1 text-muted">{{ post.updated_at }}</div>
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
            <li class="page-item">
              <button class="page-link" :disabled="page===0" @click="getPosts(previousPage)">&lt;</button>
            </li>
            <li class="page-item" v-bind:class="{ active: page===index }" v-for="(item, index) in pages" v-bind:key="index">
              <button class="page-link" @click="getPosts(index)">{{ item + 1 }}</button>
            </li>

            <li class="page-item">
              <button class="page-link" :disabled="page===(totalPages-1)" @click="getPosts(nextPage)">&gt;</button>
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
      totalPages: 0,
      authenticated: false
    };
  },
  beforeMount() {
    let authToken = this.$session.get('auth_token');
    if (authToken) {
      this.authenticated = true;
    }
  },
  mounted(){
    axios.get(`${postApiUrl}?page=${this.page+1}`)
    .then((response) => {
      this.posts = response.data.posts;
      this.totalPages = response.data.total_pages;
      this.pages = [...Array(response.data.total_pages).keys()]
    })
    .catch((err) => {
      console.log(err);
    });
  },
  computed: {
    nextPage() {
      return (this.page+1<=(this.totalPages - 1) ? this.page+1 : this.totalPages - 1);
    },
    previousPage() {
      return (this.page-1<0 ? 0 : this.page - 1);
    }
  },
  methods: {
    getPosts(page) {
      axios.get(`${postApiUrl}?page=${page+1}`).then((response) => {
      this.posts = response.data.posts;
      this.page = page;
      this.pages = [...Array(response.data.total_pages).keys()];
    })
    .catch((err) => {
      console.log(err);
    });
    }
  }
}
</script>
