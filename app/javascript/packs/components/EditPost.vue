<template>
  <b-container fluid>
    <b-row class="col-md-12">
      <div class="alert alert-danger w-100" role="alert" v-if="errors">
        <strong>{{errors}}</strong>
      </div>
    </b-row>
    <b-form class="mw-100">
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><b-input-group><b-form-input placeholder="Post title" v-model="post.title"/></b-input-group></b-col></b-form-row>
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><b-input-group><b-form-input placeholder="Post description" v-model="post.description"/></b-input-group></b-col></b-form-row>
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12">
          <b-input-group>
            <b-form-select v-model="post.category" :options="options" size="sm" class="mt-3"></b-form-select>
          </b-input-group>
        </b-col>
      </b-form-row>
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><vue-editor v-model="post.content" useCustomImageHandler @imageAdded="handleUploadImage" /></b-col></b-form-row>
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><b-button @click="handleUpdatePost" :disabled="!!hasError" variant="primary">Save</b-button></b-col></b-form-row>
    </b-form>
  </b-container>
  
</template>
<script>
import axios from '../common/axios';
import { VueEditor } from 'vue2-editor';
const postApiUrl = `${process.env.ROOT_API}/posts`;
const imageUploadUrl = `${process.env.ROOT_API}/uploads`;
export default {
  components: {
    VueEditor
  },
  props: ['postId'],
  beforeMount() {
    let authToken = this.$session.get('auth_token');
    if (authToken) {
      this.authenticated = true;
      this.authToken = authToken;
    } else {
      this.$$router.push('/#/login');
    }
  },
  computed: {
    hasError() {
      if (this.post.title!='' && this.post.content!='') {
        return false;
      }
      return true;
    }
  },
  data() {
    return {
      post: {},
      errors: null,
      auth_token: null,
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
  mounted() {
    axios.get(`${process.env.ROOT_API}/posts/${this.postId}`).then((response) => {
      this.post = response.data;
    }).catch((err) => {
      console.log(err);
    });
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
    handleUpdatePost() {
      console.log(this.postId);
      axios.put(`${postApiUrl}/${this.postId}`, { title: this.post.title, category: this.post.category, description: this.post.description, auth_token: this.authToken, content: this.post.content }).then((response) => {
        this.$router.push(`/posts/${this.postId}`);
      }).catch((err) => {
        console.log(`Error: ${err}`);
        if (err.response.status === 401) {
          this.errors = "Unauthorize! Please login";
        }
      });
    }
  }
}
</script>
