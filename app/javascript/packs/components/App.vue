<template>
  <div id="app">
    <h1>Test App </h1>
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
</style>
