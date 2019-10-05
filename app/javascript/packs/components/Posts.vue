<template>
  <b-container>
    <div v-if="authenticated" class="row mt-5">
      <div class="col-md-12 mb-5 float-left">
        <router-link class="btn btn-primary" :to="{ name: 'NewPost'}">
          + Create Post
        </router-link>
      </div>
    </div>
    <div v-for="post in posts" v-bind:key="post.id">
      <article class="post">
        <div class="post-header">
          <div class="bg-category">
            <div class="category-name">
              <span class="text-title">
                <router-link :to='{name: "Post", params: {"postId": post.slug}}'
                class="post-category"
                >{{ post.category }}</router-link>
              </span>
            </div>
          </div>
          <h4>
            <span class="text-title">
              <router-link
                :to='{name: "Post", params: {"postId": post.slug}}'
              >{{ post.title }}</router-link>
            </span>
          </h4>
          <div class="category-date">By Eager Trekker - {{ post.updated_at | formatDate }}</div>
        </div>
        <div id="summary331550993429040912" style="display: block;">
          <div class="post-image" v-if="post.thumb_url">
            <img width="100%" height="450" v-bind:src="post.thumb_url" />
          </div>
          <div class="post-entry">
            {{post.description}}
            <p>
              <router-link
                :to='{name: "Post", params: {"postId": post.slug}}'
                rel="tag nofollow"
              >Continue Reading</router-link>
            </p>
          </div>
        </div>
      </article>
    </div>

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
      console.log(response.data.posts);
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
