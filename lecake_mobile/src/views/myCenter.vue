<template>
  <div class="mycenter">
    <!-- 登录 -->
    <div class="main" v-if="!$store.state.isLogin">
      <div>
        <img src="http://127.0.0.1:3000/public/img/user/avatar.png" alt="/" />
      </div>
      <div>
        <router-link to="/login">登录</router-link>
      </div>
    </div>
    <div class="islogin" v-else>
      <!-- 头像 -->
      <div>
        <div class="avatar">
          <router-link to="/personinfo">
            <img src="http://127.0.0.1:3000/public/img/user/avatar.png" alt />
          </router-link>
        </div>
        <div class="info">
          <h3>
            <span>18228631560</span>
            <span>lv.1</span>
          </h3>
        </div>
      </div>
      <div class="vip_status">
        <a href="javascript:;">
          <p class="num">0</p>
          <p>aha值</p>
        </a>
        <a href="javascript:;">
          <p class="num">0</p>
          <p>我的优惠券</p>
        </a>
      </div>
    </div>
    <!-- 订单 -->
    <div class="order clear_fix">
      <p>我的订单</p>
      <a href="javascript:;">待付款</a>
      <a href="javascript:;">待发货</a>
      <a href="javascript:;">待收获</a>
      <a href="javascript:;">我的订单</a>
    </div>
    <!-- 会员购买或续费入口 -->
    <div class="vip">
      <a href="javascript:;">
        <img src="../assets/user/bg_not_aha.png" alt />
      </a>
      <div>
        <h3>
          <span>诺心aha会员</span>
          <span>尊享更多惊喜礼遇</span>
        </h3>
        <h3>立即开通</h3>
      </div>
    </div>
    <!-- 我的服务 -->
    <div class="serve clear_fix">
      <p>我的服务</p>
      <a href="javascript:;">生日助手</a>
      <router-link to="/personinfo">个人资料</router-link>
      <a href="javascript:;">储值卡专享兑换券</a>
      <a href="javascript:;">在线客服</a>
      <a href="javascript:;">我的发票</a>
      <a href="javascript:;">关于我们</a>
      <router-link to="/setpwd" v-if="$store.state.isLogin">设置密码</router-link>
    </div>
    <tabber :active="'mycenter'"></tabber>
  </div>
</template>
<script>
import tabber from "../components/tabbar.vue";

export default {
  components: {
    tabber,
  },
};
</script>
<style>
div.mycenter > div.main {
  text-align: center;
  padding: 0.15rem 0.14rem 0.1rem;
}
div.mycenter > div.main > div > img {
  width: 0.55rem;
  height: 0.55rem;
  border-radius: 50%;
}
div.mycenter > div.main > div:last-child {
  padding: 0.1rem 0 0.12rem;
}
div.mycenter > div.main > div a {
  display: block;
  margin: auto;
  width: 0.6rem;
  height: 0.24rem;
  line-height: 0.24rem;
  border-radius: 2px;
  background: #a38d6b;
  color: #ffffff;
  text-align: center;
  font-size: 0.12rem;
}
div.clear_fix {
  margin: 0.1rem 0.2rem;
  background: #ffffff;
  border-radius: 5px;
  font-size: 0.12rem;
}
div.clear_fix > p {
  padding: 0.1rem;

  border-bottom: 1px solid #f9f9f9;
}
div.clear_fix::after {
  content: "";
  display: block;
  clear: both;
}
div.clear_fix > a {
  float: left;
  width: 25%;
  height: 0.72rem;
  position: relative;
  padding-top: 0.4rem;
  text-align: center;
  margin: 0.1rem 0;
  color: #3e3e3e;
  box-sizing: border-box;
}
div.clear_fix > a::before {
  content: "";
  position: absolute;
  width: 0.4rem;
  height: 0.4rem;
  background: url("../assets/user/icons.png") no-repeat center;
  background-size: 2rem 2rem;
  background-position: 0 0;
  margin-top: -0.2rem;
  left: 50%;
  margin-left: -0.2rem;
  top: 0.24rem;
}
div.order > a:nth-child(3):before {
  background-position: -0.4rem 0;
}
div.order > a:nth-child(4):before {
  background-position: -0.8rem 0;
}
div.order > a:nth-child(5):before {
  background-position: -1.2rem 0;
}
div.vip {
  margin: 0.1rem 0.2rem;
  background: #ffffff;
  border-radius: 5px;
  position: relative;
}
div.vip > div {
  width: 65%;
  position: absolute;
  left: 50%;
  margin-left: -26%;
  top: 50%;
  transform: translateY(-50%);
  color: #ffffff;
}
div.vip > div > h3 > span {
  display: block;
  font-size: 0.13rem;
}
div.vip > div > h3:last-child {
  position: absolute;
  right: 0;
  top: 47%;
  transform: translateY(-50%);
  font-size: 10px;
}
div.serve > a:nth-child(2)::before {
  background-position: -1.6rem 0;
}
div.serve > a:nth-child(3)::before {
  background-position: -0.8rem -0.8rem;
}
div.serve > a:nth-child(4)::before {
  background-position: 0 -0.4rem;
}
div.serve > a:nth-child(5)::before {
  background-position: -1.2rem -0.4rem;
}
div.serve > a:nth-child(6)::before {
  background-position: -1.6rem -0.4rem;
}
div.serve > a:nth-child(7)::before {
  background-position: -0.4rem -0.8rem;
}
div.serve > a:nth-child(8)::before {
  background-position: -0.8rem -0.4rem;
}
div.mycenter div.islogin {
  padding: 0.3rem 0.2rem 0.24rem;
}
div.mycenter > div.islogin > div > div {
  float: left;
}
div.mycenter > div.islogin > div::after {
  content: "";
  display: block;
  clear: both;
}
div.mycenter > div.islogin > div > div > a > img {
  width: 0.55rem;
  height: 0.55rem;
  border-radius: 50%;
}
div.mycenter > div.islogin > div > div.info {
  position: relative;
  width: 75%;
  height: 0.55rem;
  float: left;
  margin-left: 0.12rem;
}
div.mycenter > div.islogin > div > div.info > h3 {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
}
div.mycenter > div.islogin > div > div.info > h3 > span:first-child {
  font-size: 0.11rem;
  font-weight: bold;
}
div.mycenter > div.islogin > div > div.info > h3 > span:last-child {
  padding: 1px 4px;
  margin-left: 0.1rem;
  line-height: normal;
  font-size: 9px;
  color: #ffffff;
  background: #a38d6b;
  border-radius: 2px;
}
div.mycenter > div.islogin > div.vip_status {
  margin-top: 0.2rem;
  display: flex;
  justify-content: space-around;
}
div.mycenter > div.islogin > div.vip_status > a {
  position: relative;
  display: block;
  color: #3e3e3e;
  font-size: 0.12rem;
  flex: 1;
}
div.mycenter > div.islogin > div.vip_status > a p {
  text-align: center;
}
div.mycenter > div.islogin > div.vip_status > a p.num {
  font-size: 0.15rem;
  font-weight: bolder;
}
</style>