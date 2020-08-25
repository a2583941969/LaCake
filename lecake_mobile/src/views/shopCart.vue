<template>
  <div class="shopcart">
    <div class="no-shop">
      <img src="../assets/cart/empty.png" alt />
      <p>您还没有选购您的商品</p>
    </div>
    <tabber :active="'shopcart'"></tabber>
  </div>
</template>

<script>
import tabber from "../components/tabbar.vue";

export default {
  components: {
    tabber,
  },
  data() {
    return {};
  },
};
</script>

<style>
div.shopcart > div.no-shop {
  position: relative;
  height: 2.2rem;
  text-align: center;
}
div.shopcart > div > img {
  width: 0.76rem;
  position: absolute;
  left: 50%;
  top: 0.6rem;
  margin-left: -0.42rem;
}
div.shopcart > div > p {
  position: absolute;
  width: 100%;
  top: 1.5rem;
  font-size: 0.1rem;
  color: #9c9c9c;
}
</style>