<template>
  <b-container class="md-offset-4">
    <div class="alert alert-danger" role="alert" v-if="errors">
      <strong>{{errors}}</strong>
    </div>
    
    <b-form class="mw-100">
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><b-input-group><b-form-input placeholder="User email" v-model="email"/></b-input-group></b-col></b-form-row>
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><b-input-group><b-form-input type="password" placeholder="Password" v-model="password"/></b-input-group></b-col></b-form-row>
    </b-form>
    <b-button variant="primary" @click="loginUser" class="m-1">
      Login
    </b-button>
    <b-button class="m-1">
      Cancel
    </b-button>
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
    methods: {
      loginUser() {
        axios.post(`${process.env.ROOT_API}/login`, { email: this.email, password: this.password })
        .then((res) => {
          if ('authentication_token' in res.data) {
              this.$session.start();
              this.$session.set('auth_token', res.data.authentication_token);
              this.$router.push('/posts');
          } else {
            this.errors = res.errors;
          }
        })
        .catch(err => {
          console.log(err);
          if (err.response.status === 401) {
            this.errors = "Invalid email or password";
          }
          
        })
      }
    }
  }
</script>
