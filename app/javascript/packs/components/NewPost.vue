<template>
  <b-container fluid>
    <b-form class="mw-100">
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><b-input-group><b-form-input placeholder="Post title" /></b-input-group></b-col></b-form-row>
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><vue-editor v-model="content" /></b-col></b-form-row>
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><b-button type="submit" variant="primary">Save</b-button></b-col></b-form-row>
    </b-form>
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

