<template>
  <div class="setpwd">
    <div>
      <p class="title">
        <span>设置密码</span>
      </p>
      <div>
        <p>
          <input type="password" maxlength="20" placeholder="请输入6-20位新密码" v-model="pwd" />
          <span>{{pwd_msg}}</span>
        </p>
        <p>
          <input type="password" maxlength="20" placeholder="确认密码" v-model="againPwd" />
          <span>{{againPwd_msg}}</span>
        </p>
        <p>
          <button @click="sub">确认</button>
        </p>
      </div>
    </div>
  </div>
</template>

<script>
import qs from "qs";

export default {
  data() {
    return {
      pwd: "",
      pwd_msg: "",
      againPwd: "",
      againPwd_msg: "",
    };
  },
  methods: {
    password() {
      if (!this.pwd) {
        this.pwd_msg = "*密码不能为空";
      } else {
        let reg = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$/;
        if (!reg.test(this.pwd.trim())) {
          this.pwd_msg = "密码只能是6-20位英文、数字组成";
          return false;
        } else {
          this.pwd_msg = "";
          return true;
        }
      }
    },
    sub() {
      if (this.password()) {
        if (!this.againPwd) {
          this.againPwd_msg = "*请确认密码";
        } else {
          if (this.againPwd !== this.pwd) {
            this.againPwd_msg = "密码不一致，请重新输入";
          } else {
            //发送请求
            this.$axios
              .post(
                "/user/pwd",
                qs.stringify({
                  account: this.$store.state.phoneNum,
                  pwd: this.pwd,
                }),
                {
                  headers: {
                    "Content-Type": "application/x-www-form-urlencoded",
                  },
                }
              )
              .then((res) => {
                if (res.data.code == 1) {
                  this.$toast("设置成功");
                  
                  this.$router.push("/mycenter");
                }
              });
          }
        }
      }
    },
  },
};
</script>

<style>
div.setpwd {
  padding-top: 0.3rem;
}
div.setpwd > div {
  width: 89%;
  margin: auto;
}
div.setpwd > div > p {
  font-size: 0.15rem;
}
div.setpwd > div > div {
  margin-top: 0.3rem;
}
div.setpwd > div > div > p > input {
  width: 100%;
  height: 0.5rem;
  text-indent: 0.1rem;
  border: 0;
  border-bottom: 1px solid #d1c6af;
  outline: 0;
}
div.setpwd > div > div > p > span {
  padding-left: 0.1rem;
  font-size: 0.12rem;
  color: #ff4001;
}
div.setpwd > div > div > p:last-child {
  margin-top: 0.5rem;
}
div.setpwd > div > div > p > button {
  width: 100%;
  height: 0.4rem;
  background: #ff4001;
  color: #ffffff;
  border: 0;
  outline: 0;
}
</style>