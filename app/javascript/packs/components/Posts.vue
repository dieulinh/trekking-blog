<template>
  <div class="main-post-content">
    <div class="page-content">
      <news-component v-if="currentNews"></news-component>
      <div class="app-header" v-if="!news">
        <div class="relative-search">
          <input
            placeholder="Search for..."
            v-model="terms"
            name="search_query"
            type="text"
            v-on:keyup.enter="getPosts(0)"
            class="search-box all-animate w-100 bg-white db sans-serif"
          />
          <span class="s-icon">
            <svg
              aria-hidden="true"
              focusable="false"
              data-prefix="fas"
              data-icon="search"
              role="img"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 512 512"
              class="svg-inline--fa fa-search fa-w-16 fa-fw fa-lg search-icon"
            >
              <path
                fill="rgba(44,99,88,0.7)"
                d="M505 442.7L405.3 343c-4.5-4.5-10.6-7-17-7H372c27.6-35.3 44-79.7 44-128C416 93.1 322.9 0 208 0S0 93.1 0 208s93.1 208 208 208c48.3 0 92.7-16.4 128-44v16.3c0 6.4 2.5 12.5 7 17l99.7 99.7c9.4 9.4 24.6 9.4 33.9 0l28.3-28.3c9.4-9.4 9.4-24.6.1-34zM208 336c-70.7 0-128-57.2-128-128 0-70.7 57.2-128 128-128 70.7 0 128 57.2 128 128 0 70.7-57.2 128-128 128z"
                class
              />
            </svg>
          </span>
          
        </div>
      </div>
      <div class="app-header" v-if="news">
        <h1>Hacker News</h1>
        <hr/>
      </div>

      <div v-if="authenticated" class="row mt-5">
        <div class="col-md-12 mb-5 float-left">
          <router-link class="btn btn-primary" :to="{ name: 'NewPost'}">
            <i class="fa fa-plus"></i> Add Post
          </router-link>
        </div>
      </div>
      <div class="post-container">
        <div class="card-wrapper" v-for="post in posts" v-bind:key="post.id" v-show="authenticated||(!post.is_private)">
          <router-link v-if="!news"
                    :to='{name: "Post", params: {"postId": post.slug}}'
                  >
            <div class="border-wrapper">
              <h1 class="post-title">{{ post.title }}</h1>

              <div class="post-desc">
                <div class="cover-wrapper" v-if="post.thumb_url">
                  <img class="cover" :src="post.thumb_url">
                </div>
                <div class="cover-wrapper" v-if="!post.thumb_url">
                  <img class="cover" :src="post.post_cover||emptyImage">
                </div>
                <div class="post-short-desc" v-html="post.description">
                </div>
              </div>
              <div class="read-more">
                {{ post.updated_at | formatDate }}
              </div>
            </div>
          </router-link>
          <div v-if="news">
            <div class="border-wrapper" @click="getNewsDetail(post.link)">
              <h1 class="post-title">{{ post.title }}</h1>

              <div class="post-desc">
                <div class="cover-wrapper" v-if="post.thumb_url">
                  <img class="cover" :src="post.thumb_url">
                </div>
                <div class="cover-wrapper" v-if="!post.thumb_url">
                  <img class="cover" :src="emptyImage">
                </div>
                <div class="post-short-desc" v-html="post.description">
                </div>
                <a href="javascript:void(0);" class="read-more">
                 Posted: {{post.updated_at | formatDate}}
                </a>

              </div>
            </div>
          </div>
        </div>
      </div>
      <div v-if="!news" class="paging-wrapper">
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
      </div>
    </div>
    <div class="right-sidebar">
      <ul>
        <li class="category"><a href="javascript:void();" @click="getTechnologyPosts('technology')">Technology</a></li>
        <li class="category"><a href="javascript:void();" @click="getTechnologyPosts('green')">Green</a></li>
        <li class="category"><a href="javascript:void();" @click="getTechnologyPosts('science')">Science</a></li>
        <li class="category"><a href="javascript:void();" @click="getTechnologyPosts('education')">Education</a></li>
        <li class="category"><a href="javascript:void();" @click="getTechnologyPosts('travel')">Travel</a></li>
        <li class="category"><a @click="getTechnologyPosts('art')" href="javascript:void();">Art</a></li>
      </ul>
    </div>
  </div>
</template>
<script>
import Router from "vue-router";
import axios from "axios";
import NewsComponent from './PostReader';
const postApiUrl = `${process.env.ROOT_API}/posts`;
export default {
  components : { NewsComponent },
  data() {
    return {
      terms: null,
      emptyImage: require('../assets/images/see-no-evil-monkey_1f648.png')
    };
  },
  mounted() {
    this.start();
    if (this.news) {
      this.$store.dispatch("getNews");
    } else {
      this.$store.dispatch("getPosts", { page: this.page, terms: this.$store.state.searchTerm }).then((data)=>{
        this.finish();
      }).catch((err)=> {
        this.fail();
      });
    }

  },
  computed: {
    searchTerm() { return this.terms | this.$store.state.searchTerm; },
    currentNews() { return this.$store.state.current_news; },
    news() {return this.$store.state.news; },
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
    start () {
      console.log('ever start');
        this.$Progress.start();
    },
    set (num) {
        this.$Progress.set(num)
    },
    increase (num) {
        this.$Progress.increase(num)
    },
    decrease (num) {
        this.$Progress.decrease(num)
    },
    finish () {
        this.$Progress.finish()
    },
    fail () {
        this.$Progress.fail()
    },
    showLog() {
      console.log('you click it, don\'t you?');
    },
    getNewsDetail(newsUrl) {
      console.log('You gonna see news content from hacker news');
      this.$store.dispatch('getPostDetail', {postUrl: newsUrl});
    },
    getTechnologyPosts(category) {
      this.$store.dispatch("getPosts", { page: 1, category: category});
    },
    getPosts(page) {
      this.start();
      var posts = this.$store.dispatch("getPosts", { page: page, terms: this.terms });
      try {
        this.$Progress.finish();
      } catch(err) {
        this.$Progress.fail();
      }
      posts.success((data)=> {
        this.$Progress.finish();
      }).error((err) => {
        this.$Progress.fail();
      })
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
