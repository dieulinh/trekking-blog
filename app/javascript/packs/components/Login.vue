<template>
  <b-container>
    <b-row class="col-md-8 offset-md-2 col-sm-8 offset-sm-2">
      <div class="alert alert-danger w-100" role="alert" v-if="errors">
        <strong>{{errorMessage}}</strong>
      </div>
    </b-row>

    <b-form class="col-md-8 offset-md-2 col-sm-8 offset-sm-2" v-if="!authenticated || (!userAuthenticated)">
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><b-input-group><b-form-input placeholder="User email" v-model="email"/></b-input-group></b-col></b-form-row>
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><b-input-group><b-form-input type="password" placeholder="Password" v-model="password"/></b-input-group></b-col></b-form-row>
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><b-input-group><b-button variant="primary" :disabled="!!hasError" class="w-100" @click="loginUser">Login</b-button></b-input-group></b-col></b-form-row>
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><b-input-group><b-form-text>Not registered</b-form-text> <b-button variant="link" href="#/register">Register</b-button></b-input-group></b-col></b-form-row>
    </b-form>
  </b-container>
</template>
<script>
  import axios from 'axios';
  import Vue from 'vue';
  import VueSession from 'vue-session'
  Vue.use(VueSession);

  export default {
    data() {
      return { email: '', password: '', authenticated: false,
        errors: null
      };
    },
    beforeCreate() {
      var authToken = localStorage.getItem('auth_token');
      if(authToken) {
        this.$store.dispatch('authenticate', authToken)
        .then(result => {
          this.authenticated = true;
          this.$router.push('/');
        })
      }
    },
    computed: {
      userAuthenticated() {
        console.log(this.$store);
        return this.$store.state.errors == null && this.$store.state.authenticated;
      },
      errorMessage() {
         return this.$store.state.errors.message;
      },
      hasError() {
        if (this.email!='' && this.password!='') {
        return false;
      }
      return true;
      }
    },

    methods: {
      loginUser() {
        let email = this.email;
        let password = this.password;
        console.log('login in component');
        
          this.$store.dispatch('login', { email, password})
          .then(result => {
            console.log('result: ', result)
            this.authenticated = true;
            this.$router.push('/');
          })
        .catch( (err) => {
          this.errors = err.response.data.message
        })
        
        // .then((res)=> {
        //   console.log(res);
        //   this.authenticated = true;
        //   this.$router.push('/')
        // })
        // .catch((err) => {
        //   console.log(err);
        //   console.log(err.response);
        //   this.errors = err.response.data.message
        // })
      }
    }
  }
</script>
