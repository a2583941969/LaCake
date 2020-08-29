<template>
  <div class="person-info">
    <div class="per-header">
      <router-link to="/mycenter"></router-link>
      <h1>个人信息</h1>
    </div>
    <div class="content">
      <!-- 头部 -->
      <div class="avatar_wrap">
        <input type="file" />
        <img src="http://127.0.0.1:3000/public/img/user/avatar.png" alt />
        <span>更改</span>
      </div>
      <!-- 手机号 -->
      <div class="form_item">
        <span>手机号：</span>
        <p>
          <span>18228631560</span>
        </p>
      </div>
      <!-- 性别 -->
      <div class="form_item more">
        <span>性&nbsp;&nbsp;别：</span>
        <p>
          <span>男</span>
        </p>
      </div>
      <!-- 生日 -->
      <div class="form_item more">
        <span>生&nbsp;&nbsp;日：</span>
        <p>
          <span>2000-1-16</span>
          <span>该信息我们将为您保密</span>
        </p>
      </div>
      <!-- 保存 -->
      <div class="save">
        <a href="javascript:;">保存</a>
      </div>
      <div class="logout">
        <a @click="logout">退出登录</a>
      </div>
    </div>
    <tabber :active="'mycenter'"></tabber>
  </div>
</template>

<script>
import tabber from "../components/tabbar.vue";
import { mapMutations } from "vuex";
export default {
  components: {
    tabber,
  },
  methods: {
  ...mapMutations(["set_isLogin", "set_phoneNum"]),
    logout() {
      localStorage.clear();
      this.set_isLogin(false);
      this.set_phoneNum('')
      this.$router.push('/')
    },
  },
};
</script>

<style>
div.per-header {
  height: 0.44rem;
  background: transparent;
}
div.per-header > a {
  position: absolute;
  width: 0.44rem;
  height: 0.44rem;
  left: 0;
  top: 0;
}
div.per-header > a::after {
  content: "";
  position: absolute;
  width: 0.2rem;
  height: 0.2rem;
  background: url("../assets/icons.png") no-repeat center;
  background-size: 2rem 2rem;
  top: 50%;
  margin-top: -0.1rem;
  background-position: -0.4rem -0.6rem;
  left: 0.1rem;
}
div.per-header > h1 {
  height: 0.44rem;
  line-height: 0.44rem;
  text-align: center;
  color: #a38d6b;
  font-size: 0.12rem;
}
div.content div.avatar_wrap {
  position: relative;
  width: 0.6rem;
  height: 0.6rem;
  margin: 0.3rem auto;
  background: #f9f9f9;
  border-radius: 50%;
}
div.content div.avatar_wrap input {
  z-index: 10;
  position: absolute;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  opacity: 0;
}
div.content div.avatar_wrap span {
  position: absolute;
  left: 50%;
  transform: translate(-50%, 0);
  bottom: -6%;
  display: inline-block;
  width: 0.35rem;
  height: 0.15rem;
  line-height: 0.15rem;
  text-align: center;
  border-radius: 0.01rem;
  font-size: 0.1rem;
  background: #9c9c9c;
  color: #ffffff;
}
div.content div.form_item {
  position: relative;
  width: 92%;
  margin: 0.1rem auto;
  padding: 0.12rem 0.1rem 0.12rem 0;
  font-size: 0.14rem;
  overflow: hidden;
  border-bottom: 1px solid #e0dcd1;
  box-sizing: border-box;
}
div.content div.form_item > span {
  width: 17%;
  float: left;
}
div.content div.form_item > p {
  float: left;
  width: 80%;
}
div.content div.form_item > p > span:nth-child(2) {
  float: right;
  color: #9c9c9c;
}
div.content div.more::after {
  content: "";
  position: absolute;
  width: 0.2rem;
  height: 0.2rem;
  background: url("../assets/icons.png") no-repeat center;
  background-size: 2rem 2rem;
  top: 50%;
  margin-top: -0.1rem;
  background-position: -1.4rem -0.2rem;
  right: 0;
}
div.content div.save {
  padding: 0.2rem 0;
  text-align: center;
}
div.content div.save a {
  display: inline-block;
  width: 60%;
  height: 40px;
  line-height: 40px;
  background: #ff4001;
  color: #ffffff;
  font-size: 12px;
  border: 1px;
  border-radius: 2px;
}
div.content div.logout {
  text-align: center;
  margin: 0.1rem 0;
}
div.content div.logout a {
  font-size: 12px;
  text-decoration: underline;
  color: #3e3e3e;
}
</style>