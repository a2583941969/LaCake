<template>
  <div class="pro">
    <div>
      <!-- :to="'/detail?pid='+pid" -->
      <a @click="goDetail">
        <img :src="url" alt />
      </a>
      <div class="item_detail">
        <div class="name_wrap">
          <h3>{{pname}}</h3>
          <p>{{ptext}}</p>
        </div>
        <p class="pro-price">
          ￥<span>{{price}}</span>
        </p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ["url", "pname", "ptext", "pid", "price","bool"],
  methods:{
    goDetail(){
      let url=window.location.href;
      if(url.indexOf('detail')+1){
        this.$emit('sad',this.pid);
        this.$router.push("/detail?pid="+this.pid)

      }else{
        this.$router.push("/detail?pid="+this.pid);
      }
    }
  }
};
</script>

<style>
div.pro {
  width: 48%;
  margin-bottom: 12px;
}
div.pro > div > a {
  position: relative;
  display: block;
  width: 100%;
  padding-top: 100%;
}
div.pro > div > a > img {
  position: absolute;
  left: 0;
  top: 0;
  width: 100%;
}
div.item_detail {
  position: relative;
  height: 0.68rem;
  padding: 0.02rem 0;
}
div.item_detail div.name_wrap {
  height: 50px;
  overflow: hidden;
}
div.item_detail div.name_wrap > h3 {
  padding: 0.02rem 0;
  font-size: 12px;
  line-height: 16px;
  overflow: hidden;
  white-space: initial;
  text-overflow: ellipsis;
}
div.item_detail div.name_wrap > p {
  margin-top: 2px;
  font-size: 10px;
  line-height: 12px;
  max-height: 24px;
  overflow: hidden;
  color: #9c9c9c;
}
div.item_detail > p.pro-price {
  font-size: 0.14rem;
  color: #cea461;
}
</style>