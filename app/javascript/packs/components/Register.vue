<template>
  <div>
    <div class="overlay" v-if="showForm">
      <div class="close-btn pull-right">
        <span class="closeLogin" @click="closeRegisterForm()">
          <svg class="tcb-icon" viewBox="0 0 30 32" data-name="close">
            <path d="M0.655 2.801l1.257-1.257 27.655 27.655-1.257 1.257-27.655-27.655z"></path>
            <path d="M28.31 1.543l1.257 1.257-27.655 27.655-1.257-1.257 27.655-27.655z"></path>
          </svg>
        </span>
      </div>
      <b-form class="login-form">

          <b-col cols="12">
            <h4>Register User Information</h4>
          </b-col>
          <b-form-row md="12" sm="12" xs="10" class="mb-2" v-if="errors">
            <div class="alert alert-danger" role="alert">
              <strong>{{errors}}</strong>
            </div>
          </b-form-row>
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
                <b-form-input type="password" placeholder="Password Confirmation" v-model="password_confirmation" />
              </b-input-group>
            </b-col>
          </b-form-row>
          <b-form-row md="12" sm="12" xs="10" class="mb-2">
            <b-col cols="12">
              <b-input-group>
                <b-button
                  variant="primary"
                  :disabled="!!hasError"
                  class="w-100"
                  @click="createUser()"
                >Register</b-button>
              </b-input-group>
            </b-col>
          </b-form-row>
        </b-form>
    </div>
  </div>
</template>

<script>
import axios from '../common/axios';
export default {
  data() {
    return {
      password: '',
      password_confirmation: '',
      email: ''
    }
  },
  computed: {
    createSuccess() {
      return this.$store.state.user!= null;
    },
    showForm() {
      return this.$store.state.showRegisterForm || this.$store.state.errors !=null;
    },
    errors() {
      return this.$store.state.errors;
    },
    hasError() {
      if (this.email!='' && this.password!='' && this.password_confirmation!='') {
        return false;
      }
      return true;
    }
  },
  methods: {
    closeRegisterForm() {
      this.$store.dispatch("showRegisterForm", false);
    },
    createUser() {
        this.$store.dispatch('setError', null);
        this.$store.dispatch('createUser', { email: this.email, password: this.password, password_confirmation: this.password_confirmation });
        if (!this.errors)
        {
          this.closeRegisterForm();
        }
      }
  }
}
</script>
