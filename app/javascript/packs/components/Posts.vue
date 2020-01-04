<template>
  <b-container>
    <div class="app-header">
      <div class="relative-search">
        <label for="search_query" class="sr-only">Search for:</label>
        <input
          placeholder="Search for..."
          v-model="terms"
          name="search_query"
          type="text"
          v-on:keyup.enter="getPosts(0)"
          class="form-control input-focus all-animate w-100 bg-white db shadow-inset-2 ba bw1 br2 pv3 pl4 pr6 lh-solid sans-serif b--gray3 fw6 f5 gray7"
        />
        <!---->
        <svg
          aria-hidden="true"
          focusable="false"
          data-prefix="fas"
          data-icon="search"
          role="img"
          xmlns="http://www.w3.org/2000/svg"
          viewBox="0 0 512 512"
          class="o-15 absolute center-v right-1 pe-none svg-inline--fa fa-search fa-w-16 fa-fw fa-lg search-icon"
        >
          <path
            fill="rgba(44,99,88,0.7)"
            d="M505 442.7L405.3 343c-4.5-4.5-10.6-7-17-7H372c27.6-35.3 44-79.7 44-128C416 93.1 322.9 0 208 0S0 93.1 0 208s93.1 208 208 208c48.3 0 92.7-16.4 128-44v16.3c0 6.4 2.5 12.5 7 17l99.7 99.7c9.4 9.4 24.6 9.4 33.9 0l28.3-28.3c9.4-9.4 9.4-24.6.1-34zM208 336c-70.7 0-128-57.2-128-128 0-70.7 57.2-128 128-128 70.7 0 128 57.2 128 128 0 70.7-57.2 128-128 128z"
            class
          />
        </svg>
      </div>
    </div>

    <div v-if="authenticated" class="row mt-5">
      <div class="col-md-12 mb-5 float-left">
        <router-link class="btn btn-primary" :to="{ name: 'NewPost'}">
          <i class="fa fa-plus"></i> Add Post
        </router-link>
      </div>
    </div>
    <hr />
    <h5>Latest Posts</h5>
    <hr />
    <div class="post-container">
      <div class="card-wrapper" v-for="post in posts" v-bind:key="post.id">
        <div class="border-wrapper" v-if="authenticated||(!post.is_private)">
          <router-link :to='{name: "Post", params: {"postId": post.slug}}'
                class="post-title"
                >{{ post.title }}</router-link>
          
          <div class="post-desc">
            <div class="cover-wrapper">
                <img class="cover" :src="post.thumbnail">
              </div>
            <div class="post-short-desc">
              {{post.description}}
            </div>
            <router-link
                  :to='{name: "Post", params: {"postId": post.slug}}'
                  class="post-item"
                >Read more...</router-link>
          </div>
        </div>
      </div>
    </div>

    <div class="row mt-5">
      <div class="col-md-12 text-center">
        <nav aria-label="Page navigation" class="text-center">
          <ul class="pagination">
            <li class="page-item">
              <button class="page-link" :disabled="page===0" @click="getPreviousPosts()">&lt;</button>
            </li>
            <li
              class="page-item"
              v-bind:class="{ active: page===index }"
              v-for="(item, index) in pages"
              v-bind:key="index"
            >
              <button class="page-link" @click="getPosts(index)">{{ item + 1 }}</button>
            </li>

            <li class="page-item">
              <button
                class="page-link"
                :disabled="page===(totalPages-1)"
                @click="getNextPosts()"
              >&gt;</button>
            </li>
          </ul>
        </nav>
      </div>
    </div>
  </b-container>
</template>
<script>
import Router from "vue-router";
import axios from "axios";
const postApiUrl = `${process.env.ROOT_API}/posts`;
export default {
  data() {
    return {
      terms: null
    };
  },
  mounted() {
    this.$store.dispatch("getPosts", { page: this.page, terms: this.terms });
  },
  computed: {
    totalPages() {
      return this.$store.state.total_pages;
    },
    page() {
      return this.$store.state.current_post_page;
    },
    pages() {
      return [...Array(this.$store.state.total_pages).keys()];
    },
    posts() {
      return this.$store.state.posts;
    },
    nextPage() {
      return this.page + 1 <= this.totalPages - 1
        ? this.page + 1
        : this.totalPages - 1;
    },
    previousPage() {
      return this.page - 1 < 0 ? 0 : this.page - 1;
    },
    authenticated() {
      return this.$store.state.authenticated;
    }
  },
  methods: {
    getPosts(page) {
      this.$store.dispatch("getPosts", { page: page, terms: this.terms });
    },
    getNextPosts() {
      this.$store.dispatch("getPosts", {
        page: this.nextPage,
        terms: this.terms
      });
    },
    getPreviousPosts() {
      this.$store.dispatch("getPosts", {
        page: this.previousPage,
        terms: this.terms
      });
    }
  }
};
</script>
