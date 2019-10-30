<template>
  <b-container fluid>
    <b-form class="mw-100">
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><b-input-group><b-form-input placeholder="Trekker's Name" v-model="trekker_name"/></b-input-group></b-col></b-form-row>
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><b-input-group><b-form-input placeholder="Location" v-model="location"/></b-input-group></b-col></b-form-row>
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><b-input-group><b-form-input placeholder="Longitude" v-model="lon"/></b-input-group></b-col></b-form-row>
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><b-input-group><b-form-input placeholder="Latitude" v-model="lat"/></b-input-group></b-col></b-form-row>
   
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12">
          <b-input-group>
            <b-form-select v-model="role" :options="options" size="sm" class="mt-3"></b-form-select>
          </b-input-group>
        </b-col>
      </b-form-row>
      <b-form-row md="12" sm="12" xs="10" class="mb-2">
         <GoogleMap />
      </b-form-row>
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><vue-editor v-model="description" useCustomImageHandler @imageAdded="handleUploadImage" /></b-col></b-form-row>
      
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><b-button @click="handlePost" :disabled="!!hasError" variant="primary">Save</b-button></b-col></b-form-row>
    </b-form>
  </b-container>
  
</template>

<script>
import Vue from 'vue';
import VueSession from 'vue-session';
import axios from '../common/axios';

import { VueEditor } from 'vue2-editor';
import GoogleMap from './Map.vue';

Vue.use(VueSession);
const userApiUrl = `${process.env.ROOT_API}/users`;
const imageUploadUrl = `${process.env.ROOT_API}/uploads`;
export default {
   components: {
    VueEditor, GoogleMap
  },
  data() {
    return {
      user: '',
      description: '',
      trekker_name: '',
      lon: null,
      lat: null,
      location: '',
      role: null,
      options: [
        { value: null, text: 'Please select trekker category', disabled: true },
        { value: 'diver', text: 'Diver' },
        { value: 'trekker', text: 'Trekker' },
        { value: 'photographer', text: 'Photographer' }, 
        { value: 'dive_master', text:'Dive Master' },
        { value: 'tour_guide', text: 'Tour Guide' },
        { value: 'cook', text: 'Cook' }
      ]
    }
  },
  computed: {
    hasError() {
      if (this.trekker_name!='' && this.description!='') {
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
      axios.post(userApiUrl, { trekker_name: this.trekker_name, lat: this.lat, lon: this.lon, location: this.location, role: this.role, description: this.description, auth_token: this.authToken, content: this.content }).then((response) => {
        this.$router.push(`/users`);
      }).catch((err) => {
        console.log(`Error: ${err}`);
      });
    }
  }
}
</script>

