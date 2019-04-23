<template>
  <b-container>
    <div v-html="post.content"></div>
  </b-container>
  
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
  mounted() {
    axios.get(`${process.env.ROOT_API}/posts/${this.postId}`).then((response) => {
      this.post = response.data;
    }).catch((err) => {
      console.log(err);
    });
  }
}
</script>
