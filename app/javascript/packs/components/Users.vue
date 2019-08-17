<template>
  <b-container>
    <b-row class="container" v-if="authenticated">
      <router-link class="mb-5" :to="{ name: 'EditPost',  params: { postId: post.slug } }">Edit Post</router-link>
    </b-row>

    <div>
      <b-row v-for="(user, index) in users" :key="index">
        <div>
          <h3>
            ...And Get
            <strong>{{user.description }}</strong> Now!
          </h3>
          <ul class="freegoods-list">
            <li>
              <div class="free-good-product">
                <img
                  src="https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/6692447/90/60/m2/fpnw/wm0/1.-preview-image-01-.jpg?1563310818&amp;s=dd68e2f908b981d002f2eef71fd46021"
                  alt="Lonely Lover Font"
                />
              </div>
            </li>
            <li>
              <div class="free-good-product">
                {{ user.location }}
              </div>
            </li>
            <li>
              <div class="free-good-product">
                <img
                  src="https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/2891783/90/60/m2/fpnw/wm0/preview-rachael-cover-01-01-.jpg?1498419624&amp;s=e6f19cc51efe7481bf457ad75bbb1b89"
                  alt="Rachael Script"
                />
              </div>
            </li>
            <li>
              <div class="free-good-product">
                <img
                  src="https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/5845744/90/60/m2/fpnw/wm0/montajecm-.jpg?1549564501&amp;s=e12531d27222c8ffb4c5568f9f58215e"
                  alt="Greek Zodiac: Patterns"
                />
              </div>
            </li>
            <li>
              <div class="free-good-product">
                {{ user.location_lonlat }}
              </div>
            </li>
            <li>
              <div class="free-good-product">
                <img
                  src="https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/6304346/90/60/m2/fpnw/wm0/cover1-.jpg?1556275368&amp;s=501aa62bc6d87ceacf0137c3d35db2ea"
                  alt="Abstract Spots Block Pattern"
                />
              </div>
            </li>
          </ul>
        </div>
      </b-row>
    </div>
  </b-container>
</template>
<script>
import axios from "../common/axios";
export default {
  props: ["postId"],
  data() {
    return {
      users: {},
      authenticated: false
    };
  },
  mounted() {
    axios
      .get(`${process.env.ROOT_API}/users`)
      .then(response => {
        this.users = response.data.trekkers;
      })
      .catch(err => {
        console.log(err);
      });
  },
  beforeMount() {
    let authToken = this.$session.get("auth_token");
    if (authToken) {
      this.authenticated = true;
    }
  }
};
</script>
