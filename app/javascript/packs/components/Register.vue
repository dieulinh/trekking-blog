<template>
  <b-container>
    <b-row class="col-md-8 offset-md-2 col-sm-8 offset-sm-2">
      <div class="alert alert-danger" role="alert" v-if="errors">
        <strong>{{errors}}</strong>
      </div>
    </b-row>
   
    <b-form class="col-md-8 offset-md-2 col-sm-8 offset-sm-2">
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><b-input-group><b-form-input placeholder="User email" v-model="email"/></b-input-group></b-col></b-form-row>
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><b-input-group><b-form-input type="password" placeholder="Password" v-model="password"/></b-input-group></b-col></b-form-row>
      <b-form-row md="12" sm="12" xs="10" class="mb-2"><b-col cols="12"><b-input-group><b-form-input type="password" placeholder="Password confirmation" v-model="password_confirmation"/></b-input-group></b-col></b-form-row>
      <b-form-row md="4" sm="4" xs="4" class="mb-2"><b-col cols="12"><b-button variant="primary" class="w-100" :disabled="!!hasError" @click="createUser">Register</b-button></b-col></b-form-row>
      <b-form-row><b-col cols="12"><b-input-group class="w-100" ><b-form-text>Already registered</b-form-text> <b-button variant="link" href="#/login">Login</b-button></b-input-group></b-col></b-form-row>
    </b-form>
  </b-container>
</template>

<script>
import axios from '../common/axios';
export default {
  data() {
    return {
      errors: null,
      password: '',
      password_confirmation: '',
      email: ''
    }
  },
  computed: {
    hasError() {
      if (this.email!='' && this.password!='' && this.password_confirmation!='') {
        return false;
      }
      return true;
    }
  },
  methods: {
    createUser() {
        axios.post(`${process.env.ROOT_API}/login/register`, { email: this.email, password: this.password, password_confirmation: this.password_confirmation })
        .then((res) => {
          console.log(res.status);
          if(res.data.status == 422) {
            this.errors = 'Email registered';
          } else {
            this.$router.push('/login');
          }
        })
        .catch(err => {
          this.errors = err.response.data;
          console.log(err);
        })
      }
  }

}
</script>