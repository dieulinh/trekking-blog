<template>
  <b-container>
    <b-row v-for="(product, index) in products" :key="index">
      {{ product.name }}
    </b-row>
  </b-container>
</template>
<script>
export default {
  data: () => ({ products: [{name: 'Shoes', count: 12}]}),
  created: () => {
    console.log(this.$store);
  },
  mounted: () => {
    console.log('mounted products');
  }
}
</script>

