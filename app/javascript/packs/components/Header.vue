<template>
  <div class="container">
    <div class="app-header">
      <div class="relative-search">
        <label for="search_query" class="sr-only">Search for:</label>
        <input placeholder="Search for..." name="search_query" type="text" class="form-control input-focus all-animate w-100 bg-white db shadow-inset-2 ba bw1 br2 pv3 pl4 pr6 lh-solid sans-serif b--gray3 fw6 f5 gray7"> <!----> 
        <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="search" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" class="o-15 absolute center-v right-1 pe-none svg-inline--fa fa-search fa-w-16 fa-fw fa-lg">
        <path fill="currentColor" d="M505 442.7L405.3 343c-4.5-4.5-10.6-7-17-7H372c27.6-35.3 44-79.7 44-128C416 93.1 322.9 0 208 0S0 93.1 0 208s93.1 208 208 208c48.3 0 92.7-16.4 128-44v16.3c0 6.4 2.5 12.5 7 17l99.7 99.7c9.4 9.4 24.6 9.4 33.9 0l28.3-28.3c9.4-9.4 9.4-24.6.1-34zM208 336c-70.7 0-128-57.2-128-128 0-70.7 57.2-128 128-128 70.7 0 128 57.2 128 128 0 70.7-57.2 128-128 128z" class=""></path></svg> 
      </div>
    </div>
  </div>
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
    display: inline-flex;
  }
  .search-box {
    width: 97%;
  }
</style>