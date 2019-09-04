<template>
  <div id="myMap">
  </div>
</template>
<script>

export default {
    name: "GoogleMap",
    data() {
      return {
        center: { lat: 10.38, lng: 106.723 },
        markers: []
      }
    },
    mounted() {
      this.map = new google.maps.Map(document.getElementById('myMap'), {
      center: {lat:10.659, lng: 106.7075},
      scrollwheel: false,
      zoom: 7
      })
    }
}
</script>
<style scoped>
  #myMap {
    height: 400px;
    width: 100%;
  }
</style>
