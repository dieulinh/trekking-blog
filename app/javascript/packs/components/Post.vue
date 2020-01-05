<template>
  <div>
    <div class="post-nav">
      <button type="button" class="btn btn-default" @click="goBack()"><i class="fa fa-arrow-left" aria-hidden="true"></i>&nbsp; Back</button>
      <router-link v-if="authenticated" class="btn btn-primary" :to="{ name: 'EditPost',  params: { postId: post.slug } }">
        <i class="fa fa-pencil"></i> Edit Post
      </router-link>
    </div>
    <div v-html="post.content" class="post-content"></div>
  </div>
  
</template>
<script>
import axios from '../common/axios';
export default {
  props: ['postId'],
  data() {
    return {
      post: {}
    }
  },
  computed: {
    authenticated() {
      return this.$store.state.authenticated;
    }
  },
  methods: {
    goBack() {
      history.back();
    }
  },
  mounted() {
    axios.get(`${process.env.ROOT_API}/posts/${this.postId}`).then((response) => {
      this.post = response.data;
    }).catch((err) => {
      console.log(err);
    });
  }
}
</script>
