<template>
  <nav class="w-100 navbar-fixed-top navbar-default white-bg">
    <ul class="w-40 nav navbar-nav navbar-right menu-fixed-top white-bg">
      <li class="active"><a href="/">Works</a></li>
      <li><a href="/#/posts">Blog</a></li>
      <li><a href="/#/login">Sign in</a></li>
      <li><a href="#aboutme">About</a></li>
    </ul>
  </nav><!-- /.navbar -->
</template>
<script>

export default {
  
}
</script>
<style scoped>
  .app-header {
    width: 100%;
    display: flex;
    flex-direction: row;
    margin-bottom: 20px;
    justify-content: flex-end;
    align-items: center;
  }
  .relative-search {
    display: flex;
    flex-direction: row;
    width: 50%;
  }
  .search-box {
    width: 97%;
  }
</style>