<template>
  <div class="container">
    <div class="container">
      <h5>
        Latest Posts
      </h5>
      <hr/>
    </div>
    <div class="container sp_sidebar">
      <div class="section col-md-8 col-sm-12" id="main">
        <div class="widget Blog" data-version="1" id="Blog1">
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
                <div class="category-date">By Eager Trekker - {{ post.updated_at }}</div>
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

              <div class="bottom-blog">
                <ul class="blog-date pull-left ccc" data-id="18">
                  <li>
                    <i class="fa fa-comment-o"></i>
                    <a href="#">4 Comments</a>
                  </li>
                </ul>
              </div>
            </article>
            <div class="cmt_iframe_holder" data-viewtype="FILTERED_POSTMOD" href="#"></div>
          </div>
          <div class="pagination">
            <div class="older">
              <a href="#">
                <span class="pager-heading">Older</span>
                <br />
                <span class="pager-title">Stories</span>
                <span class="post-nav-icon">
                  <i class="fa fa-chevron-right"></i>
                </span>
              </a>
            </div>
          </div>
        </div>
      </div>
      <div class="section col-md-4 col-sm-12" id="sidebar">
        <div class="widget Text" data-version="1" id="aboutme">
          <h2 class="title">
            <span>About me</span>
          </h2>
          <div class="widget-content">
            <center>
              <div class="about-widget">
                <img
                  alt="About Me"
                  src="https://avatars2.githubusercontent.com/u/700688?s=460&v=4"
                  width="200"
                />
                <h5>Linh Nguyen</h5>
                <p>I am a freelance Full-stack web developer.</p>
                <pre>
5+ years of experience.

Experienced working with team
or working independently.


MY SKILLS

- Ruby on Rails ( ♥ )
- Javascript (Angular, Vue, React)
- SQL (MySQL, Postgres)
- CSS (SASS/LESS)
- MongoDB
- Redis
- AWS
              </pre>
              </div>
            </center>
          </div>
          <div class="clear"></div>
          <span class="widget-item-control">
            <span class="item-control blog-admin">
              <a class="quickedit" href="#" rel="nofollow" target="configText1" title="Edit">
                <img
                  alt
                  height="18"
                  src="https://resources.blogblog.com/img/icon18_wrench_allbkg.png"
                  width="18"
                />
              </a>
            </span>
          </span>
          <div class="clear"></div>
        </div>
        <div class="widget LinkList" data-version="1" id="LinkList2">
          <h2>
            <span>Follow Us</span>
          </h2>
          <div class="widget-content">
            <ul class="site-social-networks secondary-2-primary style-default show-title">
              <li>
                <a href="https://facebook.com/eagertrekker">
                  <i class="fa fa-facebook"></i>facebook
                </a>
                <a href="http://instagram.com/linhavidtraveler">
                  <i class="fa fa-instagram"></i>instagram
                </a>
              </li>
            </ul>
            <div class="clear"></div>
          </div>
        </div>

      </div>
    </div>
  </div>
</template>

<script>
import axios from "../common/axios";
const postApiUrl = `${process.env.ROOT_API}/posts`;
export default {
  data() {
    return {
      posts: []
    };
  },
  mounted() {
    axios
      .get(`${postApiUrl}?page=1&size=5`)
      .then(response => {
        this.posts = response.data.posts;
        this.pages = [...Array(response.data.total_pages).keys()];
      })
      .catch(err => {
        console.log(err);
      });
  }
};
</script>
