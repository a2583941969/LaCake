<template>
  <div class="filtrate">
    <div>
      <h2>筛选</h2>
      <div>
        <h2>口味</h2>
        <div @click="changeFiltrate">
          <span v-for="(taste,i) of tastes" :data-taste="taste" :key="i">{{taste}}</span>
        </div>
      </div>
      <footer @click="filtrate">
        <a data-text="reset">重置</a>
        <a>确定</a>
      </footer>
    </div>
  </div>
</template>
<script>
export default {
  props: ["filtrateshow", "taste"],
  data() {
    return {
      tastes: ["雪域口味", "巧克力味", "芝士口味", "慕斯口味", "奶油口味"],
      // t 用来保存当前选择的口味
      t: "",
    };
  },
  methods: {
    changeFiltrate(e) {
      if (e.target.nodeName == "SPAN") {
        const act = e.target.parentNode.getElementsByClassName("active");
        if (act.length !== 0) {
          act[0].className = "";
        }
        e.target.className = "active";
        this.t = e.target.dataset.taste;
      }
    },
    filtrate(e) {
      if (e.target.nodeName == "A") {
        this.$emit("showFiltrate");
        // 判断，如果用户点击的是重置，则将t改为空字符串传值
        if (e.target.dataset.text == "reset") {
          this.t = "";
        }
        this.$parent.$parent.$emit("changeTaste", this.t);
      }
    },
  },
};
</script>
<style>
div.filtrate {
  height: 100vh;
  width: 2.75rem;
}
div.filtrate > div {
  width: 100%;
  height: 100%;
  position: relative;
}
div.filtrate > div > h2 {
  font-size: 0.14rem;
  color: #a38d6b;
  height: 0.44rem;
  line-height: 0.44rem;
  border-bottom: 1px solid #d1c6af;
  padding-left: 0.16rem;
}
div.filtrate > div > div > h2 {
  font-size: 0.14rem;
  padding: 0.16rem;
  color: #939393;
  box-sizing: border-box;
  line-height: 0.2rem;
}
div.filtrate > div > div > div::after {
  content: "";
  display: block;
  clear: both;
}
div.filtrate > div > div > div > span {
  display: inline-block;
  margin-left: 3.25%;
  width: 29%;
  cursor: pointer;
  text-align: center;
  margin-bottom: 0.12rem;
  color: #9c9c9c;
  font-size: 0.12rem;
  line-height: 0.25rem;
  box-sizing: border-box;
}
div.filtrate > div > div > div > span.active {
  border: 1px solid #a38d6b;
  border-radius: 0.02rem;
}

div.filtrate > div > footer {
  position: absolute;
  width: 100%;
  height: 0.4rem;
  border-top: 1px solid #a38d6b;
  left: 0;
  bottom: 0;
}
div.filtrate > div > footer > a {
  width: 50%;
  float: left;
  text-align: center;
  line-height: 0.4rem;
  font-size: 0.12rem;
  color: #a38d6b;
}
div.filtrate > div > footer > a:last-child {
  color: #ffffff;
  background: #a38d6b;
}
</style>