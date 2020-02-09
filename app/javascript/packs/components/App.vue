<template>
  <div id="app" class="app-container">
    <header-component />
    <router-view />
    <footer-component />
    <vue-progress-bar></vue-progress-bar>
  </div>
</template>
<script>
import HeaderComponent from './Header.vue';
import FooterComponent from './Footer.vue';
import VueProgressBar from 'vue-progressbar';
export default {
  components: { HeaderComponent, FooterComponent }
}
</script>

