<template>
  <div class="index">
    <div class="header">
      <!-- 左侧城市刘表 -->
      <div class="city">
        <div is-link @click="showP">
          <a href="javascrpt:;">
            <i></i>
            <span>{{ci}}</span>
          </a>
        </div>
        <van-popup v-model="show" position="left">
          <city v-on:getCity="getCity"></city>
        </van-popup>
      </div>
      <!-- 轮播图 -->
      <div class="banner">
        <van-swipe :autoplay="3000" indicator-color="#e8380d">
          <van-swipe-item v-for="(image, index) in swipers" :key="index">
            <img :src="image.curl" />
            <div :style="'color:'+image.textcolor">
              <p>{{image.btext}}</p>
              <p>{{image.stext}}</p>
            </div>
          </van-swipe-item>
        </van-swipe>
      </div>
    </div>
    <!--  -->
    <div class="section_aha">
      <div>
        <div>
          <p>尊贵礼遇享不停，升级aha会员</p>
          <p>
            预计可省¥358+，
            <a href="javascript:;">了解更多</a>
          </p>
        </div>
        <a href="javascript:;">立即开通</a>
        <div>
          <img src="../assets/index/ahaRights.png" alt />
        </div>
      </div>
    </div>
    <!-- 中部小轮播 -->
    <div class="content_banner">
      <van-swipe :autoplay="3000" indicator-color="#e8380d">
        <van-swipe-item>
          <img src="../assets/index/index_banner01.jpg" alt />
          <div>
            <p>至臻醇享 经典之作</p>
            <p>国际金奖加冕 口碑 TOP</p>
          </div>
        </van-swipe-item>
        <van-swipe-item>
          <img src="../assets/index/index_banner02.jpg" alt />
          <div>
            <p>先领券 后下单</p>
            <p>有优惠 更美味</p>
          </div>
        </van-swipe-item>
        <van-swipe-item>
          <img src="../assets/index/index_banner03.jpg" alt />
          <div>
            <p>想吃就要即时满足！</p>
            <p>囤进冰箱 甜点随心享</p>
          </div>
        </van-swipe-item>
      </van-swipe>
    </div>
    <!-- 商品列表 -->
    <div class="product-list module_h">
      <h2>
        <span>蛋糕推荐</span>
      </h2>
      <!-- 循环的DIV -->
      <div v-for="(pro,i) of products" :key="i">
        <a href="javascript:;">
          <img :src="`http://127.0.0.1:3000/public/img/details/${pro.index_img}`" alt />
        </a>
        <div :style="'color:'+pro.icolor">
          <p>{{pro.pname}}</p>
          <p>{{pro.ptext}}</p>
        </div>
      </div>
    </div>
    <!-- 企业兑换/卡券绑定/合作专区 -->
    <div class="section_others">
      <a href="javascript:;">企业兑换</a>
      <a href="javascript:;">卡券绑定</a>
      <a href="javascript:;">银行活动</a>
    </div>
    <!-- 评论 -->
    <div class="remark module_h">
      <h2>
        <span>热门评论</span>
      </h2>
      <div>
        <ul>
          <li>
            <div>
              <span>暂无评论</span>
            </div>
          </li>
        </ul>
      </div>
    </div>
    <div class="lecake_info">
      <div>
        <a href="javascript:;">电脑版</a>
        <a href="javascript:;">网站公告</a>
        <a href="javascript:;">经营资质</a>
      </div>
      <h3>
        copyright © 2010-2020 诺心lecake.com版权所有
        <br />诺心食品（上海）有限公司
        <a href="javascript:;">沪ICP备10211730号</a>
      </h3>
    </div>
    <!-- 底部导航栏 -->
    <tabber :active="'home'"></tabber>
  </div>
</template>

<script>
// 引入左侧城市组件
import city from "../components/city.vue";
import tabber from "../components/tabbar.vue";

export default {
  // 组件注册
  components: {
    city,
    tabber,
  },
  data() {
    return {
      // 控制城市显示与隐藏的变量
      show: false,
      swipers: "",
      products:'',
      ci:'成都',
    };
  },
  methods: {
    //  控制城市显示与隐藏的方法
    showP() {
      this.show = true;
    },
    getCity(val){
      this.ci=val
    },
    // 封装axios方法,不带参数
    getMsg(url) {
      return new Promise(resolve=>{
        this.$axios.get(url).then((result) => {
          return resolve(result.data);
        });
      })
    },
  },
  mounted() {
    this.getMsg('/index/banner').then(res=>{
      this.swipers=res;
    });
    this.getMsg('/index/pro').then(res=>{
      this.products=res;
    });
  },
};
</script>

<style>
div.index {
  padding-bottom: 0.5rem;
}
div.header {
  position: relative;
}
div.city {
  padding: 0 0.2rem 0 0.15rem;
  box-sizing: border-box;
  position: absolute;
  top: 0.17rem;
  width: 100%;
  z-index: 10;
}
div.city > div > a {
  position: relative;
  display: block;
  color: #ffffff;
  width: 0.3rem;
  height: 0.2rem;
  line-height: 0.2rem;
  padding-left: 0.3rem;
  background: rgba(0, 0, 0, 0.3);
  border-radius: 0.1rem;
}
div.city > div > a > i {
  display: inline-block;
  width: 0.3rem;
  height: 0.3rem;
  background: url("../assets/icons_5.png") -0.3rem -0.3rem no-repeat;
  background-size: 3rem 3rem;
  position: absolute;
  top: 50%;
  left: 0;
  margin-top: -0.15rem;
}
div.city > div > a > span {
  margin-left: -0.07rem;
}
div.banner {
  width: 100%;
}
img {
  width: 100%;
}
div.banner div.van-swipe-item > div {
  position: absolute;
  top: 78%;
  left: 0;
  width: 100%;
  padding: 0 0.1rem 0 0.2rem;
}
div.banner div.van-swipe-item > div::before {
  content: "";
  position: absolute;
  left: 0.1rem;
  top: 15%;
  width: 0.05rem;
  height: 0.2rem;
  background: #e8380d;
}
div.banner div.van-swipe-item > div > p:first-child {
  font-size: 0.24rem;
  font-weight: bolder;
}
div.banner div.van-swipe-item > div > p:last-child {
  font-size: 0.18rem;
}
div.section_aha {
  width: 100%;
  padding-top: 59.46%;
  position: relative;
  background: url("../assets/index/ahaPanelBg.jpg") center center no-repeat;
  background-size: 100% auto;
}
div.section_aha > div {
  position: absolute;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
}
div.section_aha > div > div:first-child {
  position: absolute;
  top: 30.8%;
  left: 5.2%;
  font-size: 0.14rem;
}
div.section_aha > div > div:last-child {
  width: 1.15rem;
  position: absolute;
  right: 10%;
  bottom: 13%;
}
div.section_aha > div > div:last-child img {
  width: 100%;
}
div.section_aha > div > div:first-child > p a {
  text-decoration: underline;
  color: #cea461;
}
div.section_aha > div > a {
  position: absolute;
  left: 5.2%;
  top: 65%;
  height: 28px;
  background: #cda366;
  line-height: 28px;
  padding: 0 0.16rem;
  color: #ffffff;
}
div.content_banner > div > div > div > div {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  left: 0;
  width: 100%;
  padding: 0 0.2rem;
}
div.content_banner > div > div > div > div > p:first-child {
  font-size: 0.18rem;
  font-weight: bolder;
  line-height: 0.24rem;
}
div.content_banner > div > div > div > div > p:last-child {
  font-size: 0.14rem;
}
div.product-list {
  font-size: 0.14rem;
  margin-top: 0.25rem;
}

div.module_h > h2 {
  font-weight: bolder;
  text-align: center;
  margin-bottom: 0.05rem;
}
div.module_h > h2 > span {
  display: inline-block;
  position: relative;
  padding: 0 0.1rem;
}
div.module_h > h2 > span::before,
div.module_h > h2 > span::after {
  content: "-";
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
}
div.module_h > h2 > span::before {
  left: 0;
}
div.module_h > h2 > span::after {
  right: 0;
}
div.product-list > div {
  position: relative;
  margin-top: 0.1rem;
}
div.product-list > div > a {
  display: block;
  padding-top: 66.7%;
}
div.product-list > div > a > img {
  position: absolute;
  left: 0;
  top: 0;
}
div.product-list > div > div {
  position: absolute;
  left: 0.1rem;
  top: 0.2rem;
  width: 70%;
  padding-left: 0.1rem;
  color: #fff;
}
div.product-list > div > div::before {
  content: "";
  position: absolute;
  left: 0;
  top: 0.025rem;
  width: 0.05rem;
  height: 0.15rem;
  background: #e8380d;
}
div.product-list > div > div > p:last-child {
  font-size: 0.12rem;
}
div.section_others {
  padding: 0.15rem 0.2rem;
  background: #ffffff;
  margin-top: 0.15rem;
  display: flex;
  justify-content: space-around;
}
div.section_others > a {
  width: 30%;
  position: relative;
  padding-top: 0.3rem;
  text-align: center;
  color: #3e3e3e;
}
div.section_others > a::before {
  content: "";
  position: absolute;
  width: 0.3rem;
  height: 0.3rem;
  background: url("../assets/icons_5.png") no-repeat center;
  background-size: 3rem 3rem;
  top: 50%;
  margin-top: -0.15rem;
  background-position: -1.2rem 0;
  margin-top: -0.25rem;
  left: 50%;
  margin-left: -0.15rem;
}
div.section_others > a:nth-child(2)::before {
  background-position: -1.5rem 0;
}
div.section_others > a:nth-child(3)::before {
  background-position: -1.8rem 0;
}

/* 评论 */
div.remark {
  margin: 0.25rem 0;
  padding: 0 0.2rem;
}
div.remark > div {
  position: relative;
  margin-top: 0.12rem;
}
div.remark > div > ul > li {
  padding: 24px 20px;
  border-radius: 3px;
  background: #ffffff;
  border: 1px solid #ccc;
}
div.remark > div > ul > li > div {
  text-align: center;
  line-height: 90px;
  height: 90px;
}
div.lecake_info {
  text-align: center;
  padding: 22px 0 8px;
  background: #e6e6e6;
}
div.lecake_info > div {
  width: 2.27rem;
  margin: auto;
  display: flex;
  justify-content: space-between;
}
div.lecake_info a {
  color: #3e3e3e;
}
div.lecake_info > div > a {
  display: block;
  width: 0.65rem;
  height: 20px;
  line-height: 20px;
  border: 1px solid #4a3234;
  font-size: 0.12rem;
}
div.lecake_info > h3 {
  font-size: 10px;
  color: #bababa;
  margin-top: 18px;
  line-height: 14px;
}
div.lecake_info > h3 > a {
  color: #bababa;
}
</style>