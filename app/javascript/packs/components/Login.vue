<template>
  <div>
    <div v-if="showLogin">
      <div class="overlay" v-if="(!userAuthenticated)">
        <div class="close-btn pull-right">
          <i class="fa fa-2x fa-window-close" @click="closeLogin()"></i>
        </div>
        <b-form class="login-form">
          <b-col cols="12">
            <h4>Login information</h4>
          </b-col>
          <b-form-row md="12" sm="12" xs="10" class="mb-2">
            <b-col cols="12">
              <b-input-group>
                <b-form-input placeholder="User email" v-model="email" />
              </b-input-group>
            </b-col>
          </b-form-row>
          <b-form-row md="12" sm="12" xs="10" class="mb-2">
            <b-col cols="12">
              <b-input-group>
                <b-form-input type="password" placeholder="Password" v-model="password" />
              </b-input-group>
            </b-col>
          </b-form-row>
          <b-form-row md="12" sm="12" xs="10" class="mb-2">
            <b-col cols="12">
              <b-input-group>
                <b-button
                  variant="primary"
                  :disabled="!!hasError"
                  class="btn w-100"
                  @click="loginUser"
                >Login</b-button>
              </b-input-group>
            </b-col>
          </b-form-row>
          <b-col cols="12">
            Don't have an account? <b-link @click="showRegisterForm"> Register</b-link>
          </b-col>
        </b-form>
      </div>
    </div>
    <register-component></register-component>
  </div>
</template>
<script>
import axios from "axios";
import Vue from "vue";
import RegisterComponent from './Register';

export default {
  components: {RegisterComponent},
  data() {
    return { email: "", password: "", authenticated: false, errors: null };
  },
  computed: {
    showLogin() {
      return this.$store.state.showLogin;
    },

    userAuthenticated() {
      console.log(this.$store.state.authenticated);
      return this.$store.state.authenticated;
    },
    errorMessage() {
      return this.$store.state.errors.message;
    },
    hasError() {
      if (this.email != "" && this.password != "") {
        return false;
      }
      return true;
    }
  },

  methods: {
    showRegisterForm() {
      this.$store.dispatch('showRegisterForm', true);
    },
    closeLogin() {
      this.$store.dispatch("showLogin", false);
    },
    loginUser() {
      let email = this.email;
      let password = this.password;
      this.$store.dispatch("login", { email, password });
    }
  }
};
</script>
