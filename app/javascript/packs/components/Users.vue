<template>
  <b-container>
    <div class="users-container">
        <div class="users-one-four" v-for="(user, index) in users" :key="index">
          <h3>
            ...And Get Your
            <strong>{{ user.role }}</strong> Now!
          </h3>
          <div class="free-good-product">
            <div v-html="user.description">
            </div>

            <img
              src="https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/6692447/90/60/m2/fpnw/wm0/1.-preview-image-01-.jpg?1563310818&amp;s=dd68e2f908b981d002f2eef71fd46021"
              alt="Lonely Lover Font"
            />
          </div>
        </div>
    </div>
  </b-container>
</template>
<script>
import axios from "../common/axios";
export default {
  data() {
    return {
      users: {},
      authenticated: false
    };
  },
  created() {
    axios
      .get(`${process.env.ROOT_API}/users`)
      .then(response => {
        this.users = response.data.trekkers;
      })
      .catch(err => {
        console.log(err);
      });
  }
};
</script>
