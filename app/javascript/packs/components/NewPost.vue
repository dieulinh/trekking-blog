<template>
  <b-container fluid>
    <b-form class="mw-100">
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><b-input-group><b-form-input placeholder="Post title" v-model="title"/></b-input-group></b-col></b-form-row>
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><b-input-group><b-form-input placeholder="Post description" v-model="description"/></b-input-group></b-col></b-form-row>
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><vue-editor v-model="content" /></b-col></b-form-row>
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><b-button @click="handlePost" variant="primary">Save</b-button></b-col></b-form-row>
    </b-form>
  </b-container>
  
</template>

<script>
import sanitizeHtml from 'sanitize-html';
 
var dirty = 'some really tacky HTML';
var clean = sanitizeHtml(dirty);

import axios from '../common/axios';
import { VueEditor } from 'vue2-editor';
const postApiUrl = `${process.env.ROOT_API}/posts`;
export default {
   components: {
    VueEditor
  },
  data() {
    return {
      title: '',
      content: 'Some initial content',
      description: ''
    }
  },
  mounted() {
    
  },
  methods: {
    handlePost() {
      axios.post(postApiUrl, { title: this.title, description: this.description, user_id: 1, content: sanitizeHtml(this.content)}).then((response) => {
      }).catch((err) => {
        console.log(`Error: ${err}`);
      });
    }
  }
}
</script>

