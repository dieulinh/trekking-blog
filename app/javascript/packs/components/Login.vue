<template>
  <b-container>
    <b-row class="col-md-8 offset-md-2 col-sm-8 offset-sm-2">
      <div class="alert alert-danger w-100" role="alert" v-if="errors">
        <strong>{{errors}}</strong>
      </div>
    </b-row>

    <b-form class="col-md-8 offset-md-2 col-sm-8 offset-sm-2">
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><b-input-group><b-form-input placeholder="User email" v-model="email"/></b-input-group></b-col></b-form-row>
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><b-input-group><b-form-input type="password" placeholder="Password" v-model="password"/></b-input-group></b-col></b-form-row>
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><b-input-group><b-button variant="primary" :disabled="!!hasError" class="w-100" @click="loginUser">Login</b-button></b-input-group></b-col></b-form-row>
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><b-input-group><b-form-text>Not registered</b-form-text> <b-button variant="link" href="#/register">Register</b-button></b-input-group></b-col></b-form-row>
    </b-form>
  </b-container>
</template>
<script>
  import axios from '../common/axios';
  import Vue from 'vue';
  import VueSession from 'vue-session'
  Vue.use(VueSession);

  export default {
    data() {
      return { email: '', password: '', authenticated: false,
        errors: null
      };
    },
    computed: {
      hasError() {
        if (this.email!='' && this.password!='') {
        return false;
      }
      return true;
      }
    },

    methods: {
      loginUser() {
        axios.post(`${process.env.ROOT_API}/login`, { email: this.email, password: this.password })
        .then((res) => {
          if (res.data) {
              this.$session.start();
              this.$session.set('auth_token', res.data);
              this.$router.push('/posts');
          } else {
            this.errors = res.errors;
          }
        })
        .catch(err => {
          if (err.response.status === 401) {
            this.errors = "Invalid email or password";
          }
        })
      }
    }
  }
</script>
