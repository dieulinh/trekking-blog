<template>
  <b-container>
    <b-row class="container" v-if="authenticated">
      <router-link class="btn btn-primary" :to="{ name: 'EditPost',  params: { postId: post.slug } }">
        <i class="fa fa-pencil"></i> Edit Post
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
  beforeCreate() {
    var authToken = localStorage.getItem('auth_token');
    if(authToken) {
      this.$store.dispatch('authenticate', authToken)
      .then(result => {
        this.authenticated = true;
      })
    }
  },
}
</script>
