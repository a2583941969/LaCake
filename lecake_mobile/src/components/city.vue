<template>
  <div class="popub">
    <header>
      <h2>配送至</h2>
      <p>当前定位城市：{{city}}</p>
    </header>
    <div>
      <ul @click="changeCity">
        <li v-for="(city,i) of citys" :key="i" :data-city="city">
          <span>{{city}}</span>
        </li>
      </ul>
    </div>
    <footer>
      <a href="javascript:;">
        <i></i>
        查询收货地址是否可配送>
      </a>
    </footer>
  </div>
</template>
<script>
export default {
  data() {
    return {
      citys: [
        "上海",
        "北京",
        "广州",
        "南京",
        "成都",
        "深圳",
        "杭州",
        "苏州",
        "天津",
        "宁波",
        "无锡",
        "其他",
      ],
      city: "成都", 
    };
  },
  methods: {
    changeCity(e) {
      if (e.target.nodeName == "LI") {
        this.city = e.target.dataset.city;
        let spans = e.target.parentNode.getElementsByClassName("active");
        if (e.target.nodeName == "LI") {
          if (spans.length != 0) {
            spans[0].className = "";
          }
          e.target.children[0].className = "active";
        }
      this.$emit('getCity',this.city);
      }
    },
  },
};
</script>

<style>
.popub {
  width: 2.9rem;
  height: 100vh;
  background-color: #fff;
  padding: 0.1rem 0.18rem;
  box-sizing: border-box;
  overflow: hidden;
}
.popub > header {
  padding: 0.1rem 0;
  border-bottom: 1px solid #e0dcd1;
}
.popub > header h2 {
  font-size: 0.18rem;
  margin-bottom: 0.06rem;
  line-height: 2;
}
.popub > div {
  padding: 0.1rem 0 0.1rem 0.17rem;
  height: 75%;
  box-sizing: border-box;
  border-bottom: 1px solid #e0dcd1;
}
.popub > div ul {
  display: flex;
  flex-direction: column;
  height: 100%;
}
.popub > div ul li {
  position: relative;
  flex: 1;
}
.popub > div ul li span {
  padding-left: 0.13rem;
  position: absolute;
  top: 50%;
  transform: translate(0, -50%);
}
.popub > div ul li span.active::before {
  content: "";
  position: absolute;
  left: 0;
  top: 50%;
  transform: translateY(-50%);
  width: 0.03rem;
  height: 0.06rem;
  background: #e8380d;
}
.popub > footer {
  margin-top: 0.2rem;
  position: relative;
  padding-left: 0.3rem;
}
.popub > footer > a {
  color: #333;
}
.popub > footer > a > i {
  left: 0;
  content: "";
  position: absolute;
  width: 0.3rem;
  height: 0.3rem;
  background: url('../assets/icons_5.png') no-repeat center;
  background-size: 3rem 3rem;
  top: 50%;
  margin-top: -0.15rem;
  background-position: -2.1rem 0;
}
</style>