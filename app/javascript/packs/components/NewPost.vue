<template>
  <b-container>
    <b-input placeholder="Post title" />
    <vue-editor v-model="content" />
    <b-button class="btn btn-primary">Save</b-button>
  </b-container>
</template>

<script>
import { VueEditor } from 'vue2-editor';
export default {
   components: {
    VueEditor
  },
  data() {
    return {
         content: '<h1>Some initial content</h1>'
       }
  },
  mounted() {
    
  },
  
}
</script>

