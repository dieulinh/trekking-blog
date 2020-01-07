<template>
  <div class="overlay">
    <div>
      <div class="post-container post-overlay">
        <button type="button" class="btn btn-default" @click="goBack()"><i class="fa fa-arrow-left" aria-hidden="true"></i>&nbsp; Back</button>
        <div class="post-view">
          <img :src="post.thumb_url" v-if="post.thumb_url" class="cover" />

          <h1>{{ post["title"] }}</h1>
          <div class="post-desc" v-html="post.description"></div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {};
  },
  methods: {
    goBack() {
      this.$store.dispatch("clearCurrentNews");
    }
  },
  computed: {
    post() {
      return this.$store.state.current_news;
    }
  },
  created() {
    console.log(this.post);
  }
};
</script>
