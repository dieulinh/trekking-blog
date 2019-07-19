<template>
  <b-container fluid>
    <b-form class="mw-100">
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><b-input-group><b-form-input placeholder="Post title" v-model="title"/></b-input-group></b-col></b-form-row>
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><b-input-group><b-form-input placeholder="Post description" v-model="description"/></b-input-group></b-col></b-form-row>
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12">
          <b-input-group>
            <b-form-select v-model="category" :options="options" size="sm" class="mt-3"></b-form-select>
          </b-input-group>
        </b-col>
      </b-form-row>
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><vue-editor v-model="content" useCustomImageHandler @imageAdded="handleUploadImage" /></b-col></b-form-row>
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><b-button @click="handlePost" :disabled="!!hasError" variant="primary">Save</b-button></b-col></b-form-row>
    </b-form>
  </b-container>
  
</template>

<script>
import Vue from 'vue';
import VueSession from 'vue-session';
import sanitizeHtml from 'sanitize-html';
import axios from '../common/axios';
import { VueEditor } from 'vue2-editor';

Vue.use(VueSession);
const postApiUrl = `${process.env.ROOT_API}/posts`;
const imageUploadUrl = `${process.env.ROOT_API}/uploads`;
export default {
   components: {
    VueEditor
  },
  data() {
    return {
      title: '',
      description: '',
      content: '',
      category: null,
      // :travel, :health, :food, :beauty, :green, :technology, :music, :design, :art,
      //  :education, :psychology, :fashion, :photography, :culture, :politic, :history, :science, 
      // :movie, :lifestyle, :sport, :freelance, :wildlife, :seo
      options: [
        { value: null, text: 'Please select post category', disabled: true },
        { value: 'travel', text: 'Travel' },
        { value: 'health', text: 'Health' },
        { value: 'lifestyle', text: 'Life Style' },
        { value: 'food', text: 'Food' },
        { value: 'beauty', text: 'Beauty' },
        { value: 'psychology', text: 'Psychology' },
        { value: 'photography', text: 'Photography' },
        { value: 'technology', text: 'Technology' },
        { value: 'culture', text: 'Culture' },
        { value: 'politic', text: 'Politic' },
        { value: 'art', text: 'Art' },
        { value: 'wildlife', text: 'Wild Life'},
        { value: 'design', text: 'Design' },
        { value: 'music', text: 'Music' },
        { value: 'seo', text: 'SEO' },
        { value: 'movie', text: 'Movie' },
        { value: 'sport', text: 'Sport' },
        { value: 'green', text: 'Go Green' },
        { value: 'fashion', text: 'Fashion' },
        { value: 'science', text: 'Science' },
        { value: 'history', text: 'History' },
        { value: 'freelance', text: 'Freelance' },
        { value: 'language', text: 'Languages' },
        { value: 'education', text: 'Education' }
      ]
    }
  },
  beforeMount() {
    let authToken = this.$session.get('auth_token');
    if (!authToken) {
      this.$router.push('/login');
    }
  },
  mounted() {
    
  },
  computed: {
    hasError() {
      if (this.title!='' && this.content!='') {
        return false;
      }
      return true;
    }
  },
  methods: {
    handleUploadImage(file, Editor, cursorLocation, resetUploader) {
      var formData = new FormData();
      formData.append("file", file);
      axios.post(imageUploadUrl, formData, {
          headers: {
            'Content-Type': 'multipart/form-data'
          }
      })
      .then((result) => {
        let url = result.data // Get url from response
        Editor.insertEmbed(cursorLocation, 'image', url);
        resetUploader();  
      })
      .catch((err) => {
        console.log(err);
      })
    },
    handlePost() {
      axios.post(postApiUrl, { title: this.title, category: this.category, description: this.description, user_id: 1, content: this.content }).then((response) => {
        this.$router.push(`/posts/${response.data.slug}`);
      }).catch((err) => {
        console.log(`Error: ${err}`);
      });
    }
  }
}
</script>

