<template>
  <div id="app" class="app-container">
    <header-component />
    <router-view />
    <footer-component />
  </div>
</template>
<script>
import HeaderComponent from './Header.vue';
import FooterComponent from './Footer.vue';
export default {
  components: { HeaderComponent, FooterComponent }
}
</script>
<style scoped>
  #app {
    display: flex;
    flex-direction: column;
    width: 100%;
  }
</style>
