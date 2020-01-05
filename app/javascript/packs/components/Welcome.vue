<template>
  <div>
    <posts-component/>
  </div>
</template>

<script>
import axios from "../common/axios";
import PostsComponent from './Posts.vue';

export default {
  components: {
    PostsComponent
  }
};
</script>
