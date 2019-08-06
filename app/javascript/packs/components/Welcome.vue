<template>
  <div class="container">
    <div class="container">
      <h5>
        Latest Posts
      </h5>
      <hr/>
    </div>
    <div class="container sp_sidebar">
      <div class="section" id="main">
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
                <h3>
                  <span class="text-title">
                    <router-link
                      :to='{name: "Post", params: {"postId": post.slug}}'
                    >{{ post.title }}</router-link>
                  </span>
                </h3>
                <div class="category-date">By rina chaudhary - {{ post.updated_at }}</div>
              </div>
              <div id="summary331550993429040912" style="display: block;">
                <div class="post-image">
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
      <div class="section" id="sidebar">
        <div class="widget Text" data-version="1" id="Text1">
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
                <a href="http://facebook.com">
                  <i class="fa fa-facebook"></i>facebook
                </a>
              </li>
              <li>
                <a href="http://twitter.com">
                  <i class="fa fa-twitter"></i>twitter
                </a>
              </li>
              <li>
                <a href="http://instagram.com">
                  <i class="fa fa-instagram"></i>instagram
                </a>
              </li>
              <li>
                <a href="http://pinterest.com">
                  <i class="fa fa-pinterest-p"></i>pinterest
                </a>
              </li>
              <li>
                <a href="http://bloglovin.com">
                  <i class="fa fa-heart"></i>bloglovin
                </a>
              </li>
              <li>
                <a href="http://etsy.com">
                  <i class="fa fa-shopping-cart"></i>etsy
                </a>
              </li>
            </ul>
            <div class="clear"></div>
            <span class="widget-item-control">
              <span class="item-control blog-admin">
                <a class="quickedit" href="#" rel="nofollow" target="configLinkList2" title="Edit">
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
        </div>
        <div class="widget HTML" data-version="1" id="HTML3">
          <h2 class="title">
            <span>Sponsor</span>
          </h2>
          <div class="widget-content">
            <img
              src="https://4.bp.blogspot.com/-nE6P6f80Tws/WM_O2ZZKzBI/AAAAAAAAAVI/qkUP8D_SEPI3W1297ENQw1UkJxpn7lZxgCPcB/s1600/add.jpeg"
              style="width:100%"
            />
          </div>
          <div class="clear"></div>
          <span class="widget-item-control">
            <span class="item-control blog-admin">
              <a
                class="quickedit"
                href="#"
                rel="nofollow"
                target="configHTML3"
                title="Edit"
              >
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
        <div class="widget Label" data-version="1" id="Label1">
          <h2>
            <span>Labels</span>
          </h2>
          <div class="widget-content list-label-widget-content">
            <ul>
              <li>
                <a dir="ltr" href="#">Fashion</a>
              </li>
              <li>
                <a dir="ltr" href="#">Food</a>
              </li>
              <li>
                <a dir="ltr" href="#">Nature</a>
              </li>
            </ul>
            <div class="clear"></div>
            <span class="widget-item-control">
              <span class="item-control blog-admin">
                <a class="quickedit" href="#" rel="nofollow" target="configLabel1" title="Edit">
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
        </div>
        <div class="widget HTML" data-version="1" id="HTML4">
          <h2>
            <span>recent posts</span>
          </h2>
          <ul class="side-newsfeed">
            <li v-for="post in posts" v-bind:key="post.slug">
              <div class="side-item">
                <div class="side-image">
                  <a href="#/2015/03/papilion-minter-savior.html">
                    <img width="150" height="100" v-bind:src="post.thumb_url" />
                  </a>
                </div>
                <div class="side-item-text">
                  <h4>
                    <a href="#/2015/03/papilion-minter-savior.html">Papilion Minter Savior</a>
                  </h4>
                  <span class="side-item-meta">{{ post.updated_at }}</span>
                </div>
              </div>
            </li>
          </ul>
        </div>
        <div class="widget BlogArchive" data-version="1" id="BlogArchive1">
          <h2>
            <span>Blog Archive</span>
          </h2>
          <div class="widget-content">
            <div id="ArchiveList">
              <div id="BlogArchive1_ArchiveList">
                <ul class="hierarchy">
                  <li class="archivedate expanded">
                    <a class="toggle" href="javascript:void(0)">
                      <span class="zippy toggle-open">▼&nbsp;</span>
                    </a>
                    <a class="post-count-link" href="#/2015/">2015</a>
                    <span class="post-count" dir="ltr">(5)</span>
                    <ul class="hierarchy">
                      <li class="archivedate expanded">
                        <a class="toggle" href="javascript:void(0)">
                          <span class="zippy toggle-open">▼&nbsp;</span>
                        </a>
                        <a class="post-count-link" href="#/2015/03/">March</a>
                        <span class="post-count" dir="ltr">(5)</span>
                        <ul class="posts">
                          <li>
                            <a href="#/2015/03/papilion-minter-savior.html">Papilion Minter Savior</a>
                          </li>
                          <li>
                            <a href="#/2015/03/draught-vaein-mynel.html">Draught Vaein Mynel</a>
                          </li>
                          <li>
                            <a href="#/2015/03/right-path-mystery.html">Right Path Mystery</a>
                          </li>
                          <li>
                            <a href="#/2015/03/my-style-statement.html">My Style Statement</a>
                          </li>
                          <li>
                            <a
                              href="#/2015/03/ways-to-remember-something.html"
                            >Ways to remember Something</a>
                          </li>
                        </ul>
                      </li>
                    </ul>
                  </li>
                </ul>
                <ul class="hierarchy">
                  <li class="archivedate collapsed">
                    <a class="toggle" href="javascript:void(0)">
                      <span class="zippy">►&nbsp;</span>
                    </a>
                    <a class="post-count-link" href="#/2014/">2014</a>
                    <span class="post-count" dir="ltr">(5)</span>
                    <ul class="hierarchy">
                      <li class="archivedate collapsed">
                        <a class="toggle" href="javascript:void(0)">
                          <span class="zippy">►&nbsp;</span>
                        </a>
                        <a class="post-count-link" href="#/2014/07/">July</a>
                        <span class="post-count" dir="ltr">(3)</span>
                      </li>
                    </ul>
                    <ul class="hierarchy">
                      <li class="archivedate collapsed">
                        <a class="toggle" href="javascript:void(0)">
                          <span class="zippy">►&nbsp;</span>
                        </a>
                        <a class="post-count-link" href="#/2014/02/">February</a>
                        <span class="post-count" dir="ltr">(2)</span>
                      </li>
                    </ul>
                  </li>
                </ul>
                <ul class="hierarchy">
                  <li class="archivedate collapsed">
                    <a class="toggle" href="javascript:void(0)">
                      <span class="zippy">►&nbsp;</span>
                    </a>
                    <a class="post-count-link" href="#/2013/">2013</a>
                    <span class="post-count" dir="ltr">(1)</span>
                    <ul class="hierarchy">
                      <li class="archivedate collapsed">
                        <a class="toggle" href="javascript:void(0)">
                          <span class="zippy">►&nbsp;</span>
                        </a>
                        <a class="post-count-link" href="#/2013/08/">August</a>
                        <span class="post-count" dir="ltr">(1)</span>
                      </li>
                    </ul>
                  </li>
                </ul>
              </div>
            </div>
            <div class="clear"></div>
            <span class="widget-item-control">
              <span class="item-control blog-admin">
                <a
                  class="quickedit"
                  href="#"
                  rel="nofollow"
                  target="configBlogArchive1"
                  title="Edit"
                >
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
        </div>
        <div class="widget Label" data-version="1" id="Label2">
          <h2>
            <span>Categories</span>
          </h2>
          <div class="widget-content cloud-label-widget-content">
            <span class="label-size label-size-1">
              <a dir="ltr" href="#/search/label/Fashion">Fashion</a>
            </span>
            <span class="label-size label-size-4">
              <a dir="ltr" href="#/search/label/Food">Food</a>
            </span>
            <span class="label-size label-size-1">
              <a dir="ltr" href="#/search/label/Nature">Nature</a>
            </span>
            <span class="label-size label-size-5">
              <a dir="ltr" href="#/search/label/vimeo">vimeo</a>
            </span>
            <div class="clear"></div>
            <span class="widget-item-control">
              <span class="item-control blog-admin">
                <a class="quickedit" href="#" rel="nofollow" target="configLabel2" title="Edit">
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
