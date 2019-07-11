<template>
  <div class="row">
    <div class="card-body text-center" >
      <p v-cloak="">{{ message }}</p>
      <div class="container"> 
        <a href="http://www.eagertrekker.com/#/posts/yume-no-turibashi-the-dreaming-bridge">Japan</a>
        <img src="http://trekking-app.s3-ap-southeast-1.amazonaws.com/10603651_1714158508808583_1919393890660913503_n.jpg"/>
        
      </div>
    </div>
  </div>
</template>
  
<script>
export default {
  data: () => ({ message: 'Welcome you to E-G Trekker Blog' })
}
</script>
