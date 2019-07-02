<template>
  <b-container fluid>
    <b-row>
      <b-col cols="3">Login</b-col>
      <b-col cols="4"></b-col>
      <b-col cols="4"></b-col>
    </b-row>
    
      <b-form class="mw-100">
        <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><b-input-group><b-form-input placeholder="User email" v-model="email"/></b-input-group></b-col></b-form-row>
        <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><b-input-group><b-form-input type="password" placeholder="Password" v-model="password"/></b-input-group></b-col></b-form-row>
      </b-form>
    <b-button variant="primary" class="m-1">
      Login
    </b-button>
    <b-button class="m-1">
      Cancel
    </b-button>
  </b-container>
</template>
<script>
  import BootstrapVue from 'bootstrap-vue';
  export default {
    data() {
      return { email: '', password: '', authenticated: false};
    },
    methods: {
      
    }
  }
</script>
