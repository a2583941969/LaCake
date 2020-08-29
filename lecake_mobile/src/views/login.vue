<template>
  <div class="login">
    <h2 @click="showLogin">
      <a href="javascript:;" :class="show ? 'active' : ''" :data-bool="true">手机一键登录</a>
      <a href="javascript:;" :class="show ? '' : 'active'" :data-bool="false">账号登录</a>
    </h2>
    <div class="phone" v-if="show">
      <div class="register_tips">
        <p>未注册的用户默认直接注册</p>
        <p>
          登录即代表您已同意
          <a href="javascript:;">《诺心lecake用户服务协议》</a>
        </p>
      </div>
      <div class="tab">
        <p>
          <input type="tel" maxlength="11" placeholder="请输入手机号" v-model="phone_num" />
          <span>{{phone_msg}}</span>
        </p>
        <p>
          <input type="text" maxlength="6" placeholder="请输入短信验证码" v-model="err_num" />
          <span>{{err_msg}}</span>
          <button @click="authCode" v-if="codeShow">发送验证码</button>
          <button v-else>{{codeTime}}秒后重试</button>
        </p>
      </div>
      <button class="btn" @click="signIn">验证并登录</button>
    </div>
    <div class="account" v-else>
      <div class="tab">
        <p>
          <input type="text" maxlength="11" placeholder="请输入手机号" v-model="rec" />
          <span>{{rec_msg}}</span>
        </p>
        <p>
          <input type="password" maxlength="30" placeholder="请输入密码" v-model="pwd" />
          <span>{{pwd_msg}}</span>
        </p>
      </div>
      <button class="btn" @click="login">登录</button>
    </div>
    <!-- 其他登录方式 -->
    <div class="more_login_type">
      <h3></h3>
      <div>
        <a href="javascript:;" class="qq"></a>
      </div>
    </div>
  </div>
</template>
<script>
import { Dialog } from "vant";
import qs from "qs";
import { mapMutations } from "vuex";
export default {
  components: {
    [Dialog.Component.name]: Dialog.Component,
  },
  data() {
    return {
      show: true,
      // 手机号
      phone_num: "",
      phone_msg: "",
      // 验证码
      err_num: "",
      err_msg: "",
      // 登录账号(手机号或邮箱)
      rec: "",
      rec_msg: "",
      // 密码
      pwd: "",
      pwd_msg: "",
      // 验证码时间
      codeTime: 60,
      codeShow: true,
      codeNum: "",
    };
  },
  methods: {
    ...mapMutations(["set_isLogin", "set_phoneNum"]),
    showLogin(e) {
      if (e.target.nodeName == "A") {
        this.show = e.target.dataset.bool;
      }
    },
    // 验证注册手机号
    checkPhone() {
      if (!this.phone_num) {
        this.phone_msg = "手机号码不能为空";
        return false;
      } else {
        let reg = /^1[3-9]\d{9}$/;
        if (!reg.test(this.phone_num.trim())) {
          this.phone_msg = "手机号码格式不正确";
          return false;
        } else {
          this.phone_msg = "";
          return true;
        }
      }
    },
    // 验证码
    authCode() {
      let bool = this.checkPhone();
      if (bool) {
        this.codeShow = false;
        setInterval(() => {
          this.codeTime--;
          if (this.codeTime <= 0) {
            this.codeShow = true;
            this.codeTime = 60;
          }
        }, 1000);
        this.$axios.get("/user/code").then((res) => {
          this.codeNum = res.data;
          console.log(res.data);
          setTimeout(() => {
            Dialog.alert({
              title: "信息",
              message: "【诺心蛋糕】您的验证码为:" + res.data,
            });
          }, 6000);
        });
      }
    },
    signIn() {
      if (this.checkPhone()) {
        if (!this.err_num) {
          this.err_msg = "请输入短信验证码";
        } else if (this.err_num.trim() != this.codeNum) {
          this.err_msg = "验证码有误";
        } else {
          this.err_msg = "";
          // 发送请求
          this.$axios
            .post(
              "/user/login",
              qs.stringify({
                phoneNum: this.phone_num,
              }),
              {
                headers: {
                  "Content-Type": "application/x-www-form-urlencoded",
                },
              }
            )
            .then((res) => {
              localStorage.setItem("isLogin", true);
              localStorage.setItem("phoneNum", this.phone_num);
              this.set_phoneNum(this.phone_num);
              this.set_isLogin(true);
              this.$router.push("/mycenter");
            });
        }
      }
    },
    // 验证登录时邮箱和手机号
    loginPhone() {
      if (!this.rec) {
        this.rec_msg = "用户名不能为空";
        return false;
      } else {
        let reg = /^1[3-9]\d{9}$/;
        if (!reg.test(this.rec.trim())) {
          this.rec_msg = "用户名格式不正确";
          return false;
        } else {
          this.rec_msg = "";
          return true;
        }
      }
    },
    login() {
      if (this.loginPhone()) {
        if (!this.pwd) {
          this.pwd_msg = "密码不能为空";
        } else {
          let reg = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$/;
          if (!reg.test(this.pwd.trim())) {
            this.pwd_msg = "密码只能是6-20位英文、数字组成";
          } else {
            this.pwd_msg = "";
            // 发送请求
            this.$axios
              .post(
                "/user/log",
                qs.stringify({
                  account: this.rec,
                  pwd: this.pwd,
                }),
                {
                  headers: {
                    "Content-Type": "application/x-www-form-urlencoded",
                  },
                }
              )
              .then((res) => {
                localStorage.setItem("isLogin", true);
                localStorage.setItem("phoneNum", this.rec);
                this.set_phoneNum(this.rec);
                this.set_isLogin(true);
                this.$router.push("/mycenter");
              });
          }
        }
      }
    },
  },
};
</script>
<style>
div.login {
  padding: 0.24rem 0.2rem 0;
}
div.login > h2 {
  position: relative;
  font-size: 0.13rem;
  margin-bottom: 0.12rem;
  line-height: 0.18rem;
}
div.login > h2::after {
  content: "";
  display: block;
  clear: both;
}
div.login > h2 > a:first-child {
  border-right: 1px solid #9c9c9c;
}
div.login > h2 > a {
  float: left;
  margin-right: 0.24rem;
  padding-right: 0.24rem;
  color: #3e3e3e;
}
div.login > h2 > a.active {
  color: #fe4320;
}
div.login div.phone > div.register_tips {
  color: #9c9c9c;
  font-size: 0.11rem;
  margin-bottom: 0.2rem;
  min-height: 0.12rem;
}
div.login div.phone > div.register_tips a {
  color: #fe4320;
}
div.login div.tab > p {
  position: relative;
  border-bottom: 1px solid #e1dbcc;
  margin-bottom: 0.2rem;
}
div.login div.tab > p::before {
  content: "";
  position: absolute;
  width: 0.2rem;
  height: 0.2rem;
  background: url("../assets/icons.png") no-repeat center;
  -webkit-background-size: 2rem 2rem;
  background-size: 2rem 2rem;
  top: 50%;
  margin-top: -0.1rem;
  background-position: -0.6rem -0.4rem;
  left: 0.06rem;
}
div.login div.tab > p:nth-child(2):before {
  background-position: -0.2rem -0.4rem;
}
div.login div.tab > p > input {
  width: 100%;
  border: 0;
  height: 0.4rem;
  padding: 0 0.32rem;
  outline: 0;
  resize: none;
  font-size: 0.12rem;
  margin: 0;
  font-family: inherit;
  line-height: inherit;
  box-sizing: border-box;
}
div.login div.tab > p > span {
  position: absolute;
  width: 100%;
  height: 0.2rem;
  line-height: 0.2rem;
  color: #fe4320;
  bottom: -0.2rem;
  left: 0;
  font-size: 0.11rem;
}
div.login div.tab > p > button {
  position: absolute;
  width: 0.92rem;
  height: 0.4rem;
  background: transparent;
  color: #3e3e3e;
  right: 0;
  bottom: 0;
  padding: 0;
  border: 0;
  outline: 0;
  font-size: 0.12rem;
}
div.login div.tab > p > button::before {
  content: "";
  position: absolute;
  width: 1px;
  height: 0.16rem;
  background: #fe4320;
  z-index: 1;
  left: 0;
}
div.login .btn {
  display: block;
  width: 100%;
  height: 0.4rem;
  background: #fe4320;
  font-size: 0.13rem;
  margin-top: 0.6rem;
  padding: 0;
  border: 0;
  outline: 0;
  color: #fff;
}
div.login div.more_login_type {
  position: absolute;
  width: 3rem;
  height: 0.8rem;
  left: 50%;
  margin-left: -1.5rem;
  bottom: 0.4rem;
}
div.login div.more_login_type > h3 {
  height: 20px;
  line-height: 20px;
  position: relative;
}
div.login div.more_login_type > h3::before {
  content: "";
  position: absolute;
  width: 100%;
  height: 1px;
  background: #e0dcd1;
  z-index: 1;
  top: 50%;
}
div.login div.more_login_type > h3::after {
  position: absolute;
  width: 100px;
  height: 20px;
  background: #ffffff;
  z-index: 1;
  content: "其他登录方式";
  top: 0;
  left: 50%;
  margin-left: -50px;
  color: #3e3e3e;
  text-align: center;
  font-size: 0.12rem;
}
div.login div.more_login_type > div {
  padding-top: 0.2rem;
  text-align: center;
}
div.login div.more_login_type > div > a {
  display: inline-block;
  width: 0.4rem;
  height: 0.4rem;
  border-radius: 100%;
  background: url("../assets/icon_social.png") no-repeat center;
  background-size: 0.4rem 4rem;
  background-position: 0 0;
  position: relative;
  margin-right: 0;
}
div.login div.account {
  margin-top: 0.32rem;
}
</style>