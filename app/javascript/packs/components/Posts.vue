<template>
  <b-container>
    <div class="app-header">
      <div class="relative-search">
        <label for="search_query" class="sr-only">Search for:</label>
        <input placeholder="Search for..." v-model='terms' name="search_query" type="text" v-on:keyup.enter="getPosts(0)" class="form-control input-focus all-animate w-100 bg-white db shadow-inset-2 ba bw1 br2 pv3 pl4 pr6 lh-solid sans-serif b--gray3 fw6 f5 gray7"> <!----> 
        <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="search" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" class="o-15 absolute center-v right-1 pe-none svg-inline--fa fa-search fa-w-16 fa-fw fa-lg">
        <path fill="currentColor" d="M505 442.7L405.3 343c-4.5-4.5-10.6-7-17-7H372c27.6-35.3 44-79.7 44-128C416 93.1 322.9 0 208 0S0 93.1 0 208s93.1 208 208 208c48.3 0 92.7-16.4 128-44v16.3c0 6.4 2.5 12.5 7 17l99.7 99.7c9.4 9.4 24.6 9.4 33.9 0l28.3-28.3c9.4-9.4 9.4-24.6.1-34zM208 336c-70.7 0-128-57.2-128-128 0-70.7 57.2-128 128-128 70.7 0 128 57.2 128 128 0 70.7-57.2 128-128 128z" class=""></path></svg> 
      </div>
    </div>

    <div v-if="authenticated" class="row mt-5">
      <div class="col-md-12 mb-5 float-left">
        <router-link class="btn btn-primary" :to="{ name: 'NewPost'}">
          + Create Post
        </router-link>
      </div>
    </div>
    <hr />
    <h5>
      Latest Posts
    </h5>
    <hr />
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
      terms: null,
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
      let pageParams = `page=${page+1}`;
      if (this.terms) {
        pageParams = `terms=${this.terms}&page=${page+1}`;
      }
      
      axios.get(`${postApiUrl}?${pageParams}`).then((response) => {
        console.log(response.data);
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
