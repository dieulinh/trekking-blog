<template>
  <div>
    <div class="overlay" v-if="showForm">
      <div class="close-btn pull-right">
        <i class="fa fa-window-close" @click="closeRegisterForm()"></i>
      </div>
      <b-form class="login-form">
          <b-col cols="12">
            <h4>Register User Information</h4>
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
      errors: null,
      password: '',
      password_confirmation: '',
      email: ''
    }
  },
  computed: {
    showForm() {
      return this.$store.state.showRegisterForm;
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
          this.errors = err.response.data.message;
          console.log(err);
        })
      }
  }

}
</script>