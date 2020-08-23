<template>
  <div class="navbar">
    <div class="navbar-item">
      <a href="javascript:;" class="left-btn" @click="showP">
        <i></i>
        <span>{{ci}}</span>
      </a>
      <h1 @click="textColor">
        <a href="javascript:;" class="active">综合</a>
        <a href="javascript:;" >销量</a>
        <a href="javascript:;" >季节限定</a>
      </h1>
      <a href="javascript:;" class="right-btn" :style="'display:'+display" @click="showFiltrate">
        <i></i>
        <span>筛选</span>
      </a>
    </div>
    <van-popup v-model="filtrateshow" position="right">
      <filtrate></filtrate>
    </van-popup>
    <van-popup v-model="cityshow" position="left">
      <city v-on:getCity="getCity"></city>
    </van-popup>
  </div>
</template>
<script>
import city from "./city.vue";
import filtrate from "./filtrate.vue"
export default {
  props:['display'],
  components: {
    city,
    filtrate
  },
  data() {
    return {
      cityshow: false,
      filtrateshow:false,
      ci: "成都",
    };
  },
  methods: {
    showP() {
      this.cityshow = true;
    },
    showFiltrate(){
      this.filtrateshow=true
    },
    getCity(val) {
      this.ci = val;
    },
    textColor(e){
      if(e.target.nodeName=="A"){
        let act=e.target.parentNode.getElementsByClassName("active")[0];
        act.className="";
        e.target.className="active"
      }
    }
  },
  computed:{
    
  }
};
</script>

<style>
div.navbar {
  width: 100%;
  height: 0.32rem;
  line-height: 0.32rem;
  position: fixed;
  z-index: 999;
  background-color: #fff;
  border-bottom: 1px solid #a38d6b;
}
div.navbar-item {
  position: relative;
}
div.navbar-item > a {
  color: #3e3e3e;
  font-size: 0.11rem;
  position: absolute;
  width: 0.3rem;
  height: 0.32rem;
  line-height: 0.32rem;
  left: 0.06rem;
  padding-left: 0.2rem;
  top: 50%;
  transform: translate(0,-50%);
  z-index: 11;
}
div.navbar-item > a > i {
  display: inline-block;
  position: absolute;
  width: 0.25rem;
  height: 0.25rem;
  background: url("../assets/icons_5.png") no-repeat center;
  background-size: 2.5rem 2.5rem;
  top: 50%;
  margin-top: -0.13rem;
  background-position: -2rem 0rem;
  left: 0;
}
div.navbar-item > a.right-btn {
  right: 0.06rem;
  left: auto;
}
div.navbar-item > a.right-btn > i {
  background-image: url("../assets/icons_1.png");
  background-position: -2.27rem -0.5rem;
}
div.navbar-item > h1 {
  position: relative;
  overflow: hidden;
  height: 0.32rem;
  line-height: 0.32rem;
  color: #3e3e3e;
  text-align: center;
}
div.navbar-item > h1>a{
      display: inline-block;
    margin-right: 0.3rem;
    color: #3e3e3e;
    font-size: 0.11rem;
}
div.navbar-item > h1>a:last-child{
  margin: 0;
}
div.navbar-item > h1>a.active{
  color: red;
}
</style>