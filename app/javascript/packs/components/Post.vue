<template>
  <div>
    <div class="post-nav">
      <button type="button" class="btn btn-default" @click="goBack()"><i class="fa fa-arrow-left" aria-hidden="true"></i>&nbsp; Back</button>
      <router-link v-if="authenticated" class="btn btn-primary" :to="{ name: 'EditPost',  params: { postId: post.slug } }">
        <i class="fa fa-pencil"></i> Edit Post
      </router-link>
    </div>
    <div v-html="post.content" class="post-content"></div>
    <div>
      <hr>
      <div><strong>Comments:</strong></div>
      <p v-for="com in post.comments" :key="com.id">{{com.body}}</p>
      <div><strong>Your comment:</strong></div>
      <input type="text" class="form-control" v-model="comment" @keyup.enter="saveComment"/>
    </div>
  </div>
  
</template>
<script>
import axios from '../common/axios';
export default {
  props: ['postId'],
  data() {
    return {
      comment: null,
      post: {}
    }
  },
  computed: {
    auth_token() {
      return this.$store.state.auth_token;
    },
    authenticated() {
      return this.$store.state.authenticated;
    }
  },
  methods: {
    goBack() {
      history.back();
    },
    saveComment() {
      axios.post(`${process.env.ROOT_API}/posts/${this.postId}/comments/`, {
        body: this.comment,
        headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${this.auth_token}`
          }
      }).then((response) => {
      this.comment = response.data.body;
      }).catch((err) => {
        console.log(err);
      });
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
