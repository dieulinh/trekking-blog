<template>
  <div>
    <b-row>
      <b-col cols="3">Login</b-col>
      <b-col cols="4"></b-col>
      <b-col cols="4"></b-col>
    </b-row>

    <b-button @click="showAlert" variant="info" class="m-1">
      Show alert with count-down timer
    </b-button>
    <b-button @click="showDismissibleAlert=true" variant="info" class="m-1">
      Show dismissible alert ({{ showDismissibleAlert ? 'visible' : 'hidden' }})
    </b-button>
  </div>
</template>
<script>
  import BootstrapVue from 'bootstrap-vue';
  export default {
    
  }
</script>
