<template>
  <div class="tabbar">
    <van-tabbar v-model="act" active-color="red">
      <van-tabbar-item
        v-for="(value,i) of tabbar"
        :name="value.name"
        :key="i"
        :to="value.path"
        :badge="i==3?shopCount:''"
      >
        <span>{{value.text}}</span>
        <template #icon="props">
          <img :src="props.active ? value.icon.active : value.icon.inactive" />
        </template>
      </van-tabbar-item>
    </van-tabbar>
  </div>
</template>

<script>
export default {
  props: ["active"],
  data() {
    return {
      // 控制城市显示与隐藏的变量
      show: false,
      act: this.active,
      tabbar: [
        {
          name: "home",
          text: "首页",
          path: "/",
          icon: {
            active: require("../assets/tabBar/index01.png"),
            inactive: require("../assets/tabBar/index.png"),
          },
        },
        {
          name: "birthday",
          text: "生日蛋糕",
          path: "/cake",
          icon: {
            active: require("../assets/tabBar/birthday01.png"),
            inactive: require("../assets/tabBar/birthday.png"),
          },
        },
        {
          name: "dessert",
          text: "甜点心礼",
          path: "/dessert",
          icon: {
            active: require("../assets/tabBar/dessert01.png"),
            inactive: require("../assets/tabBar/dessert.png"),
          },
        },
        {
          name: "shopcart",
          text: "购物袋",
          path: "/shopcart",
          icon: {
            active: require("../assets/tabBar/shopcart01.png"),
            inactive: require("../assets/tabBar/shopcart.png"),
          },
        },
        {
          name: "mycenter",
          text: "我的",
          path: "/mycenter",
          icon: {
            active: require("../assets/tabBar/my01.png"),
            inactive: require("../assets/tabBar/my.png"),
          },
        },
      ],
    };
  },
  computed:{
    shopCount(){
      return this.$store.state.shopcart.length>0?this.$store.state.shopcart.length:'';
    }
  }
};
</script>
<style>
div.van-hairline--top-bottom > div > div > img {
  width: 0.3rem;
  height: 0.3rem;
}
div.van-tabbar {
  border-top: 1px solid #d1c6af;
  height: calc(.54rem + env(safe-area-inset-bottom));
}
div.van-tabbar-item {
  font-size: 0.12rem;
}
div.van-tabbar-item__text {
  margin-bottom: 8px;
}
div.van-info {
  top: 5px;
  -webkit-transform: translate(28%, -50%);
  transform: translate(28%, -50%);
}
</style>