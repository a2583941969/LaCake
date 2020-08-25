<template>
  <div class="dessert">
    <mynavbar :display="'none'"></mynavbar>
    <div class="main">

    <div class="banner">
      <img src="../assets/dessert/banner.jpg" alt="">
    </div>
    <div class="pro-list">
      <pro-show
        v-for="(pro,i) of products"
        :key="i"
        :url="pro.img_show"
        :pname="pro.pname"
        :ptext="pro.ptext"
        :pid="pro.pid"
        :price="pro.pspecs[0].price"
      ></pro-show>
    </div>
    </div>
    <div class="bottom_text">
      <p>没有更多产品咯</p>
    </div>
    <tabber :active="'dessert'"></tabber>
  </div>
</template>
<script>
import city from "../components/city.vue";
import tabber from "../components/tabbar.vue";
import mynavbar from "../components/mynavBar.vue";
import proShow from "../components/proShow.vue";
export default {
  components: {
    city,
    tabber,
    mynavbar,
    proShow,
  },
  data() {
    return {
      // 保存商品信息的数组
      products: [],
    };
  },
  mounted() {
    this.$axios.get("/detail/prolist?iscake=0&taste=").then((res) => {
      // 对请求到的商品信息数据做处理
      res.data.forEach((e) => {
        // 图片展示路径前拼接  http://127.0.0.1:3000/public/img/details/
        e.img_show = "http://127.0.0.1:3000/public/img/details/" + e.img_show;
        // 将商品规格转为数组对象
        e.pspecs = JSON.parse(e.pspecs);
        this.products.push(e);
      });
    });
  },
};
</script>
<style>
div.dessert{
  padding-bottom: 0.5rem;
}
div.main{
  padding-top: 0.47rem;;
}
div.banner{
  padding:0 0.15rem;
  box-sizing: border-box;
}
div.dessert div.pro-list {
  padding: 0.15rem;
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
}
div.bottom_text {
  padding: 0.12rem 0 0.32rem;
  text-align: center;
}
div.bottom_text p{
      display: inline-block;
    width: 1.5rem;
    position: relative;
     font-size: 0.12rem;
}
div.bottom_text p::after,div.bottom_text p::before{
  content: '';
    position: absolute;
    width: 0.24rem;
    height: 1px;
    background: #9c9c9c;
    z-index: 1;
    top: 50%;
   
}
div.bottom_text p::before{
  left: 0;
}
div.bottom_text p::after{
  right: 0;
}
</style>



// PXtorem  阿里手淘移动端解决方案
//  Token
//  JSONP