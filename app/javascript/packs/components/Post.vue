<template>
  <b-container>
    <b-row class="container" v-if="authenticated">
      <router-link class="mb-5" :to="{ name: 'EditPost',  params: { postId: post.slug } }">
            Edit Post
      </router-link>
    </b-row>
    <div v-html="post.content"></div>
  </b-container>
  
</template>
<script>
import axios from '../common/axios';
export default {
  props: ['postId'],
  data() {
    return {
      post: {},
      authenticated: false
    }
  },
  mounted() {
    axios.get(`${process.env.ROOT_API}/posts/${this.postId}`).then((response) => {
      this.post = response.data;
    }).catch((err) => {
      console.log(err);
    });
  },
  beforeMount() {
    let authToken = this.$session.get('auth_token');
    if (authToken) {
      this.authenticated = true;
    }
  },
}
</script>
